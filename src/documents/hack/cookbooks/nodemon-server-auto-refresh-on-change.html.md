---
title: "Using nodemon to auto-refresh the server on code change"
layout: "default"
category: "hack"
menuOrder: 5
toc: true
---

# Using nodemon to auto-refresh the server on code change

Following [@mihneadb](https://github.com/mihneadb)'s advice, here is a quick guide that will save you the pain to interrupt and restart your server every time you make a change thanks to [nodemon](https://github.com/remy/nodemon).

## Installation
The most simple way you can imagine for a node package:
```bash
npm install -g nodemon
```

## Usage
Instead of running your app like you are used to:

```bash
node server.js
```

You can use nodemon:

```bash
nodemon server.js
```

It also works with Coffee Script:
```bash
nodemon server.coffee
```

Note that the first start can be slow but it's totally acceptable.

That's it, why did we do differently before that?