function insertMessage(message) {
  var messagesContainer = document.querySelector('.room-messages');
  if (messagesContainer) {
    messagesContainer.insertAdjacentHTML('beforeend', message);
    var input = document.querySelector('#room-message_content');
    input.value = '';
    input.blur();
  }
}

<% if @message.errors.any? %>
  // handle validation errors later
<% else %>
  insertMessage('<%= j render "room-messages", message: @message, user_is_messages_author: true %>');
<% end %>
