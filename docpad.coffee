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

    events:
        contextualizeAfter: (options) ->
            {collection} = options
            # rewrite the layout meta data to prepend the locale information
            collection.each (model) ->
                layout = model.get 'layout'

                # assets files have don't have "layout" info
                if layout?
                    [lang, ...] = model.get('relativePath').split '/'
                    newLayout = "#{lang}/#{layout}"
                    model.set 'layout', newLayout


        render: (options) ->
            {content, file} = options

            layout = file.get 'layout'
            if layout?
                [lang, ...] = file.get('relativePath').split '/'
                # rewrite URLs to prepend language
                regex = /[("]{1}\/(hack|host|mobile)/g
                content = content.replace regex, "/#{lang}/$1"
                options.content = content

    enabledPlugins:
        "live-reload": true
}

# Export the DocPad Configuration
module.exports = docpadConfig
