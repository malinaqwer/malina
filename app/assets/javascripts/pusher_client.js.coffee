is_typing_currently = false;

Pusher.log = (message) ->
  window.console.log message  if window.console and window.console.log

pusher = new Pusher("47d00e4672379dc8784b")
console.log pusher


$(document).ready ->

  add_message = (data) ->
    console.log data
    ht = $('<b>' + data.author + ': </b><i>' + data.text + '</i><br>')
    $('#messages_client').prepend ht


  $(window).load ->
    _on = localStorage.getItem('on')
    $.get "/dialogs/enter",
      status: 'enter',
      on: _on,
      path: document.URL
    , (data) ->
      console.log data
      localStorage.setItem('on', data.on)
      $('#send_message').attr('c', data.on)
      channel = pusher.subscribe(data.on)
      console.log data.on
      console.log channel

      channel.bind "message", (data) ->
        add_message data


      $.each data.messages, (i, v) ->
        ht = $('<b>' + v.author + ': </b><i>' + v.text + '</i><br>')
        $('#messages_client').append ht



  sendMessage = ->
    if $("#message").val() is ""
      alert "Пустое сообщение !"
      $("#message").focus()
      return false
    $("#message").css color: "#000000"
    message = $("#message").val()
    $("#loading").fadeIn()
    $("#message-overlay").fadeIn 200
    $("#message").blur()
    add_message {text: message, author: 'parya'}
    $.post "/messages",
      d: $(@).attr('c'),
      m: message,
      a: 'parya'
    , (response) ->
      $("#message").val ""
      $("#message-overlay").fadeOut 150
      $("#message").focus()
      $("#loading").fadeOut()
      is_typing_currently = false

  $(document).on "click", "#send_message", sendMessage