---
title: "Learn the Single Page App Way"
layout: "default"
category: "hack"
menuOrder: 6
toc: true
---

# Learn the single page app way

So far, we have built classic web applications in which a server delivers HTML pages to the browser. This is a "multiple page application" approach, meaning that you have one HTML file for each page of your website.

Single page applications are made of one page and tons of JavaScript. While this is not a good news for some users (who like to disable JavaScript), it offers the rest of your users the following advantages:

* better user experience: it feels more like a native application
* less network consumption: it only loads the needed data thanks to Ajax
* better application architecture: you can build nice maintainable application by applying separation of concerns (MVC like stuff)
* the server is only a REST API, easy to request from the single page app or any other client (mobile!)

From now on we'll use the acronym "SPA" to talk about Single Page Apps or everyone is going to shoot themselves.

For example, when a user clicks a button, instead of waiting for the entire page to reload as in a traditional server-side web application, the SPA only load in portions of the page as the user interacts with them, thus speeding up the responsiveness of the user interface. 

Of course, you can do similar things with a traditional app and a bit of jQuery, but if you’ve ever tried that then you know how quickly you can run into trouble. Unless you’re dealing with something simple, code management with jQuery quickly becomes a challenge, often leading to [“spaghetti”](https://en.wikipedia.org/wiki/Spaghetti_code) code.

But if you want to know everything about single page app, we advise you to [check out this resource](http://singlepageappbook.com/) in order to learn more about SPA.

Let's make your bookmark application with the single page app way!

**Hint**: If you are later starting to build an app from scratch, the `cozy-dev new <appname>` command will take care of creating a project directory with a skeleton app structure for you.

### Front-end javascript framework

Modern JavaScript frameworks offer a way around the problem of code management by providing well-defined application architectures (often using the MVC design pattern, which jQuery lacks) that can greatly ease development. They all have the concept of views, events, data models, routing... So in using one of these frameworks, we get highly responsive user interfaces along with well structured and maintainable code, which can be a huge time saver in the long run.

Now that we have a general idea of why these frameworks are getting so much attention, let’s look at each at the two most popular ones : Backbone.js and Angular.js.

### What you will achieve
* Building a Single Page App!
* Learning the basics of [Backbone.js](http://backbonejs.org/), an example of a single page of a MVC JavaScript framework
* Learning the basics of [Angular.js](http://backbonejs.org/), an other example of a single page of a MVC JavaScript framework
* Using an application Assembler, [Brunch](http://brunch.io/), to make your life even easier

### Source code
* The source code the Backbone.js tutorial can be found [here](https://github.com/cozy/cozy-tutorial/tree/spa-final)
* The source code the Angular.js  tutorial can be found [here](https://github.com/cozy/cozy-tutorial/tree/spa-angular)

### Get ready

First, install Brunch:
```javascript
npm install -g brunch
```

Then, get the source we prepared for you to bootstrap the tutorial.
```bash
// For backbone
git clone https://github.com/cozy/cozy-tutorial.git --branch spa spa-bookmarks
// For angular
git clone https://github.com/cozy/cozy-tutorial.git --branch spa-angular spa-bookmarks
// For both Angular and Backbone
cd spa-bookmarks/
npm install
cd client/
npm install
```

Note your command includes `npm install` twice. The client's one is for Brunch specific modules. We'll come back to what Brunch does soon.

## A Single Page App with Backbone.js

### File structure of the bootstrap Backbone application

You already know about the server part of the file structure, so let's focus on the client folder.

* client/
    * app/ - where you put your files while developing
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
        * scripts/ - the JS libraries we need
    * config.js - Brunch configuration
    * package.json - Brunch modules to install

There are two parts in the file structure: the "app" where you will write your code, and "public" where Brunch will output everything you write correctly into one nice JavaScript file.

Another important thing is that the folder structure is not **constrained at all**. It is a design choice from us and you can change the way you like, but don't forget to adjust the Brunch configuration afterwards.

### Discovering Backbone
We set up a template with a working Backbone app through Brunch so you can start quickly. But before writing code, let's look at what Backbone is.

Backbone is a MVC framework for JavaScript that gives you everything you might want to build a flexible and powerful single page application.

As a result, your application will be made of:

* a router that will allow you to handle multiple pages in your single page app
* collections and models to store and manipulate your data
* views to handle the logic of rendering the data
* templates will represent the to-be-output HTML

The glue is Backbone's observer/observable pattern that allows a lower coupling between each part.
<br /><br />

How does our template work? In the app/assets/index.html we load the JavaScript we need, and call the "initialize" script. This last action ensures us that the DOM has been loaded and starts the Backbone application by creating and initializing the router.

Then the router creates the main view and gives it the collection of bookmarks.
Then the view is rendered. The render process is: load the template, put data in the template, add it to the DOM at the right place.

Now we've seen what Backbone is and how this tutorial has been bootstrapped, let's write some code!

### Adding a new bookmark
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
This means that when the user clicks on the #add-bookmark button, the "createBookmark" callback will be triggered. So let's define the "createBookmark" function in the code:

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

You will need the "Bookmark" class, so put this at the top of the file:
```javascript
var Bookmark = require('../models/bookmark');
```

If you try it, nothing will happen, and it's normal. Let's bind the view to the collection, so it can change when a new bookmark is created:

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

### Using a separate view for the bookmark
If you want to fully take advantage of what Backbone offers you, you must think modular.

We have a list of bookmarks and rendering them each time we add a new one could be a bottleneck one day. Also it could be better if we could manipulate each bookmark independently, so deletion would be dead easy to implement. Let's do this!


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
Everything should be working as before, but each bookmark is rendered separately, which also means they can be managed separately. Let's see how we can easily add the "delete" feature now.

### Removing a bookmark
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

Note that the events declaration is reduced to the children of the view in the DOM, so "a.delete" actually means (jQuery style): `$(document).find('theview').find('a.delete')`.

Your application is still useless (we came back in the first tutorial state :(), because the changes are not saved in the server. Let's fix this!

### Binding your single page app with your server
To achieve that we must tell the Backbone collection where the server is and then create the right route on the server side.

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

## What if i want to use AngularJS ?

That is not a problem. As we said, you're completely free to choose the technology you're the most comfortable in. So let's get into it and see what could be the simplist way to apply our bookmark application into an Angular way.

### File structure of the AngularJS application

* client/
    * app/ - where you put your files while developing
        * assets/ - all your static assets: images, fonts, ...
            * partials/ - templates rendered by ng-view
                * home.html
            * index.html - the entrance point of your application
        * scripts/ - angular controllers (Ctrl), factories (Fctr)...
            * books/ - angular fonctionalities related to books
                * Book.Fctr.js - Books factories (Object Oriented)
                * Book.Ctrl.js - Books controller (calls the factory)
        * stylesheets/ - the css to make it pretty
        * app.module.js - main module (route configuration, angular lib importations...)
    * public/ - where the "built" files are
    * vendor/
        * scripts/ - the angularJS libraries we need
    * config.js - Brunch configuration
    * package.json - Brunch modules to install

### Discovering AngularJS

AngularJS is an Open-Source framework maintained by Google. One of the must loved feature is the [Two-way data binding](https://docs.angularjs.org/tutorial/step_04). It allows for a reduction in the amount of code required to create dynamic views.

Another popular feature is directives and it will get even more important when [Angular 2.0](https://angular.io/) (the current version is v1.4.4) will come out, which allow developers to extend HTML by attaching special behaviors to parts of the DOM. For example, [ng-repeat](https://docs.angularjs.org/api/ng/directive/ngRepeat) is a directive that allows developers to repeat an element, making it very handy for doing things like printing an array of items to the page. In addition to the directives that come with Angular, you can create your own, allowing for a great deal of flexibility in crafting behaviors for the UI.

### Links

* A [conference](https://www.youtube.com/watch?v=-8P8NO8X-mQ) explains how Angular 2 will only be centered on Directives
* A [tutorial](http://blog.revolunet.com/blog/2014/02/14/angularjs-services-inheritance/) that explains how to build a Object Oriented framework and get closer to Angular 2 new architecture
* A [document](https://github.com/johnpapa/angular-styleguide) that explains how to write clean code in Angular.
* [Karma](https://karma-runner.github.io/0.8/plus/AngularJS.html). A generator for testing AngularJS.
* A nice [tutorial](https://www.airpair.com/angularjs/posts/top-10-mistakes-angularjs-developers-make) that explains what you shoud'nt do in AngularJS

Important : because of his evolution, a lot of the angularJS tutorial get's depreciated very fast.

As a result, your application will be made of:
* a template engine with binding expressions baked-in
* a categorization of your application building blocks into several types : Controllers, Directives, Factories... 

Now we've seen what Angular is, let's write some code !

### Adding a new bookmark

This add function will get the bookItem filled in the form in the home.html file. 

```javascript
// app/assets/scripts/bookmarks/Home.Ctr.js
function add(bookItem) {
    var defaultForm = {
      title : "",
      link : ""
    };
    // set the book in the factory (for an Object Oriented way)
    bookmark.setBookmark(bookItem);
    // will send the data to the factory to make a call to the server
    bookmark.addBookmark().then(function() {
        // vm.bookmarks will be binded to home.html with ng-repeat. 
        vm.bookmarks.push(bookmark._bookmark);
        
        // useful to reset the form in the view
        vm.bookmark = defaultForm;
        $scope.form.$setPristine(); 
    });
}
```

Now create the bookmark template `app/assets/partials/home.html`:
```bash
<tr ng-repeat="bookmark in home.bookmarks track by $index">
    <td>{{bookmark.title}}</td>
    <td>{{bookmark.link}}</td>
    <td>
        <button class="btn btn-default" ng-click="home.removeBookmark($index, bookmark.id)" type="submit">Delete</button>
    </td>
</tr>
```

Next write the factory to make a `post` call to the server.

```javascript
// app/assets/scripts/bookmarks/Bookmark.Fctr.js

// ! important : define your route depended to the name of your app
function addBookmark() {
    var self = this;
    // will call the post route of the bookmark API
    return $http.post('/apps/tutorial-angularjs/add', self._bookmark).then(function(response) {

        // store the response of the API in the factory
        self._bookmark = response.data;
        return response;
    });
}

```

Let's see how we can easily add the "delete" feature now.

### Removing a bookmark
In the bookmark controller (Home.Ctrl.js), add the "removeBookmark" feature like we did earlier for the "add" one.

```javascript
// app/assets/scripts/bookmarks/Home.Ctrl.js
function removeBookmark(index, bookmarkId) {
    // set the bookmark id to delete
    bookmark.setId(bookmarkId);

    // delete the bookmark related to the bookmark id
    book.deleteBook().then(function() {

        // refresh the page when deleted
        vm.books.splice(index, 1);
    });
}

```

```javascript
// ! important : Define your route depended to the name of your app
function deleteBookmark() {
    var self = this;
    // will call the get route of the bookmark API
    return $http.get('/apps/tutorial-angularjs/delete/' + self._id).then(function(response) {
        return response;
    });
}
```

## What about the server ?

Backbone or Angular considers the server is RESTful and that it sends and receives JSON, so we change the server routes to match the standard:
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

module.exports.list = function(req, res, next) {
    Bookmark.all(function(err, bookmarks) {
        if(err !== null) {
            // Here we want to handle errors our way so Backbone
            // understands them.
            res.status(500).send({error: "An error has occurred -- " + err});
        }
        else {
            res.send(bookmarks);
        }
    });
};

module.exports.add = function(req, res, next) {
    Bookmark.create(req.body, function(err, bookmark) {
        if(err !== null) {
            next(err);
        }
        else {
            // 201 is the HTTP code for creation success.
            res.status(201).send({success: "Creation succeeded"}); 
        }
    });
};

module.exports.delete = function(req, res, next) {
    Bookmark.find(req.params.id, function(err, bookmark) {
        if(err !== null) {
            res.status(500).send({error: "An error has occurred -- " + err});
        }
        else if(bookmark === null) {
            res.status(404).send({error: "Bookmark not found"});
        }
        else {
            bookmark.destroy(function(err) {
                if(err !== null) {
                    res.status(500).send({error: "An error has occurred -- " + err});
                }
                else {
                    res.status(204).send({success: "Deletion succeeded"});
                }
            });
        }
    });
};
```

You server is now a RESTful API that allows your single page app to request it easily thanks to Backbone and AngularJS.

Now let's see what exactly Brunch does.

## Automatically build your application with Brunch

Brunch gathers everything you will write in the app folder and wrap it with RequireJS (which allows you to use the "require" keyword), and put it all together in one JavaScript file.

It can also process your file to minify it (for example). If you want to write Coffee Script instead of JavaScript, Brunch will compile it for you. If you want to use Jade, it will compile it for you.
You can use pretty much everything you want to for templates (Jade, Handlebars, Underscore, ...) or styles (Stylus, LESS, SASS, ...), just install the relevant node modules and adjust the configuration file.

If you want to know everything about Brunch, please check out their [website](http://brunch.io/) (it is not mandatory for this tutorial though).

Brunch is also awesome because it detects when a file changes and recompiles the code automatically, so everything is smooth for you.

To start brunch, open a terminal:
```bash
cd tutorial-spa/client/
brunch w
```

From now on, you shouldn't be modifying a file outside the app/ directory.

## What's next?

This tutorial doesn't cover every aspect and good practice of Backbone and AngularJS but it
should give you good insight into how you can build awesome single page apps.

Finally, to you make your application Cozy-ready, you have to do one unfamiliar
thing: You have to commit the build of your application client when you push your
git repository. Why? Because the Cozy platform doesn't run any build process and
we don't have a strong package manager yet. So the only way for the platform to have
the finished build of your app is to fetch it as part of the git repository.

Besides this, there is a lot of cool stuff you can do with Cozy and you can
ask us on IRC or by email what the next steps are or just to get help from us.

<br /><br />
We are eager to see what application you will bring to the Cozy community, don't hesitate to show us your work!
<br /><br />

To go further in your study of Cozycloud, you can check out the [cookbooks](/hack/cookbooks/)!

We also provide [application skeletons](/hack/application-skeletons/) to get you started quickly.
Choose the one you like, or add yours.
