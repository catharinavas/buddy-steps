const showGoalInfobox = () => {
  const unclickableGoals = document.querySelectorAll('.unclickable-goal');
  if (unclickableGoals) {
    unclickableGoals.forEach((unclickableGoal) => {
      unclickableGoal.addEventListener('click', (event) => {
        const id = unclickableGoal.dataset.goal;
        const chosenInfobox = document.querySelector(`#goal-${id}`);
        const infoboxes = document.querySelectorAll('.goal-infobox');

        infoboxes.forEach((infobox) => {
          infobox.classList.add('hidden');
        });
        chosenInfobox.classList.remove('hidden');

        const scrollHeight = chosenInfobox.offsetHeight;
        chosenInfobox.scrollIntoView({block: "end", behavior: "smooth"});
      });
    });
  }
}

export { showGoalInfobox };
