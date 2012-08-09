## SpreeGarbageCleaner

[![Build Status](https://secure.travis-ci.org/nebulab/spree-garbage-cleaner.png?branch=master)](http://travis-ci.org/nebulab/spree-garbage-cleaner)

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/nebulab/spree-garbage-cleaner)

This extension cleans your Spree database from unneeded data.
When your website grows, it could be useful to delete these old records to improve database performance.

**Important notice:** This extension can delete a lot of stuff from your database. It is thought to be used with some default Spree behaviors so be sure to know what you are doing, expecially if your app has a lot of custom stuff!

### What does this garbage contain?

#### Incomplete orders

By default incomplete orders are kept even if they are not completed.
This extension searches for incomplete orders and deletes them and their 
dependent association instances:

- line items
- payments
- shipments
- return authorizations
- adjustments

#### Anonymous users

When (not logged in) users begin to add items to cart, an anonymous user is
created and associated to the new order. This extension deletes all old
anonymous users that have never completed orders.

## Installation

Add the gem to your Gemfile:

```ruby
gem 'spree_garbage_cleaner', :git => 'git://github.com/nebulab/spree-garbage-cleaner.git'
```

Run bundle:

```bash
bundle
```

## Usage

To verify presence of garbage in your database run the stats rake task:

```
rake db:garbage:stats
```

To delete garbage from your database run the cleanup rake task:

```
rake db:garbage:cleanup
```

## Configure the number of days after which records are considered garbage

For each model that collects garbage records you can choose after how many days those records are marked as garbage. Default value is 7 (one week). 
To change this default value you can run from the rails console:

```ruby
Spree::GarbageCleaner::Config.set(:cleanup_days_interval, 10)
```

## Setup a cronjob to cleanup garbage

You can setup a cronjob that periodically runs the cleanup rake task for you. Just add the `whenever` gem to your Gemfile and this to your `config/schedule.rb`:

```
every 1.day, :at => '5:00 am' do
  rake "-s db:garbage:cleanup"
end
```

## Testing

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012 NebuLab, released under the New BSD License
