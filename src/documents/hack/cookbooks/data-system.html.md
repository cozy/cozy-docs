---
title: "The Data System API"
layout: "default"
category: "hack"
menuOrder: 1
---

# The Data System API

## Data API

This api is used to manage data directly with 4 common operations : create, read, update and delete and utiliy functions like exist, find or merge.

All data are written with JSON (request and response). 200 code is default success response. 404 is returned when corresponding document is not found and 500 is returned when server error occured.

```http
GET /data/exist/:id/    Answer: {exist: true/false}.
GET /data/:id/          Get document equal to ID.
POST /data/             Create a document and generate a new ID for it.
                        Doc is sent as reponse  {_id:<generated id>,...} with 201 as response code.
POST /data/:id/         Create document and assign it given ID.
PUT  /data/:id/         Update document :id. Old version is fully overwrittend by the new one.
PUT  /data/upsert/:id/  Update or create document equal to ID.
                        201 response code is send in case of creation.
DELETE /data/:id/       Delete document: id. 204 is returned when success occurs.
PUT /data/merge/:id/    Update document: id only for given fields
```

## Request API

Request API is used to retrieve documents depending on their properties through CouchDB views.

```http
POST /request/:type/:req_name/      Return requests result.
                                    Return a table key/value given by corresponding CouchDB view.
                                    Params:
                                       key: returns only documents for this key
                                       limit: number of documents returned
                                       skip: number of documents to skip
                                       startkey: returns only documents since this key
                                       endkey: returns only documents until this key

PUT /request/:type/:req_name/         Create or update view corresponding to request name.
                                      Params:
                                         map: map function
                                         reduce: reduce function (optional)
PUT /request/:type/:req_name/destroy/  Delete all docs that should be returned by this request.
                                      Accept same params as POST /request/:req_name
DELETE /request/:type/:req_name/     Delete view :req_name. Return 204 if it succeeds
```

## Attachments API
```http
  POST /data/:id/attachments/           Expect a file send through a multipart form.
                                        Save this file as attachment of document :id
                                        Form params:
                                            name: Force the file name.
  GET /data/:id/attachments/:name       Download file :name attached to document :id
  DELETE /data/:id/attachments/:name    Remove file :name attached to document :id
```

## Indexer API
```http
POST /data/index/:id           Index given field for document :id
                               Params:
                                    fields: An array of text fields that must be indexed.
POST /data/search/:type        Send the 10 documents that match the best given query
                               Params:
                                    query: string search query
DELETE /data/index/:id         Remove indexation for document :id
DELETE /data/index/clear-all/  Clear all indexes
```

### API account

This API is used to manage accounts. An account must have a field 'pwd' that will be encrypt in the database.

200 code is default success response. 404 is returned when corresponding document is not found and 500 is returned when server error occured.
```http
POST /account/                 Create a new account and assign it a new ID
                               The ID is sent as reponse with 201 as response code.
POST /account/:id/             Create a new account and assign it given ID
                               The ID is sent as reponse with 201 as response code.
GET /account/:id/              Find account with given ID in the database
                               The account is sent as response.
GET /account/exist/:id/        Check existence of account with given ID
                               The answer {exist: true/false} is sent.
PUT /account/:id/              Update account with given ID
                               Old version is overase by the new one.
PUT /account/merge/:id/        Update given fields of account with given ID
PUT /account/upsert/:id/       Update account with given ID if it exists
                               Create a new account if it doesn't exist, generate id automatically
                               201 as response code is sent in case of a creation
DELETE /account/:id/           Delete account with given ID
                               204 as response code is sent.
```

## Accounts API

This API is used to manage keys that encrypt data of accounts.

```http
POST /accounts/password/        Initialize keys with the cozy password
                                The cozy password must be in the field 'pwd'
PUT /accounts/password/         Update keys with a change of the cozy password
                                The cozy password must be in the field 'pwd'
DELETE /accounts/               Delete keys
```