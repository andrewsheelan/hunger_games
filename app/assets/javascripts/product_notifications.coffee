class ProductNotification
  constructor: (attr) ->
    # Enable pusher logging - don't include this in production
    Pusher.log = (message) ->
      window.console.log message if window.console && window.console.log

    pusher  = new Pusher 'b6bccaecc617484d8548'
    channel = pusher.subscribe 'product_notifications_channel'

    channel.bind 'product_notifications_event', (data) ->
      $("#product-notification-#{data.id}").remove()
      $('#btn-input').val ''

      product_body = $('.product-notification-body')
      product_body.append "<div id='product-notification-#{data.id}' style='color: #{data.color}'><div class=header><strong class='primary-font'>#{data.user}</strong><small class='pull-right text-muted'><span class='glyphicon glyphicon-time'></span>#{data.created_at}</small></div><p id='p-#{data.id}'>#{data.message}</p></div>"
      $("#p-#{data.id}").emoticonize { delay: 800, animate: true }

      product_body.scrollTop product_body.prop('scrollHeight')

$(document).on "ready page:load", ->
  new ProductNotification() if $('#product-notification').length
