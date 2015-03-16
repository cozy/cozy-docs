do($=jQuery) ->
    $navToggle    = $ '.nav-toggle'
    $architecture = $ '#architecture'
    $motiv        = $ '[name=MOTIV]'
    $counter      = $motiv.siblings('.notice').find '.counter'


    $navToggle.on 'click', (event) ->
        event.preventDefault()
        $nav = $navToggle.parents '[aria-expanded]'
        $nav.attr 'aria-expanded', !($nav.attr('aria-expanded') is 'true')


    $architecture.on 'click', '.diagbox', ->
        if $(window).width() > 640
            $(this).find('p').slideToggle()


    $motiv.on 'keydown', ->
        len = 255 - this.value.length
        $counter
            .text len
            .toggleClass 'alert', len < 15

