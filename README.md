## README

Hi, This project is a [Rails](http://rubyonrails.org/) application for the [money_back](https://money-back.herokuapp.com/) project.
You can access the admin area [HERE](https://money-back.herokuapp.com/admin), using that credentials
* login: - admin@admin.com
* password: - admin123

## Prerequisites

Have the following features with their respective versions installed on the machine:

* Ruby `2.7.1` - You can use [RVM](http://rvm.io)
* PostgreSQL 12
  * OSX - `$ brew install postgresql` or install [Postgress.app](http://postgresapp.com/)
  * Linux - `$ sudo apt-get install postgresql`
  * Windows - [PostgreSQL for Windows](http://www.postgresql.org/download/windows/)
* Bundler `2.1.4`

## Setup the project

After you get all the [prerequisites](#prerequisites), simply execute the following commands in sequence:

```bash
1. Install the dependencies above
2. $ git clone  # Clone the project
3. $ cd user_upload # Go into the project folder
4. $ gem install bundler # Bundler install
5. $ bin/bundle install # Install the gem dependencies
7. $ bin/rake db:create ; bin/rake db:migrate ; bin/rake db:seed # Reset and seed the database
8. $ bin/rspec # Run the specs to see if everything is working fine
```

## Running the project

1. `$ rake start` - Opens the server
2. Open [http://localhost:3000](http://localhost:3000)

#### Running specs and checking coverage
To run the tests it is necessary to have the [prerequisites](#prerequisites) and have also completed the [installation](#installation) of dependencies.

`$ bin/bundle rspec` to run the specs.

`$ coverage=on bin/bundle rspec` to generate the coverage report then open the file `coverage/index.html` on your browser.

## Thanks for the opportunity :+1:
