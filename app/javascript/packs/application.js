import "../plugins/flatpickr";
import { menuToggle, dropdownToggle, closeMenu } from '../components/navbar';
import { showPublications } from '../components/show-publications';
import { addMilestone } from '../components/add_milestone';
import { chat } from '../components/chat';
import { modal } from '../components/modal';
import { modalGoal } from '../components/modal_goal';
import { readToggle } from '../components/read_toggle.js';
import { cardsGoals } from '../components/dashboard';
import { scrollLastMessageIntoView } from '../components/scroll';


menuToggle();
dropdownToggle();
closeMenu();
showPublications();
addMilestone();
chat();
modal();
readToggle();
cardsGoals();
scrollLastMessageIntoView();
