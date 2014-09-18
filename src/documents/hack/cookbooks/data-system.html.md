---
title: "The Data System API"
layout: "default"
category: "hack"
menuOrder: 1
toc: true
---

# The Data System API

The Data System API allows the access of the following:

* the data itself
* the CouchDB views (through "requests")
* the attachments (files)
* the indexer

## Generic notes

All the responses' bodies are encoded in JSON and all the data you send along request should be encoded in JSON.

You will find HTTP status code for the response, here is what they mean:

* 200: success
* 201: success (and something has been created)
* 204: success (and something has been deleted)
* 400: bad request
* 401: unauthorized (bad authentication)
* 403: forbidden (authenticated but not enought permissions)
* 404: document not found
* 409: document already exists
* 500: internal server error

All the requests that mention "Requires authentication and authorization" are likely to send 401 and 403 if the conditions are not met.
See [troubleshootings](#troubleshootings) to understand what those error mean.

### Todo for this cookbook
* Adding documentation about authentication and authorization process

## Data API

This API lets you manage data with four common operations: create, read, update and delete but utiliy functions like exist, find or merge can also help you.

### Check the existence of a document
```http
GET /data/exist/:id/
Param:
  id: the document ID
Response:
  Status code: 200|500
  Body
    200: {exist: true|false}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Retrieving a document by ID
```http
GET /data/:id/
Param:
  id: the document ID
Response:
  Status code: 200|404|500
  Body
    200: {the document}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Creating (generates a new ID)
```http
POST /data/
Param:
  Body {the document to add}
Response:
  Status code: 201|500
  Body
    201: {"_id": the document ID}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Creating (with specified ID)
```http
POST /data/:id/
Param:
  id: the document ID
  Body {the document to add}
Response:
  Status code: 201|409|500
  Body
    201: {"_id": the document ID}
    409: {error: "The document exists"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Update (overwrite old version)
```http
PUT /data/:id/
Param:
  id: the document ID
  Body {the document to update}
Response
  Status code: 200|404|500
  Body
    200: {success: true}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Updating or creating (with specified ID)
```http
PUT  /data/upsert/:id/
Param:
  id: the document ID
  Body {the document to add or update}
Response
  Status code: 200|201|500
  Body
    200: {success: true}
    201: {"_id": the document ID}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Deleting a document
```http
DELETE /data/:id/
Param:
  id: the document ID
Response
  Status code: 204|404|500
  Body
    204: {success: true}
    404: {error: "not found"}
    500: {error: "the message"}
```
Requires authentication and authorization.

### Updating (only the given fields)
```http
PUT /data/merge/:id
Param:
  Body {the fields of the document to update}
Response
  Status code: 200|500
  Body
    200: {success: true}
    500: {error: "the message"}
```
Requires authentication and authorization.

## Request API

The Request API is used to create, update, delete and retrieve documents based on CouchDB views.

### Getting documents from a view
```http
POST /request/:type/:req_name/
Param:
  type: the doctype name
  req_name: the name of the request
  Body {
    key: only returns document for this key
    keys: [only returns document for this array of keys]
    limit: number of documents to return
    skip: number of documents to skip
    startKey: only returns document after this key
    endKey: only returns document before this key
  }
  The body is fully optional.
Response
  Status code: 200|404|500
  Body
    200: [an array of documents]
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Create or update a view
```http
PUT /request/:type/:req_name/
Param:
  type: the doctype name
  req_name: the name of the request
  Body {
    map: the map function
    recuce: the reduce function (optional)
  }
Response
  Status code: 200|500
  Body
    200: {success: true}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Delete all the docs returned by the specified view
```http
PUT /request/:type/:req_name/destroy/
Param:
  type: the doctype name
  req_name: the name of the request
  Body {
    key: only returns document for this key
    keys: [only returns document for this array of keys]
    limit: number of documents to return
    skip: number of documents to skip
    startKey: only returns document after this key
    endKey: only returns document before this key
  }
  The body is fully optional.
Response
  Status code: 204|404|500
  Body
    204: {success: true}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Delete the view
```http
DELETE /request/:type/:req_name/
Param:
  type: the doctype name
  req_name: the name of the request
Response
  Status code: 204|404|500
  Body
    204: {success: true}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

## Files API

The Data System offers an API to upload/download files to the database (e.g. for a music library application).

How does it work? Using the API you will attach a file to a document and retrieve it when needed. But behind the scene, a document is created with the doctype "Binary", so the same file can be reused by various applications in different context (e.g. music library application and files sync application). That's a technical detail you probably won't even have to deal with!

### Save a file
```http
POST /data/:id/binaries/
Param:
  id: ID of the document the file will be attached to
  Body {
    a file send through multipart form
    name: force the file name
  }
Response
  Status code: 201|400|404|500
  Body
    201: {success: true}
    400: {error: "no file sent"}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Download an attached file
```http
GET /data/:id/binaries/:name
Param:
  id: ID of the document the file is attached to
  name: the file name
Response
  Status code: 404|500
  Body
    200: {success: true}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Delete an attached file
```http
DELETE /data/:id/binaries/:name
Param:
  id: ID of the document the file is attached to
  name: the file name
Response
  Status code: 204|404|500
  Body
    204: {success: true}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

## Indexer API

We use [Whoosh](https://pypi.python.org/pypi/Whoosh/) as an indexer but you can only access it through its API in the Data System.

### Indexing

```http
POST /data/index/:id
Param:
  id: ID of the document to index
  Body {
    fields: [an array of text fields name that will be indexed]
  }
Response
  Status code: 200|404|500
  Body
    200: {success: true}
    404: {error: "not found"}
    500: {error: "the error message"}
```

### Searching 10 documents that best match the query
```http
POST /data/search/:type
Param:
  type: the doctype the searched documents belongs
  Body {
    query: "search query"
    numPage: page result number (default is 1)
    numByPage: number of results by page (default is 10)
  }
Response
  Status code: 200|500
  Body
    200: {rows: [the documents]}
    500: {error: "the error message"}
```
Both `numPage` and `numByPage` are optional.


### Removing indexation for a given document
```http
DELETE /data/index/:id
Param:
  id: the ID of the document that will be unindex
Response
  Status code: 200|404|500
  Body
    200: {success: true}
    404: {error: "not found"}
    500: {error: "the error message"}
```

### Clearing the indexer

```http
DELETE /data/index/clear-all/
Response
  Status code: 200|500
  Body
    200: {success: true}
    500: {error: "the error message"}
```

## Miscellaneous

### Getting the doctype list
```http
GET /doctypes
Response
  Status code: 200|500
  Body
    200: ['list', 'of', 'doctype', 'names']
```

# Example of use
How to request the Data System from a NodeJS application ? You can use any HTTP client but we recommend (, use and maintain) request-json:

```bash
npm install request-json --save
```

```javascript
Client = require('request-json').JsonClient;

// The data system listens to localhost:9101
dataSystem = new Client('http://localhost:9101');

// In production we must authentificate the application
if(process.env.NODE_ENV === 'production') {
  user = process.env.NAME;
  password = process.env.TOKEN;
  dataSystem.setBasicAuth(user, password);
}

// The request must be created first, let's say it is
dataSystem.post('/request/alarm/all/', function(err, res, body) {
  if(err !== null || (res !== null && res.statusCode != 200)) {
    if(res !== null) {code = res.statusCode;} else { code = "no status code"; }
    console.log("An error occurred -- [" + code + "] " + err);
  }
  else {
    console.log("List of all the alarms");
    console.log(body);
  }
}
});
```

For more examples and the complete documentation of request-json, please see the [github repository](http://github.com/cozy/request-json/) of the module.


<a name="troubleshootings"></a>
# Troubleshootings

Coming soon...

## authentication and authorization
Coming soon...
