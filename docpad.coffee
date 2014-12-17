# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {

    outPath: 'public'

    templateData:
        site:
            url: "http://cozy.io/"
            title: ""
            description: ""
            keywords: ""

    collections:
        hostPages: ->
            @getCollection('html').findAllLive category: 'host'
        mobilePages: ->
            @getCollection('html').findAllLive category: 'mobile'
        hackPages: ->
            @getCollection('html').findAllLive category: 'hack'
        homePages: ->
            @getCollection('html').findAllLive isCategoryMaster:$exists:true

    enabledPlugins:
        "live-reload": true
}

# Export the DocPad Configuration
module.exports = docpadConfig
