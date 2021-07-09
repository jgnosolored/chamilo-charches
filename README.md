# Chamilo 2.x

<<<<<<< HEAD
![PHP Composer](https://github.com/chamilo/chamilo-lms/workflows/PHP%20Composer/badge.svg?branch=1.11.x)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/chamilo/chamilo-lms/badges/quality-score.png?b=1.11.x)](https://scrutinizer-ci.com/g/chamilo/chamilo-lms/?branch=1.11.x)
=======
[![PHP Composer](https://github.com/chamilo/chamilo-lms/workflows/PHP%20Composer/badge.svg)](https://github.com/chamilo/chamilo-lms/actions?query=workflow%3A%22PHP+Composer%22+branch%3Amaster)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/chamilo/chamilo-lms/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/chamilo/chamilo-lms/?branch=master)
>>>>>>> master
[![Bountysource](https://www.bountysource.com/badge/team?team_id=12439&style=raised)](https://www.bountysource.com/teams/chamilo?utm_source=chamilo&utm_medium=shield&utm_campaign=raised)
[![Code Consistency](https://squizlabs.github.io/PHP_CodeSniffer/analysis/chamilo/chamilo-lms/grade.svg)](http://squizlabs.github.io/PHP_CodeSniffer/analysis/chamilo/chamilo-lms/)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/166/badge)](https://bestpractices.coreinfrastructure.org/projects/166)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/88e934aab2f34bb7a0397a6f62b078b2)](https://www.codacy.com/app/chamilo/chamilo-lms?utm_source=github.com&utm_medium=referral&utm_content=chamilo/chamilo-lms&utm_campaign=badger)

Chamilo is an e-learning platform, also called "LMS" or "LCMS" published under GNU/GPLv3+. It is or has been used by more than 20M people worldwide.

## Quick install

**Chamilo 2.0 is still in development stage. This installation procedure is for reference only. For a stable Chamilo, please install Chamilo 1.11.x. See the 1.11.x branch README.md for details.**

<<<<<<< HEAD
To run Chamilo, you will need at least a web server (we recommend Apache2 for commodity reasons), a database server (we recommend MariaDB but will explain MySQL for commodity reasons) and a PHP interpreter (and a series of libraries for it). If you are working on a Debian-based system (Debian, Ubuntu, Mint, etc), just
type
```
sudo apt-get install apache2 mysql-server php libapache2-mod-php php-gd php-intl php-curl php-json php-mysql php-zip composer
```
=======
We assume you already have: 
>>>>>>> master

- composer 2.x - https://getcomposer.org/download/
- yarn 2.x - https://yarnpkg.com/getting-started/install
- Configuring a virtualhost in a domain, not in a sub folder inside a domain.
- A working LAMP server.

On a fresh Ubuntu, you can prepare your server by issuing an apt command like the following:

~~~~
apt update && apt -y upgrade && apt install apache2 libapache2-mod-php mariadb-client mariadb-server php-pear php-dev php-gd php-curl php-intl php-mysql php-mbstring php-zip php-xml php-cli php-apcu php-bcmath php-soap yarn git unzip npm
~~~~

Otherwise, you can use the following directly:

~~~~
git clone https://github.com/chamilo/chamilo-lms.git chamilo2
cd chamilo2
composer install

yarn set version berry
yarn install
yarn run encore dev
chmod -R 777 .
~~~~

Note: on Ubuntu Groovy, the `yarn` package has been replaced by `yarnpkg`. In this case, replace `yarn` by `yarnpkg` in all commands above.

Then enter the **main/install/index.php** and follow the UI instructions (database, admin user settings, etc).

After the web install process, change the permissions back to a reasonably safe state:
~~~~
chmod -R 755 .
chown -R www-data: public/ var/
~~~~

### Quick update

If you have already installed it and just want to update it from Git, do:
~~~~
git pull
composer update

# Database update
php bin/console doctrine:schema:update --force
    
# js/css update
yarn install
yarn run encore dev
~~~~
This will update the JS (yarn) and PHP (composer) dependencies in the public/build folder.

<<<<<<< HEAD
```
composer update
```

If you face issues related to missing JS libraries, you might need to ensure
that your web/assets folder is completely re-generated.
Use this set of commands to do that:
```
rm composer.lock
rm -rf web/ vendor/
composer clear-cache
composer update
```
This will take several minutes in the best case scenario, but should definitely
generate the missing files.

### Change permissions

On a Debian-based system, launch:
```
sudo chown -R www-data:www-data app main/default_course_document/images main/lang web
```

### Configure the web server

Enable the Apache web server module "rewrite" :
```
sudo a2enmod rewrite
sudo systemctl restart apache2.service
```

Chamilo's .htaccess must be obeyed.
Create /etc/apache2/conf-available/htaccessForChamilo.conf with these lines :
```
<Directory /var/www/html/chamilo-lms>
	AllowOverride All
</Directory>
```

then enable it :
```
sudo a2enconf htaccessForChamilo
sudo systemctl reload apache2.service
```

If you just installed missing PHP extensions using apt, you must restart the web server to get them loaded :
```
sudo systemctl restart apache2.service
```

### Start the installer

In your browser, load the Chamilo URL. You should be automatically redirected 
to the installer. If not, add the "main/install/index.php" suffix manually in 
your browser address bar. The rest should be a matter of simple
 OK > Next > OK > Next...

## Upgrade from 1.10.x

1.11.0 is a major version. It contains a series of new features, that
also mean a series of new database changes in regards with versions 1.10.x. As 
such, it is necessary to go through an upgrade procedure when upgrading from 
1.10.x to 1.11.x.

The upgrade procedure is relatively straightforward. If you have a 1.10.x 
initially installed with Git, here are the steps you should follow 
(considering you are already inside the Chamilo folder):
```
git fetch --all
git checkout origin 1.11.x
```

Then load the Chamilo URL in your browser, adding "main/install/index.php" and 
follow the upgrade instructions. Select the "Upgrade from 1.10.x" button to 
proceed.

If you have previously updated database rows manually, you might face issue with
FOREIGN KEYS during the upgrade process. Please make sure your database is
consistent before upgrading. This usually means making sure that you have to delete
rows from tables referring to rows which have been deleted from the user or access_url tables.
Typically:
<pre>
    DELETE FROM access_url_rel_course WHERE access_url_id NOT IN (SELECT id FROM access_url);
</pre>

### Upgrading from non-Git Chamilo 1.10 ###

In the *very unlikely* case of upgrading a "normal" Chamilo 1.10 installation (done with the downloadable zip package) to a Git-based installation, make sure you delete the contents of a few folders first. These folders are re-generated later by the ```composer update``` command. This is likely to increase the downtime of your Chamilo portal of a few additional minutes (plan for 10 minutes on a reasonnable internet connection).

```
rm composer.lock
rm -rf web/*
rm -rf vendor/*
```


# For developers and testers only

This section is for developers only (or for people who have a good reason to use
a development version of Chamilo), in the sense that other people will not 
need to update their Chamilo portal as described here.

## Updating code

To update your code with the latest developments in the 1.11.x branch, go to
your Chamilo folder and type:
```
git pull origin 1.11.x
```
If you have made customizations to your code before the update, you will have
two options:
- abandon your changes (use "git stash" to do that)
- commit your changes locally and merge (use "git commit" and then "git pull")

You are supposed to have a reasonable understanding of Git in order to
use Chamilo as a developer, so if you feel lost, please check the Git manual
first: http://git-scm.com/documentation

## Updating your database from new code

Since the 2015-05-27, Chamilo offers the possibility to make partial database
upgrades through Doctrine migrations.

To update your database to the latest version, go to your Chamilo root folder
and type
```
php bin/doctrine.php migrations:migrate --configuration=app/config/migrations.yml
```

If you want to proceed with a single migration "step" (the steps reside in
src/Chamilo/CoreBundle/Migrations/Schema/V110/), then check the datetime of the
version and type the following (assuming you want to execute Version20150527120703)
```
php bin/doctrine.php migrations:execute 20150527120703 --up --configuration=app/config/migrations.yml
```

You can also print the differences between your database and what it should be by issuing the following command from the Chamilo base folder:
```
php bin/doctrine.php orm:schema-tool:update --dump-sql
```
=======
### Quick re-install

If you have it installed in a dev environment and feel like you should clean it up completely (might be necessary after changes to the database), you can do so by:

* Removing the `.env.local`
* Load the {url}/main/install/index.php script again

The database should be automatically destroyed, table by table. In some extreme cases (a previous version created a table that is not necessary anymore and creates issues), you might want to clean it completely by just dropping it, but this shouldn't be necessary most of the time.

## Installation guide (Dev environment, stable environment not yet available)

If you are a developer and want to contribute to Chamilo in the current development branch (not stable yet), 
then please follow the instructions below. Please bear in mind that the development version is NOT COMPLETE at this time, 
and many features are just not working yet. This is because we are working on root components that require massive changes to the structure of the code, files and database. As such, to get a working version, you might need to completely uninstall and re-install from time to time. You've been warned.

First, apply the procedure described here: [Managing CSS and JavaScript in Chamilo](assets/README.md) (in particular, make sure you follow the given links to install all the necessary components on your computer).

Then make sure your database supports large prefixes (see [this Stack Overflow thread](https://stackoverflow.com/questions/43379717/how-to-enable-large-index-in-mariadb-10/43403017#43403017) if you use MySQL < 5.7 or MariaDB < 10.2.2).

Load the (your-domain)/main/install/index.php URL to start the installer (which is very similar to the installer in previous versions). 
If the installer is pure-HTML and doesn't appear with a clean layout, that's because you didn't follow these instructions carefully. 
Go back to the beginning of this section and try again.
 
## Changes from 1.x

* app/Resources/public/assets moved to public/assets
* main/inc/lib/javascript moved to public/js
* main/img/ moved to public/img
* main/template/default moved to src/CoreBundle/Resources/views
* src/Chamilo/XXXBundle moved to src/CoreBundle or src/CourseBundle
* bin/doctrine.php removed use bin/console doctrine:xyz options
* Plugin images, css and js libs are loaded inside the public/plugins folder
  (composer update copies the content inside plugin_name/public inside web/plugins/plugin_name
* Plugins templates use asset() function instead of using "_p.web_plugin"
* Remove main/inc/local.inc.php

Libraries 

* Integration with Symfony 5 
* PHPMailer replaced with Swift Mailer
* bower replaced by [yarn](https://yarnpkg.com)

## JWT Authentication

* php bin/console lexik:jwt:generate-keypair
* In Apache setup Bearer with:

`SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1`

Get the token:

`curl -k -X POST -H "Content-Type: application/json" https://example.com/api/authentication_token -d '{"username":"admin","password":"admin"}'`

The response should return something like:

`{"token":"MyTokenABC"}`

Go to:

https://example.com/api

Click in "Authorize" and write

`Bearer MyTokenABC`

Then you can make queries using the JWT token.

## Todo

See https://github.com/chamilo/chamilo-lms/projects/3
>>>>>>> master

## Contributing

If you want to submit new features or patches to Chamilo 2, please follow the
Github contribution guide https://guides.github.com/activities/contributing-to-open-source/
and our [CONTRIBUTING.md](CONTRIBUTING.md) file.
In short, we ask you to send us Pull Requests based on a branch that you create
with this purpose into your repository forked from the original Chamilo repository.

## Documentation

For more information on Chamilo, visit https://campus.chamilo.org/documentation/index.html

## Notes

You can install Yarn on Ubuntu following the instructions at https://linuxize.com/post/how-to-install-yarn-on-ubuntu-18-04/
You can install Composer on Ubuntu following the instructions at https://getcomposer.org/download/
