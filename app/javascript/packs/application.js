import './application.css';
import "../plugins/flatpickr";
import { menuToggle, closeMenu } from '../components/navbar';
import { showPublications, tabSelected } from '../components/show-publications';
import { addMilestone } from '../components/add_milestone';
import { chat } from '../components/chat';
import { modalEditMilestone } from '../components/modals/modal_edit_milestone';
import { modalEditGoal } from '../components/modals/modal_edit_goal';
import { modalNewGoal } from '../components/modals/modal_new_goal';
import { modalNewPost } from '../components/modals/modal_new_post';
import { readToggle } from '../components/read_toggle.js';
import { cardsGoals } from '../components/dashboard';
import { scrollLastMessageIntoView } from '../components/scroll';
import { ApexCharts } from 'apexcharts';
import { placeholderGraph } from "../components/placeholder_graph.js";
import { fetchGraphData } from "../components/graph.js";
import { changeGraph } from "../components/change_graph";
import { changeGraphMobile } from "../components/change_graph_mobile";
import { previewImageOnFileSelect } from "../components/photo_preview";
import { showGoalInfobox } from "../components/show_goal_infobox"
import { toggleChat } from "../components/toggle_chat"


menuToggle();
// dropdownToggle();
closeMenu();
showPublications();
tabSelected();
addMilestone();
chat();
modalEditMilestone();
modalEditGoal();
modalNewGoal();
modalNewPost();
readToggle();
cardsGoals();
scrollLastMessageIntoView();
placeholderGraph();
fetchGraphData();
changeGraph();
changeGraphMobile();
previewImageOnFileSelect();
showGoalInfobox();
toggleChat();
