$(document).ready ->

  pusher = new Pusher("a471015e307928cc3acb")
  is_typing_currently = false;
  channel = pusher.subscribe('admin')

  channel.bind "enter", (data) ->
    enter data

  channel.bind "message_send", (data) ->
    message_send data

  enter = (data) ->
    a = '<a class="list-group-item list-group-item-danger" href="?dialog=' + data.on + '">
          <h5 class="list-group-item-heading">' + data.path + '</h5></a>'
    $('.list-group').prepend $(a)

  message_send = (data) ->
    a = '<a class="list-group-item list-group-item-danger" href="?dialog=' + data.id + '">
          <h5 class="list-group-item-heading">' + data.text + '</h5></a>'
    $('.list-group').prepend $(a)

  audio_start = (data) ->
    $('#audio_chat')[0].play()
    $('.messages').hover ->
      $('#audio_chat')[0].currentTime = 0
      $('#audio_chat')[0].pause()

  doneCap = ->
    id = $(@).attr 'dialog'
    $.get "/dialogs/done",
      id: id,
    , (data) ->
      alert data

  copyText = ->
    what = $(@).attr 'message'
    $('textarea#message').val what



  if $('#dialog_id').text() is ''
    $('#control_chat').remove()

  sendMessage = ->
    if $("#message").val() is ""
      alert "Please enter a message..."
      $("#message").focus()
      return false
    $("#message").css color: "#000000"
    message = $("#message").val()
    ht = $('<b>admin: </b><i>' + message + '</i><br>')
    $('#messages_admin').prepend ht
    $("#loading").fadeIn()
    $("#message-overlay").fadeIn 200
    $("#message").blur()
    $.post "/messages",
      d: $('#dialog_id').text(),
      a: 'admin',
      m: message
    , (response) ->
      $("#message").val ""
      $("#message-overlay").fadeOut 150
      $("#message").focus()
      $("#loading").fadeOut()
      is_typing_currently = false


  $(document).on "click", "#send_message", sendMessage
  $(document).on "click", "#done", doneCap
  $(document).on "click", ".list-group-item", copyText
