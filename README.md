SpreeGarbageCleaner
===================

Introduction goes here.

Installation
============

Add the gem to your Gemfile:

```ruby
gem 'spree_garbage_cleaner', :git => 'git://github.com/nebulab/spree-garbage-cleaner.git'
```

Run bundle:

```bash
bundle
```

Configure number of days after models are considered garbage
------------------------------------------------------------

For each model for which Spree collects garbage records you can choose after how many days those records are marked as garbage. Default value is 7 (one week). 
To change this default value you can run from the rails console:

```ruby
Spree::GarbageCleaner::Config.set(:cleanup_days_interval, 10)
```

Testing
=======

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012 NebuLab, released under the New BSD License
