const addMilestone = () => {
  const add = document.getElementById('add-icon');
  if(add){
    const addMilestone = document.getElementById('add-milestone');

    add.addEventListener('click', () => {
      addMilestone.classList.toggle('hidden');
    })
  }
}
export { addMilestone };
