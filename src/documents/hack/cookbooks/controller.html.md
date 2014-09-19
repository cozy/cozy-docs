---
title: "The Controller API"
layout: "default"
category: "hack"
menuOrder: 2
toc: true
---

# The Controller API

The Controller API allows applications management

## Generic notes

All the responses' bodies are encoded in JSON and all the data you send along request should be encoded in JSON.

You will find HTTP status code for the response, here is what they mean:

* 200: success
* 400: bad request
* 401: not authenticated
* 403: unauthorized
* 500: internal server error


All application are declared in a manifest .... 

Application should be authenticated to request controller. 

Authentication is based on token shared by all cozy stack.
This token should be send in 'x-auth-token' field in request header. Monitor can acces to this token thanks file "/etc/cozy/stack.token" 
where token is stored.

## New application API

This API lets you manage application with four common operations: install, start, stop, update and uninstall.

### Install an application
```http
POST apps/:name/install
Param:
  name: the application name
  Body {"start": application manifest}
Response:
  Status code: 200|400|500
  Body
    200: {drone: {port: "application port"}}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Start an application
```http
POST apps/:name/start
Param:
  name: the application name
  Body {"start": application manifest}
Response:
  Status code: 200|400|500
  Body
    200: {drone: {port: "application port"}}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.
Return an error if application is not installed.

### Stop an application
```http
POST apps/:name/stop
Param:
  name: the application name
Response:
  Status code: 200|400|500
  Body
    200: {app: "application name"}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.
Return an error if application is not installed.

### Update an application
```http
POST apps/:name/update
Param:
  name: the application name
Response:
  Status code: 200|400|500
  Body
    200: {app: "application name"}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.
Return an error if application is not installed.

### Uninstall an application
```http
POST apps/:name/uninstall
Param:
  name: the application name
Response:
  Status code: 200|400|500
  Body
    200: {app: "application name"}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.
Return an error if application is not installed.

### Recover all applications
```http
GET apps/all
Response:
  Status code: 200|400|500
  Body
    200: {app: applications list}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Recover all started applications
```http
GET apps/started
Response:
  Status code: 200|400|500
  Body
    200: {app: applications list}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

## Old application API

### Install application
```http
POST drones/:name/start
Param:
  name: the application name
  Body {"start": application manifest}
Response:
  Status code: 200|400|500
  Body
    200: {drone: {port: "application port"}}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Start application
```http
POST drones/:name/start
Param:
  name: the application name
  Body {"start": application manifest}
Response:
  Status code: 200|400|500
  Body
    200: {drone: {port: "application port"}}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.

### Stop application
```http
POST drones/:name/stop
Param:
  name: the application name
  Body {"stop": { "name": "application manifest"}}
Response:
  Status code: 200|400|500
  Body
    200: {app: "application name"}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.
Return an error if application is not installed.

### Update application
```http
POST drones/:name/light-update
Param:
  name: the application name
  Body {"update": { "name": "application manifest"}}
Response:
  Status code: 200|400|500
  Body
    200: {app: "application name"}
    400: {error: "the error message"}
    500: {error: "the error message"}
```
Requires authentication and authorization.
Return an error if application is not installed.

### Uninstall application
```http
POST drones/:name/clean
Param:
  name: the application name
  Body { "name": "application manifest"}
Response:
  Status code: 200|500
  Body
    200: {app: "application name"}
    500: {error: "the error message"}
```
Requires authentication and authorization.
Return an error if application is not installed.

### Recover all running applications
```http
GET drones/running
Response:
  Status code: 200|500
  Body
    200: {app: applications list}
    500: {error: "the error message"}
```
Requires authentication and authorization.

## Disk info API

### Recover information about disk usage
```http
GET diskinfo
Response:
  Status code: 200|500
  Body
    200: {"freeDiskSpace": free disk space,
          "usedDiskSpace": used disk space,
          "totalDiskSpace": total disk space}
    500: {error: "the error message"}
```
Requires authentication and authorization.

## Configuration

Configuration are stored in file '/etc/cozy/controller.json'
Every configuration are optional

<!---

### Common configuration

* **npm_registry**: 
  * Specify a npm registry.
  * Use common npm registry by default.
* **npm_strict_ssl**: 
  * Specify if you want use strict ssl option with npm.
  * By default : false.
* **dir_log**: 
  * Directory where application logs are stored
  * By default: '/var/log/cozy'.
* **dir_source**: 
  * Directory where application code source are stored
  * By default: '/usr/local/cozy/apps',
* **file_token**: 
  * File where stack token  are stored
  * By default: '/etc/cozy/stack.token',
* **file_stack**: 
  * File where stack information are stored 
  * Format: json file
  * By default: '/usr/local/cozy/apps/stack.json',

### Environement configuration

* env :
    * global
    * data_system
    * home
    * proxy


if data.env?
    conf.env =
        global:         data.env.global || false
        data_system:    data.env.data_system || false
        home:           data.env.home || false
        proxy:          data.env.proxy || false

### Configuration changes (pertinence ?????)

oldConf =
        dir_log :           data.old.dir_log || false
        dir_source :        data.old.dir_source || false
        file_stack :        data.old.file_stack || false

### First patch (pertinence ????)

* **patch**
  * Fomat: Number
  * Usefull between 

-->

### File configuration example
```json
{
  "npm_registry": https://my-registry.com,
  "npm_strict_ssl": true,
  "dir_log": "/usr/local/logs",
  "dir_source": "/usr/local/myapps",
  "file_token": "/usr/local/stack.token",
  "file_stack": "/usr/local/stack.json",
  "env":
    {
      "global": {"STACK": "cozy"},
      "data_system": {"DB": "mydatabase"},
      "home": {"PORT": 9103},
      "proxy": {"PORT": 9104}      
    }
}
```

Coming soon ...

## Autostart

Coming soon ....