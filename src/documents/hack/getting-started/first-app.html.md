---
title: "Your first app in 30 minutes"
layout: "default"
category: "hack"
menuOrder: 2
toc: true
---

# Tutorial 1: your first app in 30 minutes

This first tutorial is an introduction to cozy webapp development but as you
will see, you can consider it as an introduction to webapp development with
NodeJS.

### What you will achieve

* writing a small NodeJS webapp using [ExpressJS](http://expressjs.com/),
  the standard framework for NodeJS
* introducing [Jade](http://jade-lang.com/) to write the templates
  that will be displayed by the browser
* sharing your app with other Cozy users and deploying it into Cozy

### What you should know (or to be familiar with)

* JavaScript / NodeJS
* HTML
* Git

### Get ready

Get the template:

```bash
cd cozy-dev/ # where you start the VM
git clone https://github.com/mycozycloud/cozy-tutorial.git && cd cozy-tutorial
npm install
```

Here is how the folders and files are organized:

* public/ : this is where we will have our public assets (html pages, styles, images, javascripts)
* package.json : holds your app information and dependencies.
* server.js : where you will write your code

## Step 1: displaying HTML pages

NB : the source code of this step can be found [here](https://github.com/mycozycloud/cozy-tutorial/tree/step-1).

We first need to create an HTTP server that will serve the content on requests:
```javascript
// server.js

// Generate a new instance of express server.
var express = require('express')
  , http = require('http');

var app = express();

/* This will allow Cozy to run your app smoothly but
 it won't break other execution environment */
var port = process.env.PORT || 9250;
var host = process.env.HOST || "127.0.0.1";

// Starts the server itself
var server = http.createServer(app).listen(port, host, function() {
  console.log("Server listening to %s:%d within %s environment",
              host, port, app.get('env'));
});

// At the root of your website, we show the index.html page
app.get('/', function(req, res) {
  res.sendfile('./public/index.html')
});
```
Now start the server by running:
```bash
node server.js
```

And open your browser on http://localhost:9250/ and check the result.

Whoohoo, you've just made your first NodeJS app compatible with Cozy!

You might think "well, it sucks, I actually can't do anything with that". You are absolutely right, let's move on to step 2.

## Step 2: listing the bookmarks from the server

NB : the source code of this step can be found [here](https://github.com/mycozycloud/cozy-tutorial/tree/step-2).

For the step 2, we are going to use a list stored in memory on the server and render it within a template. We are going to use Jade as a template engine. If you don't know Jade, you will find it is not difficult to read and write it.

First, install jade:
```bash
npm install jade --save # save also adds jade to package.json
```

Go back to `server.js` and change it that way:
```javascript
// server.js

/* We add configure directive to tell express to use Jade to
   render templates */
app.configure(function() {
  app.set('views', __dirname + '/public');
  app.engine('.html', require('jade').__express);
});

// Let's define some bookmarks
var bookmarks = []
bookmarks.push({title: "Cozycloud", url: "https://cozycloud.cc"});
bookmarks.push({title: "Cozy.io", url: "http://cozy.io"});
bookmarks.push({title: "My Cozy", url: "http://localhost:9104/"});

// We render the templates with the data
app.get('/', function(req, res) {
  params = {
    "bookmarks": bookmarks
  }
  res.render('index.jade', params, function(err, html) {
    res.send(200, html);
  });
});
```

We also need to change the HTML file for a Jade file:
```html
# public/index.jade
doctype 5
html(lang="fr")
  head
    title My Own Bookmarks

  body
    h1 Welcome on My Own Bookmarks
    p This application will help you manage your bookmarks!

    ul
        - for(bookmark in bookmarks) {
            li= bookmarks[bookmark].title
                | &nbsp;- (
                a(href=bookmarks[bookmark].url) link
                | )
        - }
```

Start the server and go to http://localhost:9250/ to make sure the app displays
your bookmarks.

Again, this is not very useful because you can't modify the list. Let's fix it!

## Step 3: adding and removing bookmarks

NB : the source code of this step can be found [here](https://github.com/mycozycloud/cozy-tutorial/tree/step-3).

First, add the following before the list in `index.jade`

```html
form(action="add", method="post")
    label Title:
    input(type="text", name="title")
    label Url:
    input(type="text", name="url")
    input(type="submit", value="Add a new bookmark")
```

We also need a button to remove a bookmark, let's rewrite the way a bookmark is
displayed:

```html
li
    a(href=bookmarks[bookmark].url)= bookmarks[bookmark].title
    | &nbsp;- (
    a(href="delete/#{bookmark}") delete
    | )
```

Now we can create the corresponding routes in the server:

```javascript

// add the body parser middleware to transform incoming data into a JS object.
app.configure(function() {
  app.set('views', __dirname + '/public');
  app.engine('.html', require('jade').__express);
  app.use(express.bodyParser());
});

// We define a new route that will handle bookmark creation
app.post('/add', function(req, res) {
  bookmarks.push(req.body);
  res.redirect('/');
});

// We define another route that will handle bookmark deletion
app.get('/delete/:id', function(req, res) {
  bookmarks.splice(req.params.id, 1);
  res.redirect('/');
});
```

To be able to get the data from the POST request, we need to tell express to
process the parameters. Add the following inside the "app.configure" section:

```javascript
// Allows express to get data from POST requests
app.use(express.bodyParser());
```

Et voilà! You can now add and remove bookmarks. But it still sucks, right? Each
time you start and stop the server you lose everything. Let's use a database!

## Step 4: using a real database, SQLite

NB : the source code of this step can be found
[here](https://github.com/mycozycloud/cozy-tutorial/tree/step-4).

Even if Cozy main persistence layer is not SQLite, it is shipped with every Cozy.

The first thing we need to do is getting a module to use SQLite:
```bash
npm install sqlite3 --save
```

Then we need to initialize the database. To achieve that, change the following in server.js:
```javascript
var http = require('http'),
    express = require('express'),
    app = express(),
    sqlite3 = require('sqlite3').verbose(),
    db = new sqlite3.Database('cozy.db');

// Database initialization

// Database initialization
db.get("SELECT name FROM sqlite_master WHERE type='table' AND name='bookmarks'",
       function(err, rows) {
  if(err !== null) {
    console.log(err);
  }
  else if(rows === undefined) {
    db.run('CREATE TABLE "bookmarks" ' +
           '("id" INTEGER PRIMARY KEY AUTOINCREMENT, ' +
           '"title" VARCHAR(255), ' +
           'url VARCHAR(255))', function(err) {
      if(err !== null) {
        console.log(err);
      }
      else {
        console.log("SQL Table 'bookmarks' initialized.");
      }
    });
  }
  else {
    console.log("SQL Table 'bookmarks' already initialized.");
  }
});
```

Now we must change the list, add and delete routes:
```javascript
// We render the templates with the data
app.get('/', function(req, res) {

  db.all('SELECT * FROM bookmarks ORDER BY title', function(err, row) {
    if(err !== null) {
      res.send(500, "An error has occurred -- " + err);
    }
    else {
      console.log(row);
      res.render('index.jade', {bookmarks: row}, function(err, html) {
        res.send(200, html);
      });
    }
  });
});

// We define a new route that will handle bookmark creation
app.post('/add', function(req, res) {
  title = req.body.title;
  url = req.body.url;
  sqlRequest = "INSERT INTO 'bookmarks' (title, url) " +
               "VALUES('" + title + "', '" + url + "')"
  db.run(sqlRequest, function(err) {
    if(err !== null) {
      res.send(500, "An error has occurred -- " + err);
    }
    else {
      res.redirect('back');
    }
  });
});

// We define another route that will handle bookmark deletion
app.get('/delete/:id', function(req, res) {
  db.run("DELETE FROM bookmarks WHERE id='" + req.params.id + "'",
         function(err) {
    if(err !== null) {
      res.send(500, "An error has occurred -- " + err);
    }
    else {
      res.redirect('back');
    }
  });
});
```

Don't forget to change the template too, in client/index.jade:
```html
li
    a(href=bookmarks[bookmark].url)= bookmarks[bookmark].title
    | &nbsp;- (
    a(href="delete/#{bookmarks[bookmark].id}") delete
    | )
```

## Step 5 : deploying your app into Cozy

If you want to deploy the app on a Cozy, your first need to put on a public git repository. We use [Github](https://github.com) because it's awesome but you can use any git provider.

When you have published your code, go to your cozy if you have one or to http://localhost:9104/#applications and install your app through the dedicated interface.
The application logs are available inside the virtual machine. To watch  them, do the following:
```bash
vagrant ssh
tail -f /usr/local/cozy/apps/{yourapplication}/{yourapplication}/{yourapplication}/logs/production.log
```

You can also run your application directly inside the virtual machine:
```bash
vagrant ssh
cd /vagrant/{yourapplication}/
cozy-monitor dev-route:start {appSlug} {port}
PORT={port} node server.js
```
Then go to http://localhost:9104/#apps/{appSlug}/ and watch your app inside Cozy!

## What's next ?
You've developed your first Cozy app and you must understand now that it's nothing more than a normal web application.

You must understand that if applications are built that way they will struggle collaborate around the user's data and you will not be able to use Cozy at its best.

Now we'll introduce you [the Cozy architecture](/hack/getting-started/architecture-overview.html) before coming back to this tutorial and get into more Cozy webapp development.
