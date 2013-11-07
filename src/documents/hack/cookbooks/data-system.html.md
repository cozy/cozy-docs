---
title: "The Data System API"
layout: "default"
category: "hack"
menuOrder: 1
---

# The Data System API

The Data System API allows the access of the following:

* the data themselves
* the CouchDB views (through "requests")
* the attachements (files)
* the indexer
* the accounts

## Generic notes

All the responses body are encoded in JSON and all the data you send along request should be encoded in JSON.

You will find HTTP status code for response, here is what they mean:

* 200: success
* 201: success (and something has been created)
* 204: success (and something has been deleted)
* 400: bad request
* 401: unauthorized
* 403: not authentificated
* 404: document not found
* 409: document already exists
* 500: internal server error

All the requests that mentions "Requires authentification and authorization" are likely to send 401 and 403 if the conditions are not met.
See [troubleshootings](#troubleshootings) to understand what those error mean.

### Todo for this cookbook
* Adding documentation about authentification and authorization process

## Data API

This API let you manage data with four common operations: create, read, update and delete but utiliy functions like exist, find or merge can also help you.

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
Requires authentification and authorization.

### Retrieving a document for a specific ID
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
Requires authentification and authorization.

### Creating a document (automatically generates a new ID)
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
Requires authentification and authorization.

### Creating a document (with specified ID)
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
Requires authentification and authorization.

### Update a document (old version is fully overwritten)
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
Requires authentification and authorization.

### Update or create a document (with specified ID)
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
Requires authentification and authorization.

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
Requires authentification and authorization.

### Updating a document (only the given fields)
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
Requires authentification and authorization.

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
Requires authentification and authorization.

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
Requires authentification and authorization.

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
Requires authentification and authorization.

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
Requires authentification and authorization.

## Attachments API

Attachements are basically files attached to documents. It allows you file upload and download (e.g. music library application)

### Save a file as attachement of a document
```http
POST /data/:id/attachments/
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
    400: {error: "No file sent"}
    404: {error: "not found"}
    500: {error: "the error message"}
```
Requires authentification and authorization.

### Download an attached file
```http
GET /data/:id/attachments/:name
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
Requires authentification and authorization.

### Delete an attached file
```http
DELETE /data/:id/attachments/:name
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
Requires authentification and authorization.

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

### Searching 10 documents that match the best the query
```http
POST /data/search/:type
Param:
  type: the doctype the searched documents belongs
  Body {
    query: "search query"
  }
Response
  Status code: 200|500
  Body
    200: {rows: [the documents]}
    500: {error: "the error message"}
```

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
  user = process.env.USER;
  password = process.env.PASSWORD;
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

More example and the complete documentation of request-json, please see the [github repository](http://github.com/mycozycloud/request-json/) of the module.


<a name="troubleshootings"></a>
# Troubleshootings

Coming soon...

## Authentification and authorization
Coming soon...