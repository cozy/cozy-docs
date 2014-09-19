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
* 500: internal server error


Application should be authenticated to request controller. 

Authentication is based on a token shared by all the Cozy stack.
This token should be sent in 'x-auth-token' request header. This token is stored in "/etc/cozy/stack.token" by default but this is configurable. Accessing it requires `sudo` privileges.

## Application manifest

Application are declared in a manifest.

Manifest example :

```json
manifest =
    user: "cozy",      # Required, user which start the application                 
    name: "note",                                                 
    domain: "localhost",           
    repository:                   
        type: "git",                 
        url: "https://github.com/mycozycloud/cozy-notes.git",
    scripts:                    
        start: "server.js"
```


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
Return an 400 error if application is not installed.

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
Return an 400 error if application is not installed.

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
Return an 400 error if application is not installed.

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
Return an 400 error if application is not installed.

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
Return an 400 error if application is not installed.

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
Return an 400 error if application is not installed.

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
Return an 400 error if application is not installed.

### Recover all running applications
```http
GET drones/running
Response:
  Status code: 200|500
  Body
    200: {app: applications list}
    500: {error: "the error message"}
```

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

## Configuration

Configuration are stored in file '/etc/cozy/controller.json'
Every configuration are optional
Configuration file are avaible only for new controller (not already published)

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
  * By default: '/usr/local/cozy/apps'.

### Environement configuration

* env :
    * global
    * data_system
    * home
    * proxy


### File configuration example
```json
{
  "npm_registry": https://my-registry.com,
  "npm_strict_ssl": true,
  "dir_log": "/usr/local/logs",
  "dir_source": "/usr/local/myapps",
  "env":
    {
      "global": {"STACK": "cozy"},
      "data_system": {"DB": "mydatabase"},
      "home": {"PORT": 9103},
      "proxy": {"PORT": 9104}      
    }
}
```

## Autostart

Coming soon ....