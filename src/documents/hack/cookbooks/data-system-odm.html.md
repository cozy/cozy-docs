---
title: "The ODM for Data System API"
layout: "default"
category: "hack"
menuOrder: 2
---

# The ODM for Data System API

We've created a driver for JugglingDB, an ODM (Object Document Mapper) to work with Cozy Data System easily. This document will gives you the detailed API to use it but you can already check [the tutorial](http://localhost:9778/hack/getting-started/play-with-data-system.html) where we introduce it to see a working example.

## Generic note
Depending on what do you use, you might want to install JugglingDB and the Cozy adapter in order to make it works. If you use a framework where it is integrated (like Americano with the Cozy plugin), refers to the framework's documentation too see how to boostrap it. Otherwise you can follow the steps of this section.

```bash
npm install jugglindb jugglingdb-cozy-adapter --save
```

In the following example, "Note" refers to a model and "note" to a document of the model "Note". "Note" was declared like this:
```javascript
var Schema = require('jugglingdb').Schema,
var db = new Schema('cozy-adapter', { url: 'http://localhost:9101/' });

Note = db.define('Note', {
  "id": String,
  "title": String,
  "content": { "type": String, "default": ""}
});
```

Also, you don't have to worry about authentfication and authorization while using the ODM because they are automatically handled for you.

## Documents

```javascript
// Checking document existence
Note.exists(123, function(err, isExist) {
    console.log(isExist);
});

// Retrieving a document with its ID
Note.find(321, function(err, note) {
    console.log(note);
});

// Creating a document
Note.create({ id: "321", "content":"created value"}, function(err, note) {
    console.log(note.id);
});

// Upserting (update or create if doesn't exist) a document
Note.createOrUpdate(123, function(err, note) {
    console.log(err);
});

// Updating a document (will replace the existing one)
note.save(function(err) {
    console.log(err);
});

// Updating attributes (only replace the specified attributes)
note.updateAttributes({title: "my new title"}, function(err) {
    console.log(err);
});

// Deleting a document
note.destroy(function(err) {
    console.log(err);
});
```

## Indexation

```javascript
// Indexing document fields
note.index(["title", "content"], function(err) {
    console.log(err);
});

// Searching the 10 most relevant indexed documents
Note.search("dragons", function(err, notes) {
   console.log(notes);
});
```


## Files/Attachements

```javascript
# Uploading/attaching a file to a document
note.attachFile("./test.png", function(err) {
    console.log(err);
});

# Get file
stream = note.getFile("test.png", functino(err) {
    console.log(err);
});
stream.pipe(fs.createWriteStream('./test.png'));
```

## Requests

```javascript
# Defining request
map = function(doc) {
    emit(doc._id, doc);
    return;
}

Note.defineRequest("all", map, function(err) {
    console.log(err);
});

# Getting request results
Note.request("all", function (err, notes) {
    console.log(notes);
});

# Destroying all documents of a request result
Note.requestDestroy("all", {key: ids[3]}, function(err) {
    console.log(err);
});

# Removing a request
Note.removeRequest("all", function(err) {
    console.log(err);
});
```