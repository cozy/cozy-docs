# [Cozy](http://cozy.io) Docs

Cozy Docs is the source repository for the [cozy.io](http://cozy.io) website.

## Contribution

Any contribution about the documentation is welcome: typos, new way to install,
additional information, etc.

## Hack

If you would like to contribute to the documentation, clone the repository:

    git clone https://github.com/cozy/cozy-docs.git

Now you can switch into the created directory and make some changes. If you want to build the documentation, you need to install [docpad](https://docpad.org) and its plugin for jade first. You can do so by:

    npm install -g docpad
    docpad install jade

After that, execute the following commands in the project directory:

    npm install
    docpad run

You can see the documentation being served on: http://localhost:9778/en/. Do not be irritated if you see only a plain text page welcoming you, append the appropriate path for the page you would like to see, in example: http://localhost:9778/en/hack/getting-started/

## Icons

by [iconmonstr](http://iconmonstr.com/)

## License

Cozy Home is developed by Cozy Cloud and distributed under the AGPL v3 license.

## What is Cozy?

![Cozy Logo](https://raw.github.com/cozy/cozy-setup/gh-pages/assets/images/happycloud.png)

[Cozy](http://cozy.io) is a platform that brings all your web services in the
same private space.  With it, your web apps and your devices can share data
easily, providing you with a new experience. You can install Cozy on your own
hardware where no one profiles you.

## Community

You can reach the Cozy Community by:

* Chatting with us on IRC #cozycloud on irc.freenode.net
* Posting on our [Forum](https://forum.cozy.io/)
* Posting issues on the [Github repos](https://github.com/cozy/)
* Mentioning us on [Twitter](http://twitter.com/mycozycloud)
