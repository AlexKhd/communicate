var scroller = 0

$(document).on('turbolinks:load', function() {
  createChatroomOnKeyDown();
  createChatroomOnClick();
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

function createChatroomOnKeyDown(){
  $('#chatroom_name').keydown(function(event) {
    if (event.keyCode == 13) {
      $('#create-chatroom').click();
      event.preventDefault();
      //return false;
    }
  });
}

function createChatroomOnClick() {
  $('#create-chatroom').on('click', function(event){
    if ($('#chatroom_name').val().length < 6) {
      $('input#chatroom_name').focus();
      $('#chatroom_name').css('background-color', 'red');
      setTimeout(function(){
        $('#chatroom_name').css('background-color', 'white');
      }, 1000);
      $('#new-chatroom p').html('Name of the room 6 symbols min!');
      $('#new-chatroom p').css('background-color', 'red');
      setTimeout(function(){
        $('#new-chatroom p').css('background-color', 'white');
      }, 2200);
      event.preventDefault();
    } else {
      $('#chatroom-index').css('background-color', 'green');
      setTimeout(function(){
        $('#chatroom-index').css('background-color', 'white');
      }, 2200);
    }
  });
}
