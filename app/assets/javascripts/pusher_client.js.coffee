is_typing_currently = false;

Pusher.log = (message) ->
  window.console.log message  if window.console and window.console.log

pusher = new Pusher("47d00e4672379dc8784b")
console.log pusher


$(document).ready ->

  audio_start = () ->
    $('#audio_chat')[0].play()
    $('.jumbotron').hover ->
      $('#audio_chat')[0].currentTime = 0
      $('#audio_chat')[0].pause()
      

  add_message = (data) ->
    ht = $('<b>' + data.author + ': </b><i>' + data.text + '</i><br>')
    $('#messages_client').prepend ht
    audio_start()


  $(window).load ->
    _on = localStorage.getItem('on')
    $.get "/dialogs/enter",
      status: 'enter',
      on: _on,
      path: document.URL
    , (data) ->
      localStorage.setItem('on', data.on)
      $('#send_message').attr('c', data.on)
      channel = pusher.subscribe(data.on)

      channel.bind "message_send", (data) ->
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
    ht = $('<b>parya: </b><i>' + message + '</i><br>')
    $('#messages_client').prepend ht
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