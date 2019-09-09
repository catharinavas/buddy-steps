const modalNewGoal = () => {
  var openmodal = document.querySelectorAll('.modal-open-new-goal')
  for (var i = 0; i < openmodal.length; i++) {
    openmodal[i].addEventListener('click', function(event){
    event.preventDefault()
    toggleModal()
    })
  }

  const overlay = document.querySelector('.modal-new-goal-overlay');
  if(overlay){
    overlay.addEventListener('click', toggleModal)
  }
  var closemodal = document.querySelectorAll('.modal-new-goal-close')
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
    if (isEscape && document.body.classList.contains('modal-new-goal-active')) {
    toggleModal()
    }
  };


  function toggleModal () {
    const body = document.querySelector('body')
    const modal = document.querySelector('.modal-new-goal')
    modal.classList.toggle('opacity-0')
    modal.classList.toggle('pointer-events-none')
    body.classList.toggle('modal-new-goal-active')
  }
}

export {modalNewGoal};
