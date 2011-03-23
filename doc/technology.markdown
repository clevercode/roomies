# Technology
## Server-side
1. Ruby 1.9.2
2. Rails 3.0.x
  1. Haml
  2. Sass
  3. Compass
  4. Formtastic (lots of forms, helps with Internationalization)
  5. Devise (we'll test our own system in Rails Tutorial, but we need
     something solid for production)
  7. OmniAuth for Facebook, Twitter authentication.
  8. [MongoDB](http://www.mongodb.org/) with [Mongoid ODM](http://mongoid.org/docs/installation/) & [rspec integration](https://github.com/evansagge/mongoid-rspec)
  9. [Chronic](https://github.com/mojombo/chronic) parses natural language for time and date & [Tickle](https://github.com/noctivityinc/tickle) for natural language recurring events parsing.
  10. [Vanity](https://github.com/assaf/vanity) A/B testing framework
      with lightweight DSL.

## Client-side
### JavaScript
1. Automatic text input to formatted date [DateJS](http://www.datejs.com/). Used on [Hipmunk](http://hipmunk.com)
2. CoffeeScript (classy JS)
3. Backbone.js (simple MVC JS framework)
3. jQuery 1.5.x (for AJAX promises)
4. HTML5 localStorage, look at Yehuda Katz's [jQuery Offline](https://github.com/wycats/jquery-offline)
5. [AmplifyJS](http://amplifyjs.com/api/store/) could be a perfect cross-platform solution even without
   HTML localStorage http://amplifyjs.com/api/store/
6. [YepNope](https://github.com/SlexAxton/yepnope.js) client-side conditional loader

