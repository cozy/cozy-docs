---
title: "Localize your applications"
layout: "default"
category: "hack"
menuOrder: 3
---

# Localize your applications
To improve your application user experience you might want to translate it (by yourself or by getting external contributions). This cookbook will provide you with information you need and give you the guidelines we use in Cozy apps. You are free to use your own but if everyone follows the same rules contributions will be eased.

## Making your app translatable
We didn't invent anything new here, we just made helper to ease the developer's life.
We'll use the final code of our tutorial to illustrate this cookbook. You can find it [here](https://github.com/mycozycloud/cozy-tutorial/tree/spa-final).

NB: you can find the code of this tutorial [here](https://github.com/mycozycloud/cozy-tutorial/tree/localization)

First you need to add Polyglot to your client's vendor. [Polyglot](http://airbnb.github.io/polyglot.js/) is a "tiny l18n helper library written in JavaScript". It supports interpolation and pluralization.

* download it and put it inside the client/vendors/scripts/ folder
* make sure brunch is running, it will automatically add the library to the vendor.js file

Next, create your "locales" files (one for each language) in your client. As an example, you can see how we did it for the ["Home" application](https://github.com/mycozycloud/cozy-home/tree/master/client/app/locales).
We'll have english and french for our bookmark tutorial app:
```javascript
// client/app/locales/en.js
module.exports = {
    "main title": "Welcome on My Own Bookmarks",
    "main description": "This application will help you manage your bookmarks!",
    "form title label": "Title",
    "form url label": "Url",
    "form submit button": "Add a new bookmark",
    "delete button": "delete"
}
```
```javascript
// client/app/locales/fr.js
module.exports = {
    "main title": "Bienvenue sur My Own Bookmarks",
    "main description": "Cette application vous permet de gérer vos marque-pages !",
    "form title label": "Titre",
    "form url label": "Url",
    "form submit button": "Ajouter un nouveau marque-page",
    "delete button": "supprimer"
}
```

Each localization file is a key-value list. The key should always be the same accross the file. We'll see how we use it later. We have rules to name the keys, you can find them at the [end of this page](#guidelines).

Then bootstrap Polyglot in your application:
```javascript
// client/app/initialize.js

$(document).ready(function() {
    var app = require('application');

    var locale = 'en'; // default locale

    // we'll need to tweak the server to allow this
    $.ajax('cozy-locale.json', {
        success: function(data) {
            locale = data.locale
            initializeLocale(locale);
        },
        error: function() {
            initializeLocale(locale);
        }
    });

    // let's define a function to initialize Polyglot
    var initializeLocale = function(locale) {
        var locales = {};
        try {
            locales = require('locales/' + locale);
        }
        catch(err) {
            locales = require('locales/en');
        }

        var polyglot = new Polyglot();
        // we give polyglot the data
        polyglot.extend(locales);

        // handy shortcut
        window.t = polyglot.t.bind(polyglot);
        app.initialize();
    };
});
```

Now we must make the "cozy-locale.json" resource available on the server. We have a helper for that:
```bash
npm install cozy-i18n-helper --save
```

Then add the following to the 'common' section of your configuration (if you are using americano or express):
```javascript
// server/config.js
require('cozy-i18n-helper').middleware
```
It automatically retrieves the locale data of the cozy's user and create the route that will allow the client to get it. Don't forget to add the "CozyInstance" doctype to your application's permissions or you will get errors.

Now you can change all the templates and view using the "t" function. Let's change `client/app/templates/home.hade` as an example:
```html
h1= t('main title')
p= t('main description')

form
    label= t('form title label')  + ':'
    input(type="text", name="title")
    label= t('form url label') + ':'
    input(type="text", name="url")
    input(id="add-bookmark", type="submit", value="#{t('form submit button')}")

ul
```

To learn all the great thing Polyglot can do (interpolation and pluralization), please [read its documentation](http://airbnb.github.io/polyglot.js/).

<a name="summary"></a>
If you want to test everything is working, go to http://localhost:9104/#account and change the language.

## Summary for translator contributors
If you are not a developer but still want to help the community by adding translations, here is what should know/do. Let's say you want to add the german language to an application.

* the only technical requirement is git. If you don't know it and still want to help, we'll find another way (contact[at]cozycloud.cc).
* get the application you want to translate on [Github](https://github.com/mycozycloud/)
* check the client/app/locales folder
    * if there is a "de.js" or "de.coffee" file, open it and make your changes
    * if there isn't, create it on the existing model and make your changes
* commit your work
* submit a pull request on github

<a name="guidelines"></a>
## Localization guidelines
This is how you should name the keys of your localization files:

* key names should not contain punctuation
* key names should be lowercased
* key names should contain spaces rather than hyphens
* key names should be no longer than 30 chars or 4 words
* key names should be (as much as possible) understandable by themselves.
* key names should be in english

Some examples :

* "Choose the language you want me to use to speak to you:" --> "choose language"
* "Changing the locale requires to reload the page." --> "reload to change locales"
* "Once updated, this application will require the following permissions:" --> "permissions after update"
