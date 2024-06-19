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
