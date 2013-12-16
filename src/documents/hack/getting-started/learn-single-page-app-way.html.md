---
title: "Learn the Single Page App Way"
layout: "default"
category: "hack"
menuOrder: 6
---

# Learn the single page app way

Until now we have built classic web applications: a server delivers HTML pages to the browser. This is a "multiple page application" approach, meaning that you have one HTML file for each page of your website.

Single page applications are made of one page and tons of JavaScript. While this is not a good news for some users (who likes to disable JavaScript), it offers the rest of your users the following advantages:

* better user experience: it feels more like a native application
* less network consumption: it only loads the needed data thanks to Ajax
* better application architecture: you can build nice maintanable application by applying separation of concerns (MVC like stuff)
* the server is only a REST API, easy to request from the single page app or any other client (mobile!)

If you want to know everything about single page app, we advise you to [check out this resource](http://singlepageappbook.com/) to learn more about Singe Page Apps.

From now on we'll use the SPA acronym to talk about Single Page Apps or everyone is going to shoot themselves.

Let's make your bookmark application with the single page app way!

### What you will achieve
* Learning the basics of [Backbone.js](http://backbonejs.org/), a MVC JavaScript framework
* Using an application Assembler, [Brunch](http://brunch.io/) to make your life even easier
* Building a Single Page App!

### Source code
The source code of this tutorial can be found [here](https://github.com/mycozycloud/cozy-tutorial/tree/spa-final).

### Get ready

First, install Brunch:
```javascript
npm install -g brunch
```

Then, get the source we prepared for you to bootstrap the tutorial.
```bash
git clone https://github.com/mycozycloud/cozy-tutorial.git --branch spa spa-bookmarks
cd spa-bookmarks/
npm install
cd client/
npm install
```

Note you perform have `npm install` twice. The client's one is for Brunch specific modules. We'll come back to what does Brunch soon.

## File structure of the bootstrap Backbone application

You already know about the server part of the file structure so let's focus on the client/

* client/
    * app/ - where you put your files while developping
        * assets/ - all your static assets: images, fonts, ...
            * index.html the entrance point of your application
        * collections/
        * models/
        * templates/ - where your templates (Jade in our case) will be
        * views/
        * application.js - bootstrap the Backbone app
        * initialize.js - start the whole application when ready
        * router.js - the Backbone router
    * public/ - where the "built" files are
    * vendor/
        * scripts/ - the JS librairies we need
    * config.js - Brunch configuration
    * package.json - Brunch modules to install

There are two parts in the file structure: the "app" where you will write your code and "public" where Brunch will output everything you write correctly into one nice JavaScript file.

Another important thing is that the folder structure is not **constrained at all**. It is a design choice from us and you can change the way you like, but don't forget to adjust the Brunch configuration then.

Now let's see what does do Brunch exactly.

## Automatically build your application with Brunch
Brunch gathers everything you will write in the app folder and wrap it with RequireJS (which allows you to use the "require" keyword) and put it all together in one JavaScript file.

It can also process your file to minify it (for example). If you want to write Coffee Script instead of JavaScript, Brunch will compile it for you. If you want to use Jade, it will compile it for you.
You can use pretty much everything you want to for templates (Jade, Handlebars, Underscore, ...) or styles (Stylus, LESS, SASS, ...), just install the relevant node modules and adjust the configuration file.

If you want to know everything about Brunch, please check out their [website](http://brunch.io/) (it is not mandatory for this tutorial though).

Brunch is also awesome because it detects when a file changes and recompiles the code automatically so everything is smooth for you.

To start brunch, open a terminal:
```bash
cd tutorial-spa/client/
brunch w
```

From now you shouldn't be modifying a file outside the app/ directory.


## Step 1: discovering Backbone
We set up a template with a working Backbone app through Brunch so you can start quickly. But before writing code, let's look at what Backbone is.

Backbone is a MVC framework for JavaScript that gives you evertyhing you might want to build a flexible and powerful single page application.

As a result, your application will be made of:

* a router that will allow you to handle multiple page in your single page app
* collections and models to store and manipulate your data
* views to handle the logic of rendering the data
* templates will represent the to-be-output HTML

The glue is Backbone's observer/observable pattern that allows a lower coupling between each part.
<br /><br />

How is our template working? In the app/assets/index.html we load the JavaScript we need and call the "initialize" script. This last call makes sure that the DOM has been loaded and starts the Backbone application by creating and initializing the router.
Then the router creates the main view and gives it the collection of bookmarks.
Then the view is rendered. The render process is: load the template, put data in the template, add it to the DOM at the right place.

Now we've seen what Backbone is and how this tutorial has been bootstrapped, let's write some code!

## Step 2: adding a new bookmark
The provided code displays a collection of bookmarks. Let's bind our "new bookmark" form to Backbone.

Along the "el" and the "template" attribute, add the event binding:
```javascript
// apps/views/app_view.js
el: 'body',
template: require('../templates/home'),
events: {
    "click #add-bookmark": "createBookmark"
},
```
This means that when the user clicks on the #add-bookmark button, the "createBookmark" callback will be called. So let's define the "createBookmark" function in the code:

```javascript
createBookmark: function(event) {
    // submit button reload the page, we don't want that
    event.preventDefault();

    // create a new model
    var bookmark = new Bookmark({
        title: this.$el.find('input[name="title"]').val(),
        url: this.$el.find('input[name="url"]').val()
    });

    // add it to the collection
    this.collection.add(bookmark);
}
```

You will need the "Bookmark" class so put this at the top of the file:
```javascript
var Bookmark = require('../models/bookmark');
```

If you try it, nothing will happen and it's normal. Let's bind the view to the collection so it can change when a new bookmark is created:

```javascript
// initialize is automatically called once after the view is constructed
initialize: function() {
    this.listenTo(this.collection, "add", this.onBookmarkAdded);
},
onBookmarkAdded: function(model) {
    // re-render the view
    this.render();
}
```
The new bookmark should now be displayed!

## Step 3: using a separate view for the bookmark
If you want to fully take advantage of what Backbone offers you, you must think modular.
We have a list of bookmarks and rendering them each time we add a new one could be a bottleneck one day. Also it could be better if we could manipulate each bookmark independently so a deletion would be dead easy to implement. Let's do this!

Create a new view `app/views/bookmark.js`:
```javascript
// app/views/bookmarks.js
module.exports = AppView = Backbone.View.extend({

    tagName: 'li',
    template: require('../templates/bookmark'),

    render: function() {
        this.$el.html(this.template({
            bookmark: this.model.toJSON()
        }));
    }
});
```
The tagname will be used when we create a view to automatically create a "li" DOM node.

Now create the bookmark template `app/templates/bookmark.jade`:
```bash
a(href=bookmark.url)= bookmark.title
| &nbsp;- (
a.delete delete
| )
```

We must also change the way the app_view renders. First clean the home template (`apps/templates/home.jade`) by removing everything under the "ul" tag.

Next rewrite the render function that way:
```javascript
render: function() {

    // we render the template
    this.$el.html(this.template());

    _this = this;
    this.collection.forEach(function(bookmark) {
        _this.onBookmarkAdded(bookmark);
    });

    return this;
},
onBookmarkAdded: function(bookmark) {
    // render the specific element
    bookmarkView = new BookmarkView({
        model: bookmark
    });
    bookmarkView.render();
    this.$el.find('ul').append(bookmarkView.$el);
}
```
Everything should be working as before but each bookmark is rendered separately which also means they can be managed separately. Let's see how we can easily add the "delete" feature now.

### Step 4: removing a bookmark
In the bookmark view, add the "delete" feature like we did earlier for the "create" one.

```javascript
// app/views/bookmark.js
events: {
    'click a.delete': 'deleteBookmark'
},

deleteBookmark: function() {
    this.model.destroy();
    this.remove();
}
```

Note that the events declaration is reduced to the children of the view in the DOM so "a.delete" actually means (jQuery style): $(document).find('theview').find('a.delete').

Your application is still useless (we came back in the first tutorial state :()) because the changes are not saved in the server. Let's fix this!

## Step 5: binding your single page app with your server
To achieve that we must tell Backbone collection where the server is and then create the right route on the server side.

```javascript
// app/collections/bookmarks.js
Bookmark = require('../models/bookmark');
module.exports = Bookmarks = Backbone.Collection.extend({
    model: Bookmark,
    url: 'bookmarks'
});
```

We also need to tell Backbone to properly persist the model on the server:
```javascript
// app/views/app_view.js
createBookmark: function(event) {
    // submit button reload the page, we don't want that
    event.preventDefault();

    // add it to the collection
    this.collection.create({
        title: this.$el.find('input[name="title"]').val(),
        url: this.$el.find('input[name="url"]').val()
    });
}
```

Make sure you also change the render function from the app_view to retrieve the bookmarks from the database:
```javascript
// app/views/app_view.js
render: function() {

    // we render the template
    this.$el.html(this.template());

    // fetch the bookmarks from the database
    this.collection.fetch();
}
```

Backbone considers the server is RESTful and that it sends and receives JSON so we change the server routes to match the standard:
```javascript
// server/controllers/routes.js
module.exports = {
    'bookmarks': {
        get: bookmarks.list,
        post: bookmarks.add,
    },
    'bookmarks/:id': {
        del: bookmarks.delete
    }
};
```

And adjust the controller in the right way:
```javascript
// server/controllers/bookmarks.js
Bookmark = require('../models/bookmark');

module.exports.list = function(req, res) {
    Bookmark.all(function(err, bookmarks) {
        if(err != null) {
            res.send(500, {error: "Couldn't retrieved the bookmarks."});
        }
        else {
            res.send(200, bookmarks);
        }
    });
};

module.exports.add = function(req, res) {
    Bookmark.create(req.body, function(err, bookmark) {
        if(err != null) {
            res.send(500, "An error has occurred -- " + err);
        }
        else {
            res.send(201);
        }
    });
};

module.exports.delete = function(req, res) {
    Bookmark.find(req.params.id, function(err, bookmark) {
        if(err != null) {
            res.send(500, {error: "Bookmark couldn't be retrieved -- " + err});
        }
        else if(bookmark == null) {
            res.send(404, {error: "Bookmark not found"});
        }
        else {
            bookmark.destroy(function(err) {
                if(err != null) {
                    res.send(500, {error: "An error has occurred -- " + err});
                }
                else {
                    res.send(200);
                }
            });
        }
    });
};
```

You server is now a RESTful API that allows your single page app to request it easily thanks to Backbone.

## What's next?
This tutorial doesn't cover every aspects and good practice of Backbone but it should give you a good insight into how you can build awesome single page apps.

We haven't talked about Cozy for a while but everything you've done until know should help you creating an (awesome) application for Cozy. There is more cool stuff you can do with Cozy and you can ask us on IRC or by email what the next steps are or just to get help from us.

<br /><br />
We are eager to see what application you will bring to the Cozy community, don't hesitate to show us your work!
<br /><br />

To go further in your study of Cozycloud, you can check out the [cookbooks](/hack/cookbooks/)!
We also provide [application skeletons](/hack/application-skeletons/) to get you started quickly, chose the one you like or add your own.
