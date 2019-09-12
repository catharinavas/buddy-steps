const modalEditMilestone = () => {
  var openmodal = document.querySelectorAll('.modal-edit-milestone-open')
  openmodal.forEach( function(openModalButton) {
    openModalButton.addEventListener('click', function(event){
      event.preventDefault()

      const dataMilestoneId = openModalButton.getAttribute('data-milestone')
      toggleModal(dataMilestoneId)
    })
  })

  const overlay = document.querySelector('.modal-edit-milestone-overlay');
  if(overlay){
    overlay.addEventListener('click', toggleModal)
  }
  var closemodal = document.querySelectorAll('.modal-edit-milestone-close')
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
    if (isEscape && document.body.classList.contains('modal-active')) {
    toggleModal()
    }
  };


  function toggleModal (dataMilestoneId) {
    const body = document.querySelector('body')
    let modal
    if (dataMilestoneId) {
      modal = document.getElementById(dataMilestoneId);
    } else {
     modal = document.querySelector('.modal-edit-milestone');
    };
    modal.classList.toggle('opacity-0')
    modal.classList.toggle('pointer-events-none')
    body.classList.toggle('modal-active')
  }
}

export {modalEditMilestone};
