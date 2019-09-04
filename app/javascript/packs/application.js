import '../css/application.css';
import "../plugins/flatpickr";
import { menuToggle, dropdownToggle, closeMenu } from '../components/navbar';

import { showPublications } from '../components/show-publications';

import { addMilestone } from '../components/add_milestone';

import { chat } from '../components/chat';
import { modal } from '../components/modal';

menuToggle();
dropdownToggle();
closeMenu();

showPublications();

addMilestone();
chat();
modal();
