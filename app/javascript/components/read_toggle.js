const readToggle = () => {
  const readBtns = document.querySelectorAll('.read-toggle');

  if(readBtns) {
    readBtns.forEach((readBtn) => {
      readBtn.addEventListener('click', (event) => {
        event.preventDefault();

        let btn = event.target;
        insertHTML(btn);
      });
    });
  }
}

const insertHTML = (btn) => {
  const id = btn.dataset.readToggle;
  const hiddenText = document.querySelector(`[data-hidden-text='${id}']`);
  const shownText = document.querySelector(`[data-shown-text='${id}']`);
  const readMore = document.querySelector(`[data-read-more='${id}']`);
  const readLess = document.querySelector(`[data-read-less='${id}']`);

  // btn.classList.toggle('hidden');
  hiddenText.classList.toggle('hidden');
  shownText.classList.toggle('hidden');
  readMore.classList.toggle('hidden');
  readLess.classList.toggle('hidden');
}


export { readToggle };
