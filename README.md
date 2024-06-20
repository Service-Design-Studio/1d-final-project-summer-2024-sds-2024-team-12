# Auto-Prompt System for DBS Digibank App

## Overview

This project aims to develop an Auto-Prompt system for the DBS Digibank app. The system tracks user transactions and actions within the app and suggests shortcuts based on frequently performed tasks, allowing users to schedule payments or create shortcuts with a single click.

## Getting Started

Follow these instructions to get the project up and running on your local machine for development and testing purposes.

### Prerequisites

Ensure you have the following installed on your system:
- Ruby (version X.X.X)
- Rails (version X.X.X)
- PostgreSQL
- Node.js
- Yarn

### Installation

1. **Clone the repository:**
   ```sh
   git clone -b master --single-branch https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-12.git
   cd 1d-final-project-summer-2024-sds-2024-team-12
   ```

2. **Install dependencies:**
   ```sh
   bundle install
   yarn install
   ```

3. **Set up the database:**
   ```sh
   rails db:create
   rails db:migrate
   ```

4. **Start the Rails server:**
   ```sh
   rails s
   ```

   Visit `http://localhost:3000/` in your browser.

## zq's Notes

### Repository Cloning
```sh
git clone -b master --single-branch https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-12.git
```

### Start the Server
```sh
rails s
```

Access the app at: [http://localhost:3000/](http://localhost:3000/)

### Commands

- **Generate a new Rails app with React and PostgreSQL:**
  ```sh
  rails new try2 --webpack=react
  rails new try1 --webpack=react --database=postgresql -T
  ```

- **Install Webpacker and React:**
  ```sh
  rails webpacker:install
  rails webpacker:install:react
  ```

- **Add necessary gems in Gemfile:**
  ```ruby
  gem "webpacker"
  gem "react-rails"
  ```

- **Generate a new controller and views:**
  ```sh
  rails g controller home index
  ```

- **Generate a scaffold for transactions:**
  ```sh
  rails g scaffold transactions name:string amount:decimal
  rails db:migrate
  ```

### Routing

Edit `config/routes.rb` to set the root route:
```ruby
root 'home#index'
```

---
### Cucumber Test cases

  ```sh
Auto-pompt   Feature: Auto-prompt through app suggestions   
As a mother with a daughter I want to schedule payment to my daughter
So that I can promptly send money to her monthly 

Scenario 1: User makes a Paynow payment (successful, happy)
Given I am on the home page on the DBS Digibank app
When I want to send pocket money to my daughter
Then I should see a Paynow icon
When I press the Paynow button
Then I should see a new transaction page When I fill in the name text box with my daughter's name
And I fill in the transaction amount 
When I submit by pressing ‘Transfer Now’
Then I should see that the transaction I made has been successfully created

Scenario 2: User wants to view their past transaction history 
Given I am on the home page on the DBS Digibank app
When I made a transaction
Then I should see it updated under my Transaction history
And I am able to see the transaction details for each transfer

Scenario 3: User views the Auto Prompt Suggestions Carousel
Given I am on the home page on the DBS Digibank app
When I try to make more weekly transactions to my daughter
Then I should see a ‘schedule payment’ suggestions at the top of the page
in a carousel form 

Scenario 4: User accepts the suggestion from the Auto Prompt Suggestions Carousel
Given I am on the home page on the DBS Digibank app
When I follow the ‘Set up’ button
Then I should see a pop up suggesting to me to either create a smart shortcut widget to my ‘Pay and Transfer’ page 
or just go straight to schedule payments


Scenario 5: User chooses to schedule payment option
Given I choose to just schedule payment 
When I follow the ‘Schedule payment’ button
Then I should see a page to fill in the name of my daughter and transfer amount
And choose the date I want to schedule payment to her

 
Scenario 6: User chooses the smart shortcut option
Given that I pick the smart shortcut option
When I follow the ‘Make quick shortcut’ button
Then I should see a form to enter shortcut widget name and the icon of the widget 
And create the widget which would be placed on my home page
When I tap on the widget, it should lead me to a prefilled pay and transfer page







Sad scenario 1: Users unable to leave name blank
Given I am on the ‘New Transactions’ page
When I do not fill in the name of recipient
Then I should see an input error 
And I am not allowed to transfer money until I fill in a name  

Sad scenario 2: Users unable to put negative transfer amount
Given I am on the ‘New Transactions’ page
When I fill in a negative transfer amount
Then I should see an input error 
And I am not allowed to transfer money until I input a positive value

Sad scenario 3: User chooses neither
Given I don’t want to heed the suggestion
When I press the cross button
Then I should see the pop up disappear 

Sad scenario 4: User wants to remove widget
Given I am on the Pay and Transfer page on the DBS Digibank app
When I press the delete button
Then I should see my widget being deleted


  ```
