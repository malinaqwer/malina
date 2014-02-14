pusher = new Pusher("47d00e4672379dc8784b")
is_typing_currently = false;
channel = pusher.subscribe('admin')

channel.bind "enter", (data) ->
  enter data

channel.bind "message", (data) ->
  message data


enter = (data) ->
  $('#messages_admin').prepend 'вход на стр: ' + data.path + ' - <a class="btn btn-xs btn-default" href="?dialog=' + data.on + '">' + data.on + '</a>'

message = (data) ->
  $('#messages_admin').prepend '<a class="btn btn-xs btn-default" href="?dialog=' + data.id + '">' + data.text + '</a><br>'





$(document).ready ->

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