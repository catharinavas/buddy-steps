import "../plugins/flatpickr";
import { menuToggle, dropdownToggle, closeMenu } from '../components/navbar';
import { showPublications } from '../components/show-publications';
import { addMilestone } from '../components/add_milestone';
import { chat } from '../components/chat';
import { modalEditMilestone } from '../components/modals/modal_edit_milestone';
import { modalEditGoal } from '../components/modals/modal_edit_goal';
import { modalNewGoal } from '../components/modals/modal_new_goal';
import { modalNewPost } from '../components/modals/modal_new_post';
import { readToggle } from '../components/read_toggle.js';
import { cardsGoals } from '../components/dashboard';
import { scrollLastMessageIntoView } from '../components/scroll';


menuToggle();
dropdownToggle();
closeMenu();
showPublications();
addMilestone();
chat();
modalEditMilestone();
modalEditGoal();
modalNewGoal();
modalNewPost();
readToggle();
cardsGoals();
scrollLastMessageIntoView();
