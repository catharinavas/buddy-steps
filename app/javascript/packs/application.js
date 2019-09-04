import '../css/application.css';
import "../plugins/flatpickr";
import { menuToggle, dropdownToggle, closeMenu } from '../components/navbar.js';
// import { showPublications } from '../components/show-publications.js';
import { addMilestone } from '../components/add_milestone.js';
import { chat } from '../components/chat.js';
import { modal } from '../components/modal';

menuToggle();
dropdownToggle();
closeMenu();
// showPublications();
addMilestone();
chat();
modal();
