# Table of Contents

- [Getting Started](#getting-started)
- [Installation](#installation)
- [Files](#Files)
- [Features](#Features)
	- Suggestive Button(
		- Overseas Payment Detection
		- Frequent Transactions
		- Nearing Card Limit
	- AI-powered Help Bar
- [Cucumber Testing](#Cucumber-Testing)
- [Contributions](#Contributions)

# Getting Started

Follow these instructions to get the project up and running on your local machine for development and testing purposes.

### Prerequisites

**Ensure you have the following installed on your system:**
- Ruby (version 3.2.4)
- Rails (version 7.0.8)

### Installation

1. **Clone the repository:**
```sh
   git clone https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-12.git
```
2. **Change directory to the project file:**
```sh
	cd 1d-final-project-summer-2024-sds-2024-team-12
```
3. **Install dependencies:**
   ```sh
   bundle install
   ```

4. **Set up the database:**
   ```sh
   rails db:create
   rails db:migrate
   ```

5. **Start the Rails server:**
   ```sh
   rails s
   ```

   Visit `http://localhost:3000/` in your browser.

# Files

These are the key folders are stored in the `app` folder and its directory is shown in the diagram below:
```
app/
├── assets/
│ ├── images/
│ ├── stylesheets/
├── controllers/
├── javascript/
├── models/
└── views/
```

### Folder Descriptions

- **assets/**: This directory contains assets like images and stylesheets files.
    - **images/**: Stores image files used in the application.
    - **stylesheets/**: Contains CSS or SCSS files for styling the application.
    
- **controllers/**: Controllers handle the web requests from the users, process the data through the models, and pass the results to the views for rendering.
    
- **javascript/**: This directory holds JavaScript files that add interactivity to the application.
    
- **models/**: Models are used to handle the business logic of the application, interacting with the database. They represent the data structure and relationships between different entities.
    
- **views/**: Views are templates that render the user interface of the application. They take the data passed by controllers and display it to the users, usually in HTML format.
    

Each of these directories plays a crucial role in the Model-View-Controller (MVC) architecture of our Ruby on Rails application, ensuring a clean separation of concerns and a well-organized codebase.

**config/routes.rb**
The `config/routes.rb` file is where the routes are defined for the Rails application.
## Cucumber Features

`.features folder`

The features folder stores the .feature files that is required for Cucumber testing. Each feature file describe the behavior of the software through scenarios. Each scenario outlines a specific use case or test case. The purpose of these files are to provide a clear and common understanding of how the software should behave from a functional standpoint.

`step_definitions folder`

The Step definition folder contains the actual automation code that implements the behavior described in the .feature files. Each step in a .feature scenario corresponds to a step definition in a JavaScript. 

# Features

This section encompasses a guided demonstration of the features that have been integrated into the DBS App.

First, sign up with a phone number (7-15 characters), and pin (6 digits)
and then sign in.
## Suggestive Button
**Predictive Suggestions**
Anticipates user needs based on behavior, offering timely prompts and actions.

**Enhanced Assistance**
Suggests actions such as adjusting transfer limits, creating shortcuts/schedules for frequent payments, and making suggestions based on location.

**Guide to using the PromptPay suggestion:** 
1. On the Homepage, locate the Suggestive Button on the bottom-right of the screen.
2. Click on it.
3. A modal should open up.
4. You should see a suggestion to use PromptPay. (We assume that you are in Thailand)
5. Press 'Proceed to PromptPay'
6. Try out the PromptPay feature, its like PayNow, you have to key in a 9 digit phone number for the recipient, and after you key in the amount, the webapp will automatically convert it to Thai Baht.
7. Press 'Confirm'

**To trigger the card limit suggestion:**
 1. On the Homepage, click on the PayNow icon under Smart Shortcuts.
 2. Enter the Recipient number or name
 3. Enter the amount to be $450 to $500
 4. Press 'NEXT'
 5. Press 'Make another Transfer'
 6. You will be directed back to the Homepage
 7. Press the Suggestive Button on the bottom-right of the screen.
 8. You should see a suggestion to change your Card Limit.
 9. Press 'Change my Card Limit'
 10. You will be directed to the Local Transfer Limit page.
 
**To trigger the frequent transactions suggestion:**
1. On the Homepage, click on the PayNow icon under Smart Shortcuts.
2. Enter the Recipient number or name
3. Enter the amount
4. Press 'NEXT'
5. Press 'Make another Transfer'
6. You will be directed back to the Homepage
7. Repeat for 2 more times.
8. On the third time, you should see a pop up, making a suggestion for you to 'Make a Scheduled Transaction' or 'Make a Quick Shortcut'
9. Press either one.

**Guide to making a Scheduled Transaction:**
1. When going from the suggestions, the Recipient name or number will be auto-filled
2. You will have to select the Start Date and Frequency
3. Press 'Save'
4. On the Homepage, click on the 'Transfers Scheduled' icon under Smart Shortcuts.
5. You can check and delete your current Scheduled Transactions there.

**Guide to making a Quick Shortcut:**
1. When going from the suggestions, the Recipient name or number will be auto-filled
2. You will have to type in a nickname.
3. Press 'Save'
4. You will be redirected to the Pay & Transfer Page.
5. You can check and delete your current Quick Shortcuts there.
6. Press on the Shortcut.
7. You will be redirected to the PayNow Page with the Recipient name or number auto-filled

## AI-powered Help Bar
**Natural Language Commands**
Simply type commands to navigate directly to the relevant page.

**Actionable Results**
Enjoy automatic pre-filled information for quick and accurate transactions.

**Guide to using the Help Bar:**
1. On the Homepage, press the Help Bar located at the top.
2. You can also press the voice-button for voice recognition.
3. Type or speak 'change limit'
4. Press the Search icon
5. You will be redirected to the Local Transfer Limit Page
6. Press the '<' back button to go back to the Home Page
7. You can also type or speak 'Pay Nicole 100' and press the Search icon
8. You will be redirected to the PayNow Page with the Recipient name or number auto-filled

# Cucumber Testing

Cucumber testing is a type of behavior-driven testing framework that focuses on enabling collaboration between developers, testers, and domain experts in order to define and automate the testing of software's behavior. For our project, we use Cucumber to test the features based on the scenarios we have written in the .features files. <br>

To run the tests:
```shell
bundle exec cucumber
```

# Contributions

- Jeslyn Jingxi Wang
- Nicole Cheah Ching Suan
- Nikhil Aaron Mani (rip)
- Tan Zi Hui
- Turrag Dewan
- Khoo Zi Qi
