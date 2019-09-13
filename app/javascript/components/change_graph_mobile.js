import ApexCharts from 'apexcharts';

const changeGraphMobile = () => {
  var days_in_the_past = 0;
  var mobileSevenDayBtn = document.querySelector('#mobile-seven-day-view');
  var mobileFifteenDayBtn = document.querySelector('#mobile-fifteen-day-view');
  var mobileThirtyDayBtn = document.querySelector('#mobile-thirty-day-view');

  if (mobileSevenDayBtn) {

    // SETTING LISTENERS AND CLASSES FOR FILTERS
    mobileSevenDayBtn.addEventListener('click', (event) => {
      event.target.classList.add('opacity-50', 'cursor-not-allowed');
      mobileFifteenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      mobileThirtyDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      updateDataMobile(days_in_the_past);
    });

    mobileFifteenDayBtn.addEventListener('click', (event) => {
      event.target.classList.add('opacity-50', 'cursor-not-allowed');
      mobileSevenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      mobileThirtyDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      updateDataMobile(days_in_the_past);
    });

    mobileThirtyDayBtn.addEventListener('click', (event) => {
      event.target.classList.add('opacity-50', 'cursor-not-allowed');
      mobileSevenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      mobileFifteenDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      updateDataMobile(days_in_the_past);
    });

    // SETTING LISTENERS AND CLASSES FOR BUTTONS
    let mobilePreviousWeekBtn = document.querySelector('#mobile-previous-week');
    let mobileNextWeekBtn = document.querySelector('#mobile-next-week');
    let mobilePreviousDayBtn = document.querySelector('#mobile-previous-day');
    let mobileNextDayBtn = document.querySelector('#mobile-next-day');

    mobilePreviousWeekBtn.addEventListener('mousedown', (event) => {
      if (mobilePreviousWeekBtn.matches(".cursor-not-allowed") === false) {
        days_in_the_past += 7;
        updateDataMobile(days_in_the_past);
        mobileNextWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        mobileNextDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      }
    });

    mobileNextWeekBtn.addEventListener('mousedown', (event) => {
      if (mobileNextWeekBtn.matches(".cursor-not-allowed") === false) {
        days_in_the_past -= 7;
        updateDataMobile(days_in_the_past);
        mobilePreviousWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        mobilePreviousDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      }
    });

    mobilePreviousDayBtn.addEventListener('mousedown', (event) => {
      if (mobilePreviousDayBtn.matches(".cursor-not-allowed") === false) {
        days_in_the_past += 1;
        updateDataMobile(days_in_the_past);
        mobileNextDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        mobileNextWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      }
    });

    mobileNextDayBtn.addEventListener('mousedown', (event) => {
      if (mobileNextDayBtn.matches(".cursor-not-allowed") === false) {
        days_in_the_past -= 1;
        updateDataMobile(days_in_the_past);
        mobilePreviousDayBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        mobilePreviousWeekBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      }
    });
  };
}

var updateDataMobile = (days_in_the_past) => {
  fetch("/dashboard.json")
    .then(response => response.json())
    .then((data) => {
      setGraphRangeMobile(data.feelings, days_in_the_past);
    });
}


const setGraphRangeMobile = (feelings, days_in_the_past) => {
  var oldChart = document.querySelector("#chart");
  oldChart.innerHTML = '';
  var amountOfDays = 7;

  var mobileSevenDayBtn = document.querySelector('#mobile-seven-day-view');
  var mobileFifteenDayBtn = document.querySelector('#mobile-fifteen-day-view');
  var mobileThirtyDayBtn = document.querySelector('#mobile-thirty-day-view');

  if (mobileSevenDayBtn.matches(".cursor-not-allowed")) {
    amountOfDays = 7;
  } else if (mobileFifteenDayBtn.matches(".cursor-not-allowed")) {
    amountOfDays = 15;
  } else if (mobileThirtyDayBtn.matches(".cursor-not-allowed")) {
    amountOfDays = 30;
  }

  let mobilePreviousWeekBtn = document.querySelector('#mobile-previous-week');
  let mobileNextWeekBtn = document.querySelector('#mobile-next-week');
  let mobilePreviousDayBtn = document.querySelector('#mobile-previous-day');
  let mobileNextDayBtn = document.querySelector('#mobile-next-day');

  if (days_in_the_past >= feelings.happiness.dates.length - amountOfDays ) {
    days_in_the_past = feelings.happiness.dates.length - amountOfDays;
    mobilePreviousWeekBtn.classList.add('opacity-50', 'cursor-not-allowed');
    mobilePreviousDayBtn.classList.add('opacity-50', 'cursor-not-allowed');
  } else if (days_in_the_past <= 0) {
    days_in_the_past = 0;
    mobileNextWeekBtn.classList.add('opacity-50', 'cursor-not-allowed');
    mobileNextDayBtn.classList.add('opacity-50', 'cursor-not-allowed');
  };

  var most_recent_day = feelings.happiness.dates.length - days_in_the_past;
  // console.log(`most_recent_day = ${most_recent_day}`);
  // console.log(`days_in_the_past = ${days_in_the_past}`);
  // console.log(`amountOfDays = ${amountOfDays}`);
  // console.log(`--------------------------------------`);
  updateGraphMobile(feelings, most_recent_day, amountOfDays);
}

const updateGraphMobile = (feelings, most_recent_day, amountOfDays) => {
  var options = {
    chart: {
      type: 'line',
      background: '#fff',
      animations: {
          enabled: false,
      },
      height: '200rem',
      toolbar: {
          show: false
      },
    },
    colors: ['#38A89D', '#794ACF', '#F6993F', '#FFED4A'],
    legend: {
      position: 'bottom'
    },
    yaxis: {
        max: 6,
        min: 0,
        tickAmount: 6,
        decimalsInFloat: 5,
        labels: {
            show: false
        }
    },
    stroke: {
        curve: 'smooth'
        },
    series: [{
        name: 'Happiness',
        data: feelings.happiness.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
        }, {
        name: 'Carefreeness',
        data: feelings.carefreeness.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
        }, {
        name: 'Patience',
        data: feelings.patience.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
        }, {
        name: 'Sleep',
        data: feelings.sleep.intensities.slice(most_recent_day - amountOfDays, most_recent_day)
    }],
    xaxis: {
      categories: feelings.happiness.dates.slice(most_recent_day - amountOfDays, most_recent_day)
    }
  }
  var chart = new ApexCharts(document.querySelector("#chart"), options);
  chart.render();
}

export { changeGraphMobile };
