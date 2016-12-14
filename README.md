## Our Big Kitchen App [![Build Status](https://travis-ci.org/alaphao/obk-web.svg?branch=master)](https://travis-ci.org/alaphao/obk-web)
Our Big Kitchen ([OBK](http://www.obk.org.au)) is an amazing non-profit organization, based in Bondi, Sydney, Australia.
Its industrial kitchen is certified (Kosher, Halal, HACCP), and anyone from the community can cook food, either for those
who need it the most, or to start their own food business.

It is maintained by the generous donations from friends, sponsors and companies, but mainly by volunteers who
contribute with their time, skills and energy.

In order to make it very easy for anyone to find when they can help and put their hands up for volunteering, we are donating our time and coding skills to create the OBK App.

### Goals
* Help OBK to grow by developing the its app
* Create a community of coders that wants to make a difference by doing donating their time for good causes
* Give the opportunity for students to be involved in a real project while enhancing their coding skils

## Stack / Config
* Ruby 2.3.0
* Rails 5 (API mode)
* Angular 2
* PostgreSQL

## Quick setup
1. Fork and clone the repository
* `bundle install`
* Make sure PostgreSQL is running
* `rails db:create && rails db:migrate`
* `rails s`
* Now the rails server should be running at `localhost:3000`
* Go to the folder `client`
* `npm start`
* Now the angular app should be running at `localhost:4200`


* To test the api, send the requests to `localhost:3000`
* To access the web app with ui access `localhost:4200`

## Ways to get involved

### Contributing with code
1. Fork the repository
2. Solve an issue
3. Send a pull request referencing the issue

### Testing and reporting bugs
You can contribute by creating issues if you find any bugs or flaws

### Suggesting enhancements for this README
Please, feel free to suggests enhancements for this README
