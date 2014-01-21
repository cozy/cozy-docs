$(document).ready ->

    # scroll spy management
    $('body').scrollspy target: '#navigation'
    $('body').on 'activate.bs.scrollspy', -> $(this).addClass 'active'
    $(window).on 'load', -> $('body').scrollspy 'refresh'

