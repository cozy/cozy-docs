---
title: "Official Cozy skeleton"
layout: "default"
category: "hack"
menuOrder: 1
toc: true
---

# Official Cozy Skeleton
The official Cozy skeleton comes in both JavaScript and CoffeeScript.
You can find the code in the following repositories:

* [JavaScript version](https://github.com/mycozycloud/cozy-template)
* [CoffeeScript version](https://github.com/mycozycloud/cozy-template-coffee)


## Technologies

### Server
* Americano for the NodeJS framework
* JugglingDB Cozy Adapter to access the Data System (plugin americano-cozy)
* Mocha, Chai, Request-JSON, cozy-fixtures and coffeelint for dev mode (tests, fixture management, code style checking)

### Client
* Backbone for the Single Page App
* Brunch as the building tool

## File structure
Here are the main file structure elements:

* server/ -- Americano file structure
    * controllers/
        * routes.[js|coffee]
    * models/
        * requests.[js|coffee]
    * config.[js|coffee]
* client/
    * app/
        * assets/ -- non-backbone stuff, images, fonts
        * -- all the Backbone stuff
    * vendor/ -- files to append to vendor.js and app.css
    * public/ -- the public output file, 100% generated
    * config.[js|coffee] -- Brunch config file
* server.[js|coffee]
* package.json
* Cakefile

## Cakefile tasks

### Tests
```bash
cake tests [--env $NODE_ENV_VALUE]
```

### Linter
```bash
cake lint
```

The code style rules we use are the following:

* indentation: 4 spaces
* maximum line width: 80 characters
* no empty parameter list (Coffee)
