

const showPublications = () => {


  const menuNews = document.getElementById('menu-news');
  if (menuNews) {
    const menuNewsList = document.getElementById('menu-news-list');

    // const menuCelebrations = document.getElementById('menu-celebrations');
    // const menuCelebrationsList = document.getElementById('menu-celebrations-list');

    const menuUsers = document.getElementById('menu-users');
    const menuUsersList = document.getElementById('menu-user-list');

    menuNews.addEventListener('click', () => {
      menuNewsList.classList.remove('hidden');
      // menuCelebrationsList.classList.add('hidden');
      menuUsersList.classList.add('hidden');
    })

    // menuCelebrations.addEventListener('click', () => {
    //   menuNewsList.classList.add('hidden');
    //   menuCelebrationsList.classList.remove('hidden');
    //   menuUsersList.classList.add('hidden');
    // })

    menuUsers.addEventListener('click', () => {
      menuNewsList.classList.add('hidden');
      // menuCelebrationsList.classList.add('hidden');
      menuUsersList.classList.remove('hidden');
    })
  }
}



export { showPublications };
