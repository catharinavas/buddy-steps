import '../css/application.css';
import "../plugins/flatpickr";
import { menuToggle, dropdownToggle, closeMenu } from '../components/navbar.js';
import { addMilestone } from '../components/add_milestone.js';
import { chat } from '../components/chat.js';
import { modal } from '../components/modal';

import { readToggle } from '../components/read_toggle.js';
//publications index;
readToggle();

menuToggle();
dropdownToggle();
closeMenu();
// addMilestone();
// chat();
// modal();

