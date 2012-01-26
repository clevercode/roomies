# Roomies

## Introduction

Do you ever find a note on the fridge from a roommate upset about something you apparently forgot to? Do you ever get those passive-aggressive text messages reminding you to do something you already know about? Do you ever forget a roommate is throwing a party and come home to Cirque du Soleil? Do you ever find yourself in the awkward situation of having to remind someone you did them a favor?

No more. Say hi to Roomies.

Roomies is a task & expense management application – with a few extra goodies – that makes living together feel a bit more fun and lot less out of control.

Roomies uses game elements to make house tasks less tedious and gives incentives to the roommates who get things done around the house. It makes living together easier.

## Development

### Requirements

- MRI Ruby 1.9.3
- Bundler: >= 1.1
- MongoDB: >= 2.0
- Pow

### Setup

``` sh
git clone git@github.com:clevercode/roomies.git
bundle install --path vendor --binstubs
cd ~/.pow && ln -s path/to/roomies roomies && cd -
```

### Notes

- The app will run without Pow, however some things like TypeKit fonts, mailer
links, and OAuth redirects will not work because they assume that the app is at
http://roomies.dev

- Gem dependencies will be installed into vendor/ruby, this means we don't need
RVM gemsets.

- Gem binaries are linked into the bin/ directory. Use them in place of the system
gems. 

``` sh
bin/rake
bin/mailcatcher
bin/foreman
```

### Troubleshooting

- Make sure MongoDB is running `mongod --quiet`
- Restart the server with `touch tmp/restart.txt`

## Testing

Simply run `bin/guard` 

### Requirements

The JavaScript & Acceptance tests have special requirements

- phantomjs `brew install phantomjs`
- qt `brew install qt`


