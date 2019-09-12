const toggleChat = () => {
  const userFlash = document.getElementById('user-flash');
  if (userFlash) {
    userFlash.addEventListener('click', (event) => {
      event.preventDefault();
      const userList = document.getElementById('user-list');
      console.log(userList)
      userList.style.display = userList.style.display === 'none' ? '' : 'none';
    });
  }
}

export { toggleChat }
