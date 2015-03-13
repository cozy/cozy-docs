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
This token should be sent in 'x-auth-token' request header. This token is stored in **/etc/cozy/stack.token** by default but this is configurable. Accessing it requires `sudo` privileges.

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

### Get all applications
```http
GET apps/all
Response:
  Status code: 200|400|500
  Body
    200: {app: applications list}
    400: {error: "the error message"}
    500: {error: "the error message"}
```

### Get all started applications
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

For version 1.0.28 or older, controller doesn't support new API. This section describe API for old controller.
Controller with more recent version supports old and new API.

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

### Get all running applications
```http
GET drones/running
Response:
  Status code: 200|500
  Body
    200: {app: applications list}
    500: {error: "the error message"}
```

## Disk info API

### Get information about disk usage
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

Configuration are stored in file **/etc/cozy/controller.json**.
Every configurations are optional.

Configuration file is avaible only for new controller.

### Common configuration

* **npm_registry**:
  * Specify a npm registry.
  * Use common npm registry by default.
* **npm_strict_ssl**:
  * Specify if you want use strict ssl option with npm.
  * By default : false.

<!--
* **dir_log**:
  * Directory where application logs are stored
  * By default: '/var/log/cozy'.
* **dir_source**:
  * Directory where application code source are stored
  * By default: '/usr/local/cozy/apps'.
-->

### Environment configuration

You can transmit specific environment variables to cozy applications.
For that, you should add them in controller file configuration.

In field `env`, you can add `global` field. Environment variables  will transmit to all applications started by controller.
If you want transmit environment variable to a specific application, you should add `"<application name>": list of environment variables`

* env :
    * global: Transmits environment variables to all applications started by controller
    * data_system: Transmits environment variables to data system
    * home: Transmits environment variables to home
    * proxy: Transmits environment variables to proxy


### File configuration example
```json
{
  "npm_registry": https://my-registry.com,
  "npm_strict_ssl": true,
  "env":
    {
      "global": {"STACK": "cozy", "DEMO": "true"},
      "data_system": {"DB": "mydatabase"},
      "home": {"PORT": 9103},
      "proxy": {"PORT": 9104}
    }
}
```

## Files used

Controller stores several files in **/etc/cozy**, **/usr/local/cozy** and **/usr/local/var/log/cozy**.

In **/etc/cozy**, controller stores configurations:
  * **controller.json**: Contains controller configurations (see [Configuration section](controller.html#configuration))
  * **stack.token**: Contains token shared by cozy stack (Controller, Data system, Home and Proxy). This token is generated at each controller starting.
  * **.controller.json-backup**: Hidden file, used for configuration changes.

In **/usr/local/cozy**, controller stores information about applications:
  * **apps**: Contains all application source code.
  * **apps/stack.json**: Contains information about stack cozy (git repository, branch, start script, ...).

In **/usr/local/var/log/cozy**, controller stores all application logs:
  * **app.log**: Logs for application app.

## Autostart

When controller is started, it starts all applications that were running before it stops.

Autostart has several steps :

  * Check if couchdb server is started
    * Controller try 5 times (with 5 seconds between two tests)
    * If couchDB server doesn't respond, controller is stopped
  * Check if stack applications are installed
    * If Data System is not installed, controller starts without starts other applications
  * Start Data System application
    * If Data System cannot start, controller is stopped
  * Retrieve all application stored in database
    * Start all application which have 'installed' as state
  * Start Home application
  * Start Proxy application