Feature: Document tool
  In order to use the document tool
  The teachers should be able to create and upload files

  Background:
    Given I am a platform administrator
<<<<<<< HEAD

  Scenario: Create a folder
    Given I am on "/main/document/document.php?cidReq=TEMP&createdir=1"
    Then I should see "Create folder"
    And I fill in the following:
      | dirname | My new directory |
    And I press "Create the folder"
    Then I should see "Folder created"

  Scenario: Create a folder that already exists
    Given I am on "/main/document/document.php?cidReq=TEMP&createdir=1"
    Then I should see "Create folder"
    And I fill in the following:
      | dirname | My new directory |
    And I press "Create the folder"
    Then I should see "Unable to create the folder"

  Scenario: Create a simple document
    Given I am on "/main/document/create_document.php?cidReq=TEMP"
    Then I should see "Create a rich media page / activity"
    Then I fill in the following:
      | create_document_title   | My first document                       |
    And I fill in ckeditor field "content" with "This is my first document!!!"
    And I press "Create a rich media page / activity"
    Then I should see "Item added"
    And I should see "My first document"
    Then I follow "My first document"
    And wait for the page to be loaded
    Then I should see "My first document"

  Scenario: Create a HTML document
    Given I am on "/main/document/create_document.php?cidReq=TEMP"
    Then I should see "Create a rich media page / activity"
    Then I fill in the following:
      | create_document_title   | My second document                       |
    And I fill in ckeditor field "content" with "<a href='www.chamilo.org'>Click here</a><span><strong>This is my second document!!!</strong></span>"
    And I press "Create a rich media page / activity"
    Then I should see "Item added"
    And I should see "My second document"
    Then I follow "My second document"
    And wait for the page to be loaded
    Then I should see "My second document"
    And I should not see "<strong>"
    And I should not see "www.chamilo.org"

  Scenario: Upload a document
    Given I am on "/main/document/upload.php?cidReq=TEMP"
    Then I should see "Upload documents"
    Then I follow "Upload (Simple)"
    Then I attach the file "web/css/base.css" to "file"
    When I press "Upload file"
    And wait for the page to be loaded
    Then I should see "File upload succeeded"

#  Scenario: Create cloud link
#    Given I am on "/main/document/add_link.php?cidReq=TEMP"
#    Then I should see "Add a link"
#    And I fill in the following:
#      | name | My dropbox link |
#      | url | http://dropbox.com/sh/loremipsum/loremipsum?dl=0 |
#    And I press "Add link to Cloud file"
#    Then I should see "Cloud link added"
=======
    And I am on course "TEMP" homepage
    Then I follow "Document"
    And wait the page to be loaded when ready

  Scenario: Create a folder
    Then I should see "New folder"
    Then I press "New folder"
    Then I fill in the following:
      | title | My new directory |
    And I press "Save"
    And wait for the page to be loaded
    Then I should see "saved"

  Scenario: Create a folder that already exists
    Then I should see "New folder"
    Then I press "New folder"
    And I fill in the following:
      | title | My new directory |
    And I press "Save"
    And wait for the page to be loaded
    Then I should see "saved"

  Scenario: Create a text document
    Then I press "New document"
    And wait for the page to be loaded
    Then I fill in the following:
      | Title   | My first document |
    And I fill in tinymce field "item_content" with "This is my first document!"
    And I press "Submit"
    And wait for the page to be loaded
    Then I should see "created"
    And I should see "My first document"
    And wait for the page to be loaded

  Scenario: Create a HTML document
    Then I press "New document"
    And wait for the page to be loaded
    Then I fill in the following:
      | Title   | My second document |
    And I fill in tinymce field "item_content" with "<a href='www.chamilo.org'>Click here</a><span><b>This is my second document!!</b></span>"
    And I press "Submit"
    And wait for the page to be loaded
    Then I should see "created"
    And I should see "My second document"

  Scenario: Upload a document
    Then I press "Upload"
    And wait for the page to be loaded
    Then I should see "Drop files here"
    Then I attach the file "/public/favicon.ico" to "files[]"
    Then I press "Upload 1 file"
    And wait for the page to be loaded
    Then I should see "Complete"
    Then I move backward one page
    And wait for the page to be loaded
    Then I should see "favicon.ico"

#  Scenario: Search for "My second document" and edit it
#    Then I press "Search"
#    Then I fill in the following:
#      | search_filter | My second document |
#    Then I press "Filter"
#    And wait for the page to be loaded
#    Then I should not see "My first document"
#    Then I press "Info"
#    Then I should see "My second document"
#    Then I press "Edit"
#    And wait for the page to be loaded
#    Then I fill in the following:
#      | item_title | My second document edited |
#    Then I press "Submit"
#    And wait very long for the page to be loaded
#    Then I should see "updated"
#    Then move backward one page
#    And I should see "My second document edited"
#
#  Scenario: Search for "My first document" and delete it
#    Then I press "Search"
#    Then I fill in the following:
#      | search_filter | My first document |
#    Then I press "Filter"
#    And wait very long for the page to be loaded
#    Then I should see "My first document"
#    Then I press "Info"
#    And wait for the page to be loaded
#    Then I should see "My first document"
#    Then I press "Delete"
#    And wait for the page to be loaded
#    And I press "Yes"
#    And wait for the page to be loaded
#    Then I should see "Deleted"


#  Scenario: Delete simple document
#    Then I follow "document"
#    Then I press "File upload"
#    And wait for the page to be loaded
#    Then I follow "My first document"
#    Then I should see "Created at"
#    Then I follow "Delete"
#    Then I should see "Deleted"
#    And I should not see "My first document.html"
>>>>>>> master
