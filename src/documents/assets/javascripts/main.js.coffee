do($=jQuery) ->
    $navToggle    = $ '.nav-toggle'
    $architecture = $ '#architecture'
    $motiv        = $ '[name=MOTIV]'
    $counter      = $motiv.siblings('.notice').find '.counter'


    $navToggle.on 'click', (event) ->
        event.preventDefault()
        $nav = $navToggle.parents '[aria-expanded]'
        $nav.attr 'aria-expanded', !($nav.attr('aria-expanded') is 'true')

