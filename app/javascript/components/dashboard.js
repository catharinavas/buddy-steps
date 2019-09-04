// GOALS CARDS FLIP
const cardsGoals = () => {
  const myGoalsIcon = document.getElementById('my_goals_icon');
  const myGoals = document.getElementById('my_goals');

  if(myGoalsIcon) {
    const buddiesGoalsIcon = document.getElementById('buddies_goals_icon');
    const buddiesGoals = document.getElementById('buddies_goals');

    myGoalsIcon.addEventListener('click', () => {
      myGoals.classList.toggle('hidden');
      buddiesGoals.classList.toggle('hidden');
      myGoalsIcon.classList.toggle('active');
      buddiesGoalsIcon.classList.toggle('active');
    })

    buddiesGoalsIcon.addEventListener('click', () => {
      myGoals.classList.toggle('hidden');
      buddiesGoals.classList.toggle('hidden');
      myGoalsIcon.classList.toggle('active');
      buddiesGoalsIcon.classList.toggle('active');
    })
  }
}

export { cardsGoals };

// NEW GOAL MODAL
