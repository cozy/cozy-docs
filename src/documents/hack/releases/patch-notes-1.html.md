---
title: "Patch notes #1"
layout: "default"
category: "hack"
toc: true
menuOrder: 1
---

# Patch note #1
This relates development from 2015/02/09 to 2015/02/20.

## Applications
### Calendar (v1.0.8)
* better favicons.
* better fonts declaration.
* use the fonts from Proxy.

### Contacts (v1.1.1)
* add colors to tags
* better responsive (for small screen).
* better name edition

### Emails (v0.6.8)
* better responsive (for small sreen).
* on mobile, you can only read emails, not write them.
* add keyboard shortcuts to navigate within a conversation.
* show full message headers when clicking on attachment icon.
* improve button styles.
* opening a message should be faster (no more transitions effects).
* remove browser auto-complete when composing an email.
* only display contact tooltip in the email preview.
* fix behaviour when email had no content.
* fix closing a message could lead to another mailbox.
* fix infinite scrolling.
* add missing localization.
* improve performances.
* remove progressbar during refresh, it is only shown during initial import.
* add keyboard shortcuts to navigate inside a conversation (left and right arrows).
* message list toolbar is now fixed
* message list height stays the same in selection mode
* only display contact tooltip in message panel for current message
* switch to cozydb [internal].
* tests can now be run with SlimerJS [internal].
* minor improvements in development tasks and readme [internal].


### Files (v1.1.2)
* better responsive (for small screen).
* better favicons.
* better fonts.
* use the fonts from Proxy.
* fix last modification date
* add checksum support

### Photos (v1.0.7)
* better responsive (for small screen).
* better favicons.
* better fonts.

## Mobile application (v0.1.2)
* better navigation: new breadcrumb.
* better navigation: fix touch interactions.
* better navigation: physical button recovers navigation history.
* better icons.
* enable landscape view.

## Platform
### Proxy (v1.0.12)
* better icons (Cozy's icon, favicon).
* better fonts declaration.
* better responsive (for small sreen).
* provide official Cozy fonts as a CDN.

### Home (v1.0.38)
* better responsive (small screen)
* better favicons.
* better fonts declaration.
* use the fonts from Proxy.
* fix navigation in Firefox mobile.
* fix application's icons for applications installed from Git.

### Data System (v1.0.26)
* fix: if there was no display name or no domain, "send mail from" bugged.

### Controller (v2.0.16)
* stop stack applications before updating them (partly fix issue of double-login during platform update).
* update 'Proxy' before 'Home' during stack update (partly fix issue of double-login during platform update).
* improve logs when application crashes.
* code improvements.
* check app's branch during update (fix [this issue](https://github.com/cozy/cozy-home/issues/278))

### cozy-monitor (v1.2.15)
* better error handling.
* fix status command.
* improve feedbacks and readme (thank you [bnj](https://github.com/bnjbvr/))
* fix typo (thank you [bnj](https://github.com/bnjbvr/))

## Development tools

### Documentation
* update 'getting started': links to vendors are fixed ([link](http://cozy.io/hack/getting-started/setup-environment.html)).
* update 'first app': use the new "deploy" command ([link](http://cozy.io/hack/getting-started/first-app.html)).
* update 'Cozy architecture': new diagrams, more explanations ([link](http://cozy.io/hack/getting-started/architecture-overview.html)).
* new cookbook: understanding Cozy's development environment ([link](http://cozy.io/hack/cookbooks/understanding-dev-environment.html)).
* remove install guide for Raspberry Pi.
* add install guide for Raspberry Pi 2 ([link](http://cozy.io/host/install.html#raspberry-pi-2-image)).

### cozy-dev (v1.0.15)
* new command: vm:update-image. Destroy and get the latest image version ([link](http://cozy.io/hack/cookbooks/understanding-dev-environment.html#vm-update-image)).
* new commands: deploy, undeploy. Make accessible through Cozy interface your local application ([link](http://cozy.io/hack/cookbooks/understanding-dev-environment.html#deploy)).
* new command: db:switch. Switch the database used by the Data System in the VM (useful for testing purposes) ([link](http://cozy.io/hack/cookbooks/understanding-dev-environment.html#db-switch)).
* new command: db:reset. Remove all data from a database (useful for testing purposes) ([link](http://cozy.io/hack/cookbooks/understanding-dev-environment.html#db-reset)).
* improve command: vm:start. VM's status is now displayed at start up.
* improve command: vm:status. Now displays the port forwarded for each part.

### Virtual machine
* new version.

### cozy-template (v1.0.0)
* clean useless code.
* use Cozy fonts.

## Guidelines
* add guildelines for stylus ([link](https://github.com/cozy/cozy-guidelines#css--stylus)).
* update localization guidelines ([link](https://github.com/cozy/cozy-guidelines#localisation)).

