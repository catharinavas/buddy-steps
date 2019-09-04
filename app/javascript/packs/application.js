import '../css/application.css';
import "../plugins/flatpickr";
import { menuToggle, dropdownToggle, closeMenu } from '../components/navbar.js';
import { showPublications } from '../components/show-publications.js';
import {modal} from '../components/modal';

menuToggle();
dropdownToggle();
closeMenu();
showPublications();
modal()
