---
title: "Deploy your application"
layout: "default"
category: "hack"
menuOrder: 4
toc: true
---

# Deploy your application
Once your awesome application is ready to be used, you migh wonder how use it in your Cozy. This cookbook will describe packaging and distributing your application while avoiding common pitfalls.
Open your package.json file, you'll need it!


*Note: if you want to see a working example, please check [Calendar's package.json](https://github.com/cozy/cozy-calendar/blob/master/package.json).*

## Declaring the permissions
In a production Cozy, the application will need permissions in order to access the Data System for every doctype it uses.

In order to declare what permissions are required by your application, you must add the list to your package.json at the root level. Let's say our application needs the permissions for the doctype "Todo", "Event" and "Alarm".

```json
{
    "cozy-permissions": {
        "Todo": {
            "description": "Display the next things to do"
        },
        "Event": {
            "description": "Manage your meetings"
        },
        "Alarm": {
            "description": "Warn you when a meeting is happening soon"
        }
    }
}
```

The "description" fields will be displayed to the user during installation. Do not miss the occasion to build trust between the user and your application!

## Naming your application
There are two fields regarding naming your application: "name", "cozy-displayName" and "description".

Your application is identified by a slug withing Cozy, that slug is the "name field". You cannot put fancy characters in it, only use letters and "-" or "\_", **no space**!

The "cozy-displayName" field allows you to choose a fancy name, you can use all the character you want, but be careful! It will appear on the user's home, so it shouldn't be too long.

The "description" field allows you to display to the user a description in the installation process.

```json
{
    "name": "cozy-mysuperapp-slug",
    "cozy-displayName": "My Super Application"
    "description": "My Super Application makes you awesome!"
}
```

## Adding an icon

There are two ways to set an icon for your application:

 - by convention: put a `main_icon.png` or `main_icon.svg` into `client/app/assets/icons/` folder, and Cozy will automatically use it;
 - explicitly: add an `icon-path` field to `package.json`:
```json
{
    "name": "cozy-mysuperapp-slug",
    "icon-path": "mysuperapp.png"
}
```


## Distributing to other users
The first thing to do is creating a Github account if you don't have one already. We are currently tightly integrated with Github but that's something we'll change when the time comes. So make a Github account and push your code to a **public** remote repository.
<br /><br />
Next comes the Cozy app market. Currently there isn't a fancy centralized marketplace where people write reviews and stars their favorite applications. We want to do that and we will do it at a certain point.

For now, we do it manually. So send us an email (at contacts[at]cozycloud.cc) with the link of the previously created Github repository, saying "Hello I have built an awesome application, please add review it and add it to the market" and we will be more than happy to do it!


## Troubleshootings
When you install an application on Cozy, errors can occur. First thing to do is to try again 5 minutes later. If it still doesn't work, check the following sections and ask us for help on the IRC channel (#cozycloud on irc.freenode.net).

### Error: "NPM failed"
This error means something went wrong during the "npm install" phase. Two things: the NPM repository is down and we can't do anything except waiting (we don't own it!) or your application doesn't its depdency properly declared. Make sure you can do a local "npm install" before deploying!

```bash
cd my-app/
rm -rf node_modules/
npm install
```

### Error: "Broken app"
This happens when the app failed to start after its installation. There are many possible cases, here are the most commons:

#### The permissions aren't properly declared
Double-check that your application asks for all the permissions it needs. See part 1 of this cookbook for more information.

#### Your application crashes due to a bug
Make sure your application starts locally with and *without* data (a use case that is often forgotten!).
Also make sure all the NPM dependencies are properly declared in the package.json (i.e. you've installed a module without adding it to your dependency).


#### The Cozy on which your are installing the application is messed up
If you can, restart the Cozy manually, sometimes zombie processes clutter everything.
