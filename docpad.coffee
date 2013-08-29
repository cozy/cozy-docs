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
            @getCollection('html').findAllLive({category: 'host', isCategoryMaster:$exists:false})
        hackPages: ->
            @getCollection('html').findAllLive({category: 'hack', isCategoryMaster:$exists:false})
}

# Export the DocPad Configuration
module.exports = docpadConfig