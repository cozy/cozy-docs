---
title: "Debug your application"
layout: "default"
category: "hack"
menuOrder: 6
toc: true
---

# Debug your application

You might want to debug your cozy application.

**Note:** Cozy uses CoffeeScript almost everywhere, but so far the debugging remains in Javascript, be ready :-D

## Install dependencies

```bash
npm install -g node-inspector
```

## Start the debugger

By default, the debugger uses the port 5858 to transport debugging informations (as WebSocket), and the 8080 port to serve static files.
You might want to open those ports in the Vagrantfile if you use the [Cozy virtal environment](http://cozy.io/hack/getting-started/setup-environment.html).

```bash
node-inspector &
```

**Note:** Append `--web-host 0.0.0.0` to listen globally

Go to http://127.0.0.1:8080/debug?port=5858 (or your container's IP address) to see the debugger.
It only works on Chrome/Chromium and Opera.

## Debug !

You can manually add a breakpoint in your sources with the keyword `debugger`. Then launch your coffee server in "breaking debug mode".

```bash
coffee --nodejs --debug-brk server.coffee
```

The init will pause at the first Javascript line: Go to the debugger and press the "play" button to resume it.
It will break again on your `debugger` instruction.

---

**Happy debbugging !**

