var scroller = 0

$(document).on('turbolinks:load', function() {
  submitNewMessage();
  if(/^\/chatrooms\/.*$/.test(window.location.pathname)) {
    scrDown();
  } else {
    clearInterval(scroller);
  }
});

$(document).on('turbolinks:load', function() {
  $('#send_message_chatroom').on('click', function(event){
    if (beforeSend()) {
      $('[data-send="message"]').click();
      afterSend();
      return false;
    } else {
      userAlert();
      afterSend();
      event.preventDefault();
    }
  });
});

function submitNewMessage(){
  $('textarea#message_content').keydown(function(event) {
    if ((event.keyCode == 13) && beforeSend()) {
      $('[data-send="message"]').click();
      afterSend();
      return false;
    } else {
        if (event.keyCode == 13) {
          userAlert();
          event.preventDefault();
        }
      }
  });
}

function beforeSend() {
  return !!($('[data-textarea="message"]').val().trim().length);
}

function userAlert() {
  $('[data-textarea="message"]').css('background-color', 'red');
  setTimeout(function(){
    $('[data-textarea="message"]').css('background-color', 'white');
  }, 1200);
}

function afterSend() {
  $('[data-textarea="message"]').val(' ');
  $('[data-textarea="message"]').focus();
  $('#chatroom-card').scrollTop($('#chatroom-card')[0].scrollHeight);
}

function scrDown(){
  $('#chatroom-card').hover(function(){
    clearInterval(scroller);
  },
    function(){
      scroller=setInterval(function(){
      $('#chatroom-card').scrollTop($('#chatroom-card')[0].scrollHeight);
      }, 1500);
    });
}
