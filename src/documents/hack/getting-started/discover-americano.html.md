---
title: "Discover Americano"
layout: "default"
category: "hack"
menuOrder: 5
toc: true
---

# Discover Americano

The more your application grows, the harder it is to maintain. [Express.js](http://expressjs.com/) is incredibely powerful, but lacks at helping the developer structuring their code. In order to facilitate development without sacrifying maintainability, let's try [Americano](https://github.com/frankrousseau/americano) the framework that makes Express.js more opinionated about configuration and code organization without making it a magician hat ("magic" when it comes to coding is never a good idea).

Americano extends Express: everything that works with Express will work out of the box with Americano. It's really just a matter of convention!

Also, Americano is modular, so you can extend it with plugins. That's what we did with the JugglingDB ODM that comes with the americano-cozy plugin that we are going to use here.

### What you will achieve

* Learning a new framework without losing the work you've made so far, by making the bookmark app you've built an Americano app with no effort.
* Learning how to painlessly structure your code and improve your capacity to maintain your code.

### Source code
The source code of this tutorial can be found [here](https://github.com/cozy/cozy-tutorial/tree/americano).

### Getting stated
In a brand new application folder, install americano:
```bash
mkdir bookmark-americano && cd bookmark-americano/
npm install americano --save
npm install americano-cozy --save # the plugin that will handle database stuff
```

Then put the following in the server.js file:
```javascript
// ./server.js
var americano = require('americano');

var port = process.env.PORT || 9250;
americano.start({name: 'yourapp', port: port});
```
We're done! We said no effort, but still!

## File structure
Americano constrains the way your file structure should be, let's see how:

* client/ - all your client files (templates...)
* public/ - all your public assets (images, css, javascript)
* server/
    * controllers/ - we'll come back on what controllers are
        * routes.js - we'll come back on what the router is
    * models/ - we'll see how to define a model
        * requests.js - where you put the requests to access your data
    * config.js - Americano configuration
* package.json : holds your app information and dependencies
* server.js : the application starter

Note that Americano makes the "server" structure mandatory but let you do whatever you want with the client/public folders.

You might recognize familiar concepts: Model, Controller and somehow the View. It is important you understand that even if Americano doesn't actually put shiny MVC into Express, it brings separation of concerns to application, which is what really matters.

Start by creating the architecture, then we'll move on the models' creation.

## Define the models
The models folder allows you to put the doctype definition in separate files. Let's take the code we previously had in server.js and move it to `server/models/bookmark.js`:

```javascript
americano = require('americano');

// The americano plugin wraps the "db.define" JugglingDB function in a simpler "getModel" call
module.exports = Bookmark = americano.getModel('bookmarks', {
  "id": String,
  "title": String,
  "url": { "type": String, "default": ""}
});

// You can easily define here some helpers or method for bookmarks
```

Then move to server/models/requests.js so we can define the request we are going to use. The nice part of the Cozy plugin for americano is that it makes requests declaration very clear:

```javascript
module.exports =
  bookmark: {
    all: function(doc) {
      emit(doc._id, doc);
    }
  };
```

This will **automatically** trigger the old "Bookmark.defineRequest" when the server starts. Americano's Cozy plugin knows that the "all request" is often the same and offers this handy shortcut:

```javascript
americano = require('americano');

module.exports =
  bookmark: {
    all: americano.defaultRequests.all
  };
```

You can now add a helper to your bookmark model (we'll use it in the next section):
```javascript
// server/models/bookmark.js

Bookmark.all = function(callback) {
  Bookmark.request("all", {}, function(err, bookmarks) {
    callback(null, bookmarks);
  });
};

```

Now let's focus on the business logic of your application.

## Organize your code with Controllers

Create the bookmark controller: server/controllers/bookmarks.js
```javascript
Bookmark = require('../models/bookmark');

module.exports.list = function(req, res) {
  Bookmark.all(function(err, bookmarks) {
    if(err != null) {
      res.send(500, "An error has occurred -- " + err);
    }
    else {
      data = {"bookmarks": bookmarks}
      res.render('index.jade', data, function(err, html) {
        res.send(200, html);
      });
    }
  });
};

// We define a new route that will handle bookmark creation
module.exports.add = function(req, res) {
  Bookmark.create(req.body, function(err, bookmark) {
    if(err != null) {
      res.send(500, "An error has occurred -- " + err);
    }
    else {
      res.redirect('back');
    }
  });
};

// We define another route that will handle bookmark deletion
module.exports.delete = function(req, res) {
  Bookmark.find(req.params.id, function(err, bookmark) {
    if(err != null) {
      res.send(500, "Bookmark couldn't be retrieved -- " + err);
    }
    else if(bookmark == null) {
      res.send(404, "Bookmark not found");
    }
    else {
      bookmark.destroy(function(err) {
        if(err != null) {
          res.send(500, "An error has occurred -- " + err);
        }
        else {
          res.redirect('back');
        }
      });
    }
  });
};
```

We basically copied and pasted what was in the old server.js, and removed the
"which URL will trigger that action" part to focus on the code itself.

You probably noticed the "require" instruction. It loads the bookmark model we

defined earlier. More precisely, it loads what has previously been module.exports'ed (this
is NodeJS stuff, abuse that to create small modules of code).

Don't hesitate to split your code in multiple coherent controllers (one for
bookmarks, one for tags, ...)!

## Routing

There is still one very important missing thing, the routes. The routes are the
"which URL will trigger which action" information.

We put them in a dedicated file, so you don't have to look at every single
controllers when you are looking for a specific piece of code. Just check the
routes, they are the map of your application.

Americano **automatically** handles their loading when the server starts and
makes their syntax handy:

```javascript
// ./server/controllers/routes.js

var bookmarks = require('./bookmarks');

module.exports = {
  '': {
    get: bookmarks.list
  },
  'add': {
    post: bookmarks.add
  },
  'delete/:id': {
    get: bookmarks.delete
  }
};
```
Please note that every "route" is **automatically** prefixed by a '/' so you don't need to put it yourself.

You can also bind different HTTP verbs to the same route:
```javascript
// this example will not work with the code you have, you must change the template for that
module.exports = {
  'bookmarks': {
    get: bookmarks.list
    post: bookmarks.add
  },
};
```

## Configuration
Now our application should already be working but there is one thing we left aside: configuration.

Again, Americano will provide you a handy syntax and loads everything **automatically** at start:
```javascript
// ./server/config.js

var americano = require('americano');

module.exports = {
  common: [
    americano.bodyParser(),
    americano.methodOverride(),
    americano.errorHandler({
      dumpExceptions: true,
      showStack: true
    }),
    americano.static(__dirname + '/../public', {
      maxAge: 86400000
    }),
    americano.set('views', __dirname + '/../client'),
    americano.engine('.html', require('jade').__express)
  ],
  development: [
    americano.logger('dev')
  ],
  production: [
    americano.logger('short')
  ]
};
```

The configuration works exactly like in Express (remember, Americano extends
Express!), so be sure to change it the way you like.


## What's next ?

We splitted our application into logical pieces and it can now grow without us
worrying about coming back later to make modification and being completely
lost.

You discovered Americano, our favorite framework, but you can use the one you
like, stick with ExpressJS or check out [Flatiron](http://flatironjs.org/),
[Sails.js](http://sailsjs.org/) or [Compound.js](http://compoundjs.com/).  As we constantly like to say, a Cozy app is nothing more than a web app.

We are almost done with Cozy's basics, there is still one concept
we'd like to introduce you to. Are you ready to [learn the single page app
way](/hack/getting-started/learn-single-page-app-way.html)?
