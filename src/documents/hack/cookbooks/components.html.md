---
title: "Components"
layout: "default"
category: "hack"
menuOrder: 6
toc: true
---

# Components

Here is a list that references the components of Cozy.

## The stack
What we call the "stack" are the core components of Cozy:

* [Controller](https://github.com/mycozycloud/cozy-controller): the PaaS that run the various applications [![Build Status](https://travis-ci.org/mycozycloud/cozy-controller.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-controller) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-controller.png)](https://david-dm.org/mycozycloud/cozy-controller)
* [Carapace](https://github.com/mycozycloud/cozy-controller-carapace): the process wrapper for NodeJS the controller uses [![Build Status](https://travis-ci.org/mycozycloud/cozy-controller-carapace.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-controller-carapace) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-controller-carapace.png)](https://david-dm.org/mycozycloud/cozy-controller-carapace)
* [Data System](https://github.com/mycozycloud/cozy-data-system): unified persistence layer [![Build Status](https://travis-ci.org/mycozycloud/cozy-data-system.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-data-system) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-data-system.png)](https://david-dm.org/mycozycloud/cozy-data-system)
* [Proxy](https://github.com/mycozycloud/cozy-proxy): handles registrer and authentication [![Build Status](https://travis-ci.org/mycozycloud/cozy-proxy.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-proxy) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-proxy.png)](https://david-dm.org/mycozycloud/cozy-proxy)
* [Home](https://github.com/mycozycloud/cozy-home): end-user friendly Cozy manager [![Build Status](https://travis-ci.org/mycozycloud/cozy-home.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-home) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-home.png)](https://david-dm.org/mycozycloud/cozy-home)
* [Indexer](https://github.com/mycozycloud/cozy-data-indexer)

The last one is not a true Cozy component but is used to install and manage self-hosted Cozy: [cozy-setup](https://github.com/mycozycloud/cozy-setup).

## Modules / Libraries
This is a set a of libraries developed and maintained by Cozycloud that are used in Cozy.

### Generic
* [request-json](https://github.com/mycozycloud/request-json): simple JSON-only requests [![Build Status](https://travis-ci.org/mycozycloud/request-json.png?branch=master)](https://travis-ci.org/mycozycloud/request-json) [![Dependencies Status](https://david-dm.org/mycozycloud/request-json.png)](https://david-dm.org/mycozycloud/request-json)
* [cozy-vcard](https://github.com/mycozycloud/cozy-vcard): a vcard parser [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-vcard.png)](https://david-dm.org/mycozycloud/cozy-vcard)
* [cozy-ical](https://github.com/mycozycloud/cozy-ical): an iCal parser [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-ical.png)](https://david-dm.org/mycozycloud/cozy-ical)
* [americano](https://github.com/mycozycloud/americano): makes Expressjs more opinionated about configuration [![Build Status](https://travis-ci.org/mycozycloud/americano.png?branch=master)](https://travis-ci.org/mycozycloud/americano) [![Dependencies Status](https://david-dm.org/mycozycloud/americano.png)](https://david-dm.org/mycozycloud/americano)

### Cozy specific
* [americano-cozy](https://github.com/mycozycloud/americano-cozy): an americano plugin to ease the use of the Data System [![Dependencies Status](https://david-dm.org/mycozycloud/americano-cozy.png)](https://david-dm.org/mycozycloud/americano-cozy)
* [cozy-realtime-adapter](https://github.com/mycozycloud/cozy-realtime-adapter): let your app be notified in realtime of changes [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-realtime-adapter.png)](https://david-dm.org/mycozycloud/cozy-realtime-adapter)
* [cozy-notifications-helper](https://github.com/mycozycloud/cozy-notifications-helper): east notifications for your app [![Build Status](https://travis-ci.org/mycozycloud/cozy-notifications-helper.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-notifications-helper) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-notifications-helper.png)](https://david-dm.org/mycozycloud/cozy-notifications-helper)
* [cozy-i18n-helper](https://github.com/mycozycloud/cozy-i18n-helper): enable localization in your application with no effort [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-i18n-helper.png)](https://david-dm.org/mycozycloud/cozy-i18n-helper)
* [jugglingdb-cozy-adapter](https://github.com/mycozycloud/jugglingdb-cozy-adapter): Data System ODM plugin [![Build Status](https://travis-ci.org/mycozycloud/jugglingdb-cozy-adapter.png?branch=master)](https://travis-ci.org/mycozycloud/jugglingdb-cozy-adapter) [![Dependencies Status](https://david-dm.org/mycozycloud/jugglingdb-cozy-adapter.png)](https://david-dm.org/mycozycloud/jugglingdb-cozy-adapter)
* [cozy-clearance](https://github.com/aenario/cozy-clearance): sharing feature in a snap of a finger [![Dependencies Status](https://david-dm.org/aenario/cozy-clearance.png)](https://david-dm.org/aenario/cozy-clearance)

## Tools
Using/developping with Cozy is easy thanks to the existing tools:

* [cozy-monitor](https://github.com/mycozycloud/cozy-monitor): easy Cozy management ([full documentation](/host/manage.html)) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-monitor.png)](https://david-dm.org/mycozycloud/cozy-monitor)
* [cozy-manager](https://github.com/mycozycloud/cozy-manager): your best friend to developer Cozy applications [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-manager.png)](https://david-dm.org/mycozycloud/cozy-manager)
* [cozy-fixtures](https://github.com/mycozycloud/cozy-fixtures): add fixtures to the database to test your application [![Build Status](https://travis-ci.org/mycozycloud/cozy-fixtures.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-fixtures) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-fixtures.png)](https://david-dm.org/mycozycloud/cozy-fixtures)

## Applications

### Official
These applications are officially maintained by Cozycloud:

* [Files](https://github.com/mycozycloud/cozy-files): files and folder management [![Build Status](https://travis-ci.org/mycozycloud/cozy-files.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-files) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-files.png)](https://david-dm.org/mycozycloud/cozy-files)
* [Calendar](https://github.com/mycozycloud/cozy-calendar): easy yet powerful calendar management [![Build Status](https://travis-ci.org/mycozycloud/cozy-calendar.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-calendar) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-calendar.png)](https://david-dm.org/mycozycloud/cozy-calendar)
* [Contacts](https://github.com/mycozycloud/cozy-contacts): a personal relationships manager [![Build Status](https://travis-ci.org/mycozycloud/cozy-contacts.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-contacts) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-contacts.png)](https://david-dm.org/mycozycloud/cozy-contacts)
* [Webdav](https://github.com/mycozycloud/cozy-webdav): contact and calendar synchronization [![Build Status](https://travis-ci.org/mycozycloud/cozy-webdav.png?branch=master)](https://travis-ci.org/mycozycloud/cozy-webdav) [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-webdav.png)](https://david-dm.org/mycozycloud/cozy-webdav)

### Community contributions
These applications have been released by members of the Community or by Cozycloud (but aren't officially maintained)

* [Bookmarks](https://github.com/Piour/cozy-bookmarks): manage your brower's bookmarks [![Dependencies Status](https://david-dm.org/Piour/cozy-bookmarks.png)](https://david-dm.org/Piour/cozy-bookmarks)
* [Cozic](https://github.com/rdubigny/cozy-music): your music whenever you need it [![Dependencies Status](https://david-dm.org/rdubigny/cozy-music.png)](https://david-dm.org/rdubigny/cozy-music)
* [Databrowser](https://github.com/n-a-n/cozy-databrowser): browse all your data [![Dependencies Status](https://david-dm.org/n-a-n/cozy-databrowser.png)](https://david-dm.org/n-a-n/cozy-databrowser)
* [Feeds](https://github.com/Piour/cozy-feeds): a RSS feed reader [![Dependencies Status](https://david-dm.org/Piour/cozy-feeds.png)](https://david-dm.org/Piour/cozy-feeds)
* [Konnectors](https://github.com/frankrousseau/konnectors): bring more data to your Cozy [![Dependencies Status](https://david-dm.org/frankrousseau/konnectors.png)](https://david-dm.org/frankrousseau/konnectors)
* [KYou](https://github.com/frankrousseau/kyou): Know Yourself through various measures [![Dependencies Status](https://david-dm.org/frankrousseau/kyou.png)](https://david-dm.org/frankrousseau/kyou)
* [MesComptes](https://github.com/seeker89/cozy-pfm): manage your banking accounts [![Dependencies Status](https://david-dm.org/seeker89/cozy-pfm.png)](https://david-dm.org/seeker89/cozy-pfm)
* [Nirc](https://github.com/frankrousseau/cozy-nirc): an IRC client [![Dependencies Status](https://david-dm.org/frankrousseau/cozy-nirc.png)](https://david-dm.org/frankrousseau/cozy-nirc)
* [Notes](https://github.com/mycozycloud/cozy-notes): self-explanatory [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-notes.png)](https://david-dm.org/mycozycloud/cozy-notes)
* [OWM](https://github.com/Piour/piour-cozy-owm): weather forecast [![Dependencies Status](https://david-dm.org/Piour/piour-cozy-owm.png)](https://david-dm.org/Piour/piour-cozy-owm)
* [Photos](https://github.com/mycozycloud/cozy-photos): manage and share your photos [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-photos.png)](https://david-dm.org/mycozycloud/cozy-photos)
* [Todos](https://github.com/mycozycloud/cozy-todos): list, prioritize, be more productive [![Dependencies Status](https://david-dm.org/mycozycloud/cozy-todos.png)](https://david-dm.org/mycozycloud/cozy-todos)
