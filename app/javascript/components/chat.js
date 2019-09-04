const chat = () => {
  const add = document.getElementById('chat-icon');
  if(add) {
    const addChat = document.getElementById('chat-render');

    add.addEventListener('click', () => {
      addChat.classList.toggle('hidden');
    })
  }
}
export { chat };
