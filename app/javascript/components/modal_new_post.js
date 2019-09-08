const modalNewPost = () => {
  var openmodal = document.querySelectorAll('.modal-open-new-post')
  for (var i = 0; i < openmodal.length; i++) {
    console.log(i)
    openmodal[i].addEventListener('click', function(event){
    event.preventDefault()
    toggleModal()
    })
  }

  const overlay = document.querySelector('.modal-new-post-overlay');
  if(overlay){
    overlay.addEventListener('click', toggleModal)
  }
  var closemodal = document.querySelectorAll('.modal-new-post-close')
  for (var i = 0; i < closemodal.length; i++) {
    closemodal[i].addEventListener('click', toggleModal)
  }

  document.onkeydown = function(evt) {
    evt = evt || window.event
    var isEscape = false
    if ("key" in evt) {
    isEscape = (evt.key === "Escape" || evt.key === "Esc")
    } else {
    isEscape = (evt.keyCode === 27)
    }
    if (isEscape && document.body.classList.contains('modal-new-post-active')) {
    toggleModal()
    }
  };


  function toggleModal () {
    console.log("toggle")
    const body = document.querySelector('body')
    const modal = document.querySelector('.modal-new-post')
    modal.classList.toggle('opacity-0')
    modal.classList.toggle('pointer-events-none')
    body.classList.toggle('modal-new-post-active')
  }
}

export {modalNewPost};
