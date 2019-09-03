const showPublications = () => {
  const menuNews = document.getElementById('menu-news');
  const menuNewsList = document.getElementById('menu-news-list');

  menuNews.addEventListener('click', () => {
    menuNewsList.classList.toggle('hidden');
  })
}

export { showPublications };
  // const menuCelebrations = document.getElementById('menu-celebrations');
  // const menuUser = document.getElementById('menu-user');
