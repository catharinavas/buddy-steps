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
import ApexCharts from 'apexcharts';
import { fetchGraphData } from "../components/chart.js"


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
fetchGraphData();



// var options = {
//   chart: {
//     type: 'line'
//   },
//   series: [{
//     name: 'sales',
//     data: [30,40,45,50,49,60,70,91,125]
//   }],
//   xaxis: {
//     categories: [1991,1992,1993,1994,1995,1996,1997, 1998,2001]
//   }
// }

// var chart = new ApexCharts(document.querySelector("#chart"), options);

// chart.render();
