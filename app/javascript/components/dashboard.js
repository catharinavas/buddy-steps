const cardsGoals = () => {
  const myGoalsIcon = document.getElementById('my_goals_icon');
  const myGoals = document.getElementById('my_goals');

  const buddiesGoalsIcon = document.getElementById('buddies_goals_icon');
  const buddiesGoals = document.getElementById('buddies_goals');

  myGoalsIcon.addEventListener('click', () => {
    myGoals.classList.toggle('hidden');
    buddiesGoals.classList.toggle('hidden');
  })

  buddiesGoalsIcon.addEventListener('click', () => {
    myGoals.classList.toggle('hidden');
    buddiesGoals.classList.toggle('hidden');
  })
}

export { cardsGoals };
