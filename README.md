# rspec_circ_manager
## Description
This is the official automation for NYPL Circ Manager.

## Overview
### Folder "spec/admin_form"
This folder contains test specs for administration forms present in the Circ Manager.

All administration forms present in Circ Manager are covered by this test suite EXCEPT for the following forms:
* Search (or Search service configuration)

### Folder "pages"
This folder contains relevant page objects used in testing specs in automation framework.

The two main pages covered in test suite include:
| Page Name | File Name | 
| --------- | --------- |
|Login|circ_login_page.rb|
|Administrative Portal|circ_admin_page.rb|

Additionally, page objects for administrative forms are present in circ_admin_page.rb folder.

## How to Run Automation
From the root project folder, one can run the following command to run ALL automation with local Chrome browser:
```
rspec 
```
To run ALL automation headlessly, run the following command:
```
app_type=headless rspec
```
The above commands are meant to run all test specs. To run one file by name, follow this example:
```
```

## Future Work

## How to Contribute
