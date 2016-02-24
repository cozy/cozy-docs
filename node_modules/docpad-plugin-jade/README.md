# [Jade](http://jade-lang.com/) Plugin for [DocPad](http://docpad.org)

<!-- BADGES/ -->

[![Build Status](https://img.shields.io/travis/docpad/docpad-plugin-jade/master.svg)](http://travis-ci.org/docpad/docpad-plugin-jade "Check this project's build status on TravisCI")
[![NPM version](https://img.shields.io/npm/v/docpad-plugin-jade.svg)](https://npmjs.org/package/docpad-plugin-jade "View this project on NPM")
[![NPM downloads](https://img.shields.io/npm/dm/docpad-plugin-jade.svg)](https://npmjs.org/package/docpad-plugin-jade "View this project on NPM")
[![Dependency Status](https://img.shields.io/david/docpad/docpad-plugin-jade.svg)](https://david-dm.org/docpad/docpad-plugin-jade)
[![Dev Dependency Status](https://img.shields.io/david/dev/docpad/docpad-plugin-jade.svg)](https://david-dm.org/docpad/docpad-plugin-jade#info=devDependencies)<br/>
[![Gratipay donate button](https://img.shields.io/gratipay/docpad.svg)](https://www.gratipay.com/docpad/ "Donate weekly to this project using Gratipay")
[![Flattr donate button](https://img.shields.io/badge/flattr-donate-yellow.svg)](http://flattr.com/thing/344188/balupton-on-Flattr "Donate monthly to this project using Flattr")
[![PayPayl donate button](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QB8GQPZAH84N6 "Donate once-off to this project using Paypal")
[![BitCoin donate button](https://img.shields.io/badge/bitcoin-donate-yellow.svg)](https://coinbase.com/checkouts/9ef59f5479eec1d97d63382c9ebcb93a "Donate once-off to this project using BitCoin")
[![Wishlist browse button](https://img.shields.io/badge/wishlist-donate-yellow.svg)](http://amzn.com/w/2F8TXKSNAFG4V "Buy an item on our wishlist for us")

<!-- /BADGES -->


Adds support for the [Jade](http://jade-lang.com/) templating engine to [DocPad](https://docpad.org)

Convention:  `.anything.jade`


## Install

```
docpad install jade
```


## Awareness

Before you get started with Jade, it is important to be aware of one thing. The majority of support questions that come through with DocPad, aren't actually DocPad issues, but Jade issues. People confusing the syntax, Jade doing it's own templating magic, things like that.

The DocPad team recommends you try one of the many other [amazing templating engines](http://docpad.org/docs/plugins#renderers) that are available, over trying to use Jade.

If you still insist on using Jade, please be aware, Jade will be a slippery slope, but luckily there are determined Jade users here to help :)


## Usage

### Template Helpers as Filters

Use just like any jade template. However, we do add any docpad template helpers you may have as jade filters. There are two ways you can use these filters:

``` jade
-# first way, calls the template helper like: myTemplateHelper("content", {opt1="blah",opt2="blah",opt3=true})
:myTemplateHelper(opt1=blah,opt2=blah,opt3)
    content

-# second way, calls the template helper like: myTemplateHelper(arg1, arg2)
:myTemplateHelper(args)
    arg1
    arg2
```

NOTE: Not all template helpers support being called this way. If it doesn't work, we'd recommend using the text plugin to render eco which includes your template helper call. See following section.


### Rendering with the Text Plugin
You can use the [text plugin](http://docpad.org/plugin/text) to render different parts of your template with different markups that are support by your docpad setup. Once installed, you can do things like:

``` jade
:t(render="markdown")
    here is some *markdown*

:t(render="html.md.eco")
    here is some <%-'eco'.toUpperCase()%> to *markdown* to html

:t(render="html.eco")
    my url is <%-@document.url%>
```


<!-- HISTORY/ -->

## History
[Discover the change history by heading on over to the `HISTORY.md` file.](https://github.com/docpad/docpad-plugin-jade/blob/master/HISTORY.md#files)

<!-- /HISTORY -->


<!-- CONTRIBUTE/ -->

## Contribute

[Discover how you can contribute by heading on over to the `CONTRIBUTING.md` file.](https://github.com/docpad/docpad-plugin-jade/blob/master/CONTRIBUTING.md#files)

<!-- /CONTRIBUTE -->


<!-- BACKERS/ -->

## Backers

### Maintainers

These amazing people are maintaining this project:

- Benjamin Lupton <b@lupton.cc> (https://github.com/balupton)

### Sponsors

No sponsors yet! Will you be the first?

[![Gratipay donate button](https://img.shields.io/gratipay/docpad.svg)](https://www.gratipay.com/docpad/ "Donate weekly to this project using Gratipay")
[![Flattr donate button](https://img.shields.io/badge/flattr-donate-yellow.svg)](http://flattr.com/thing/344188/balupton-on-Flattr "Donate monthly to this project using Flattr")
[![PayPayl donate button](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QB8GQPZAH84N6 "Donate once-off to this project using Paypal")
[![BitCoin donate button](https://img.shields.io/badge/bitcoin-donate-yellow.svg)](https://coinbase.com/checkouts/9ef59f5479eec1d97d63382c9ebcb93a "Donate once-off to this project using BitCoin")
[![Wishlist browse button](https://img.shields.io/badge/wishlist-donate-yellow.svg)](http://amzn.com/w/2F8TXKSNAFG4V "Buy an item on our wishlist for us")

### Contributors

These amazing people have contributed code to this project:

- [Benjamin Lupton](https://github.com/balupton) <b@lupton.cc> — [view contributions](https://github.com/docpad/docpad-plugin-jade/commits?author=balupton)
- [Evan Bovie](https://github.com/phaseOne) <evan@bovie.me> — [view contributions](https://github.com/docpad/docpad-plugin-jade/commits?author=phaseOne)
- [kizu](https://github.com/kizu) — [view contributions](https://github.com/docpad/docpad-plugin-jade/commits?author=kizu)
- [toabi](https://github.com/toabi) — [view contributions](https://github.com/docpad/docpad-plugin-jade/commits?author=toabi)
- [Vladislav Botvin](https://github.com/darrrk) <darkvlados@me.com> — [view contributions](https://github.com/docpad/docpad-plugin-jade/commits?author=darrrk)

[Become a contributor!](https://github.com/docpad/docpad-plugin-jade/blob/master/CONTRIBUTING.md#files)

<!-- /BACKERS -->


<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

Copyright &copy; 2012+ Bevry Pty Ltd <us@bevry.me> (http://bevry.me)
<br/>Copyright &copy; 2011 Benjamin Lupton <b@lupton.cc> (http://balupton.com)

<!-- /LICENSE -->


