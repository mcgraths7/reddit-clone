# Readme 

This is a bare bones attempt to build a version of Reddit entirely in Ruby on Rails (no external JS)

## Requirements

This project was built using Ruby 2.6.6 and Rails 5.2.3

## Setup instructions

Clone the repository

Navigate to the directory

bundle

bundle exec rails db:setup

This will generate the database as well as some seed data so it's not completely empty

The server can be run with "bundle exec rails s"

## Current Feature set

Currently, the home page is set to your feed, which is a collection of posts from topics you are subscribed to

You can upvote/downvote posts and comments

Child comments appear below parent comments on the post page

You can subscribe and unsusbscribe from topics

Karma is calculated on posts and comments, and propogated up to the user under "post_karma" and "comment_karma"

## Planned feature set

* Add a "popular" page, which is similar to feed, but tracks all topics

* Add the ability to cross post to other topics

* Send messages to other users

* Restyle to be less bootstrappy (unlikely)