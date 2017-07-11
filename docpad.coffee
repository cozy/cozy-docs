# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {

    outPath: 'docs'

    templateData:
        site:
            url: "https://cozy.io/"
            title: ""
            description: ""
            keywords: ""

        getLang: (document) ->
            [lang, ...] = document.relativePath.split '/'
            return lang

    collections:
        hostPagesFR: ->
            @getCollection('html').findAllLive category: 'host', url:$startsWith: '/fr'
        hostPagesEN: ->
            @getCollection('html').findAllLive category: 'host', url:$startsWith: '/en'

        mobilePagesFR: ->
            @getCollection('html').findAllLive category: 'mobile', url:$startsWith: '/fr'
        mobilePagesEN: ->
            @getCollection('html').findAllLive category: 'mobile', url:$startsWith: '/en'

        hackPagesFR: ->
            @getCollection('html').findAllLive category: 'hack', url:$startsWith: '/fr'
        hackPagesEN: ->
            @getCollection('html').findAllLive category: 'hack', url:$startsWith: '/en'

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
                regex = /["]{1}\/(hack|host|mobile)/g
                content = content.replace regex, "\"/#{lang}/$1"
                options.content = content
}

# Export the DocPad Configuration
module.exports = docpadConfig
