const menuToggle = () => {
  const menuIcon = document.getElementById('menu-icon');
  const menuList = document.getElementById('menu-list');

  menuIcon.addEventListener('click', () => {
    menuList.classList.toggle('hidden');
  })
}

const dropdownToggle = () => {
  const avatarIcon = document.getElementById('avatar-icon');
  const dropdownList = document.getElementById('dropdown-list');

  avatarIcon.addEventListener('click', () => {
    dropdownList.classList.toggle('hidden');
  })
}

export { menuToggle };
export { dropdownToggle };
