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

* [Controller](https://github.com/mycozycloud/cozy-controller): the PaaS that run the various applications ![Build Status](https://travis-ci.org/mycozycloud/cozy-controller.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-controller.png)
* [Data System](https://github.com/mycozycloud/cozy-data-system): unified persistence layer ![Build Status](https://travis-ci.org/mycozycloud/cozy-data-system.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-data-system.png)
* [Proxy](https://github.com/mycozycloud/cozy-proxy): handles registrer and authentication ![Build Status](https://travis-ci.org/mycozycloud/cozy-proxy.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-proxy.png)
* [Home](https://github.com/mycozycloud/cozy-home): end-user friendly Cozy manager ![Build Status](https://travis-ci.org/mycozycloud/cozy-home.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-home.png)
* [Indexer](https://github.com/mycozycloud/cozy-data-indexer)

The last one is not a true Cozy component but is used to install and manage self-hosted Cozy: [cozy-setup](https://github.com/mycozycloud/cozy-setup).

## Modules / Libraries
This is a set a of libraries developed and maintained by Cozycloud that are used in Cozy.

### Generic
* [request-json](https://github.com/mycozycloud/request-json): simple JSON-only requests ![Build Status](https://travis-ci.org/mycozycloud/request-json.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/request-json.png)
* [cozy-vcard](https://github.com/mycozycloud/cozy-vcard): a vcard parser ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-vcard.png)
* [cozy-ical](https://github.com/mycozycloud/cozy-ical): an iCal parser ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-ical.png)
* [americano](https://github.com/mycozycloud/americano): makes Expressjs more opinionated about configuration ![Build Status](https://travis-ci.org/mycozycloud/americano.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/americano.png)

### Cozy specific
* [americano-cozy](https://github.com/mycozycloud/americano-cozy): an americano plugin to ease the use of the Data System ![Dependencies Status](https://david-dm.org/mycozycloud/americano-cozy.png)
* [cozy-realtime-adapter](https://github.com/mycozycloud/cozy-realtime-adapter): let your app be notified in realtime of changes ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-realtime-adapter.png)
* [cozy-notifications-helper](https://github.com/mycozycloud/cozy-notifications-helper): east notifications for your app ![Build Status](https://travis-ci.org/mycozycloud/cozy-notifications-helper.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-notifications-helper.png)
* [cozy-i18n-helper](https://github.com/mycozycloud/cozy-i18n-helper): enable localization in your application with no effort ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-i18n-helper.png)
* [jugglingdb-cozy-adapter](https://github.com/mycozycloud/jugglingdb-cozy-adapter): Data System ODM plugin ![Build Status](https://travis-ci.org/mycozycloud/jugglingdb-cozy-adapter.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/jugglingdb-cozy-adapter.png)
* [cozy-clearance](https://github.com/aenario/cozy-clearance): sharing feature in a snap of a finger ![Dependencies Status](https://david-dm.org/aenario/cozy-clearance.png)

## Tools
Using/developping with Cozy is easy thanks to the existing tools:

* [cozy-monitor](https://github.com/mycozycloud/cozy-monitor): easy Cozy management ([full documentation](/host/manage.html)) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-monitor.png)
* [cozy-manager](https://github.com/mycozycloud/cozy-manager): your best friend to developer Cozy applications ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-manager.png)
* [cozy-fixtures](https://github.com/mycozycloud/cozy-fixtures): add fixtures to the database to test your application ![Build Status](https://travis-ci.org/mycozycloud/cozy-fixtures.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-fixtures.png)

## Applications

### Official
These applications are officially maintained by Cozycloud:

* [Files](https://github.com/mycozycloud/cozy-files): files and folder management ![Build Status](https://travis-ci.org/mycozycloud/cozy-files.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-files.png)
* [Calendar](https://github.com/mycozycloud/cozy-calendar): easy yet powerful calendar management ![Build Status](https://travis-ci.org/mycozycloud/cozy-calendar.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-calendar.png)
* [Contacts](https://github.com/mycozycloud/cozy-contacts): a personal relationships manager ![Build Status](https://travis-ci.org/mycozycloud/cozy-contacts.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-contacts.png)
* [Webdav](https://github.com/mycozycloud/cozy-webdav): contact and calendar synchronization ![Build Status](https://travis-ci.org/mycozycloud/cozy-webdav.png?branch=master) ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-webdav.png)

### Community contributions
These applications have been released by members of the Community or by Cozycloud (but aren't officially maintained)

* [Bookmarks](https://github.com/Piour/cozy-bookmarks): manage your brower's bookmarks ![Dependencies Status](https://david-dm.org/Piour/cozy-bookmarks.png)
* [Cozic](https://github.com/rdubigny/cozy-music): your music whenever you need it ![Dependencies Status](https://david-dm.org/rdubigny/cozy-music.png)
* [Databrowser](https://github.com/n-a-n/cozy-databrowser): browse all your data ![Dependencies Status](https://david-dm.org/n-a-n/cozy-databrowser.png)
* [Feeds](https://github.com/Piour/cozy-feeds): a RSS feed reader ![Dependencies Status](https://david-dm.org/Piour/cozy-feeds.png)
* [Konnectors](https://github.com/frankrousseau/konnectors): bring more data to your Cozy ![Dependencies Status](https://david-dm.org/frankrousseau/konnectors.png)
* [KYou](https://github.com/frankrousseau/kyou): Know Yourself through various measures ![Dependencies Status](https://david-dm.org/frankrousseau/kyou.png)
* [MesComptes](https://github.com/seeker89/cozy-pfm): manage your banking accounts ![Dependencies Status](https://david-dm.org/seeker89/cozy-pfm.png)
* [Nirc](https://github.com/frankrousseau/cozy-nirc): an IRC client ![Dependencies Status](https://david-dm.org/frankrousseau/cozy-nirc.png)
* [Notes](https://github.com/mycozycloud/cozy-notes): self-explanatory ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-notes.png)
* [OWM](https://github.com/Piour/piour-cozy-owm): weather forecast ![Dependencies Status](https://david-dm.org/Piour/piour-cozy-owm.png)
* [Photos](https://github.com/mycozycloud/cozy-photos): manage and share your photos ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-photos.png)
* [Todos](https://github.com/mycozycloud/cozy-todos): list, prioritize, be more productive ![Dependencies Status](https://david-dm.org/mycozycloud/cozy-todos.png)
