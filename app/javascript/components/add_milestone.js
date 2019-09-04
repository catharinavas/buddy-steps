const addMilestone = () => {
  const add = document.getElementById('add-icon');
  console.log(add)
  if(add){
    const addMilestone = document.getElementById('add-milestone');

    add.addEventListener('click', () => {
      addMilestone.classList.toggle('hidden');
    })
  }
}
export { addMilestone };
