is_typing_currently = false;

pusher = new Pusher("a471015e307928cc3acb")


$(document).ready ->

  parseUrl = (url) ->
    a = document.createElement("a")
    a.href = url
    a

  audio_start = () ->
    $('#audio_chat')[0].play()
    $('.messages').hover ->
      $('#audio_chat')[0].currentTime = 0
      $('#audio_chat')[0].pause()
      

  add_message = (data) ->
    ht = $('<b>' + data.author + ': </b><i>' + data.text + '</i><br>')
    $('#messages_client').prepend ht
    alert data.text
    # audio_start()

  done = (data) ->
    localStorage.setItem('done', 'ok')

  review = () ->
    name = localStorage.getItem('na')
    text = localStorage.getItem('te')
    unless text is null
      r = '<div id="review" class="panel panel-danger"><div class="panel-heading">' + name + '<a id="deleteReview" class="btn btn-xs btn-danger pull-right">удалить</a></div>
            <div class="panel-body"><p>' + text + '</p></div></div>'
      $('#formReview').after $(r)

  $(window).load ->
    review()
    _on = localStorage.getItem('on')
    url = parseUrl document.URL
    if _on is null
      localStorage.setItem('on_start', url.pathname)
      console.log localStorage.getItem('on_start')
    else
      console.log localStorage.getItem('on_start')
    $.get "/dialogs/enter",
      status: 'enter',
      on: _on,
      path: document.URL,
      url: url.pathname
    , (data) ->
      localStorage.setItem('on', data.on)
      $('#send_message').attr('c', data.on)
      channel = pusher.subscribe(data.on)

      channel.bind "message_send", (data) ->
        add_message data

      channel.bind "done", (data) ->
        done data


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

  sendEbana = ->
    name = $('#inputName').val()
    text = $('#inputText').val()
    r = '<div id="review" class="panel panel-danger"><div class="panel-heading">' + name + '<a id="deleteReview" class="btn btn-xs btn-danger pull-right">удалить</a></div>
           <div class="panel-body"><p>' + text + '</p></div></div>'
    localStorage.setItem('na', name)
    localStorage.setItem('te', text)
    $('#formReview').html $(r)
    false

  deleteReview = ->
    $('#review').html $('<h3>Отзыв удален</h3>')
    localStorage.removeItem('na')
    localStorage.removeItem('te')


  $(document).on "click", "#send_message", sendMessage
  $(document).on "click", "#sendEbana", sendEbana
  $(document).on "click", "#deleteReview", deleteReview