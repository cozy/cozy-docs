---
title: "Play with the Data System"
layout: "default"
category: "hack"
menuOrder: 4
toc: true
---

# Tutorial 2: Play with the Data System

We've just introduced you to the architecture of Cozy and you may want to know more about
the Data System, and to play with it. Don't forget that if you are stuck or have any question, you can visit us on IRC (irc.freenode.org, #cozycloud).

Just a quick reminder, the Data System (DS) allows you to access the database,
the indexer and the file system. Technically speaking, it is a RESTful web application, meaning you can request it with a HTTP client. It handles
authorization and authentification for applications, meaning that user has to give his explicit agreement (during installation) to the app so it can access
the data.

### What you will achieve

From the first app we've built together, you will add, remove and list data
from the Cozy Data System. This is important because now, other applications
will be able to use the data you store this way.

### Source code
The source code of this tutorial can be found
[here](https://github.com/cozy/cozy-tutorial/tree/data-system-odm).


### Getting started

Make sure you have "Setup your development environment" and that it runs,
because it is where the Data System is living.


## Playing with the data

Accessing the data within the Data System can be achieved in two ways: by using
an ODM we've developed a driver for, or by requesting directly the Data System
API.

That being said, using the ODM has a big advantage: you can still use your app
in another execution environment, without relying on the DataSystem / CouchDB by
switching the ODM's driver. At Cozycloud, we use the ODM in all our apps!

### Starting with the ODM

ODM stands for Object Document Mapper, it's like an ORM (Object Relational
Mapper) but for NoSQL. An O(D|R)M abstracts the storage engine, as a result you
can switch the storage engine (e.g. from CouchDB to Pouchdb) without
changing your code.

Enough talking, let's see how we can use it in our application.
```bash
npm install cozydb --save
```

Then remove all the SQLite-related stuff from your server.js code and add the following:
```javascript
var http = require('http'),
    express = require('express'),
    app = express(),
    cozydb = require('cozydb')

// ...

// We define our data schema
Bookmark = cozydb.getModel('bookmarks', {
  "id": String,
  "title": String,
  "url": { "type": String, "default": ""}
});
```
This defines a doctype in the data system. The doctype is a type of document
(yup!) and is how data are structured inside Cozy. You can see them as SQL tables. There are already plenty of doctypes you can reuse. They are self-documented in the applications' code. Now let's play with the data.

### Adding and removing a bookmark
```javascript
// We define a new route that will handle bookmark creation
app.post('/add', function(req, res, next) {
  Bookmark.create(req.body, function(err, bookmark) {
    if(err != null) {
      next(err);
    }
    else {
      res.redirect('back');
    }
  });
});

// We define another route that will handle bookmark deletion
app.get('/delete/:id', function(req, res) {
  Bookmark.find(req.params.id, function(err, bookmark) {
    if(err != null) {
      next(err);
    }
    else if(bookmark == null) {
      res.status(404).send("Bookmark not found");
    }
    else {
      bookmark.destroy(function(err) {
        if(err != null) {
          next(err);
        }
        else {
          res.redirect('back');
        }
      });
    }
  });
});
```
The code is pretty straightforward. However you must be aware that we don't do
security checks and data validation in the tutorial, because it is not the
point. If you want to know how to do it, please ask us on IRC or by email
(contact[at]cozycloud.cc).


### Listing the bookmarks

Now that we can add and remove bookmarks, we should also see how we retrieve them.
It's a bit trickier if you don't know map/reduce, but you will figure out that
the basics are easy.

In order to retrieve data, you need to declare "requests" that will allow CouchDB to
create views. If you have no idea of what we are talking about, it's not a big
deal, you don't need to understand all the details for now.

```javascript
// Define the request. You need to do this only once.
var request = function(doc) {
  return emit(doc._id, doc);
};
Bookmark.defineRequest("all", request, function(err) {
  if(err !== null) {
    next(err);
  }
});
```

Then you can call the request to get the data:
```javascript
// We render the templates with the data
app.get('/', function(req, res, next) {
  Bookmark.request("all", {}, function(err, bookmarks) {
    if(err !== null) {
      next(err);
    } else {
      data = {"bookmarks": bookmarks}
      res.render('index.jade', data, function(err, html) {
        res.send(html);
      });
    }
  });
});
```

## Permissions
To retrieve the data from the Data System, your application needs permissions.
You can declare permissions you need in the package.json file:

```json
"cozy-permissions": {
  "Contact": {
    "description": "Creates and edits your contacts."
  },
  "CozyInstance": {
    "description": "Read language setting"
  }
}
```

Those will be displayed before the users install the application so they give their explicit agreement to the app to access the data, like the well-known marketplaces for smartphones.


## What's next ?
You've just met the Data System and got insight of what it does and how you
can play with it to leverage people's personal data. Congratulations, we know
it wasn't easy!

Now look a bit behind you: your application has grown a lot and the code itself
is getting fat, which could complicate the addition of new features and more
generally your ability to maintain the application (or to get contributions
from the community!)

Let's see how we can organize the code better with a stronger Express(o).
[Experience Americano, the NodeJS framework that makes Express more
opinionated](/hack/getting-started/discover-americano.html).
