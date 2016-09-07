$(document).on('turbolinks:load', function() {
  submitNewMessage();
  scrDown();
});

$(document).on('turbolinks:load', function() {
  $('#send_message_chatroom').on("click", function(){
    $('[data-send="message"]').click();
    afterSend();
    return false;
  });
});

function submitNewMessage(){
  $('textarea#message_content').keydown(function(event) {
    if (event.keyCode == 13) {
        $('[data-send="message"]').click();
        afterSend();
        return false;
     }
  });
}

function afterSend() {
  $('[data-textarea="message"]').val(" ");
  $('[data-textarea="message"]').focus();
  $('#chatroom-card').scrollTop($('#chatroom-card')[0].scrollHeight);
}

function scrDown(){
  $("#chatroom-card").hover(function(){
    $(this).stop();
    try { clearInterval(scroller); } catch(e) {}
  },
  function(){
    scroller=setInterval(function(){
      $('#chatroom-card').scrollTop($('#chatroom-card')[0].scrollHeight);
    }, 1500);
  });
}
