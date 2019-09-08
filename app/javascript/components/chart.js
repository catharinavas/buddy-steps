import ApexCharts from 'apexcharts';

var fetchGraphData = () => {
  fetch("/dashboard/1.json")
    .then(response => response.json())
    .then((data) => {
      generateGraph(data.feelings);
    });
}

var generateGraph = (feelings) => {
  var options = {
    chart: {
      type: 'line'
    },
    series: [{
      name: 'Happiness',
      data: feelings.happiness.intensities
    }, {
      name: 'Carefreeness',
      data: feelings.carefreeness.intensities
    }, {
      name: 'Patience',
      data: feelings.patience.intensities
    }, {
      name: 'Sleep',
      data: feelings.sleep.intensities
    }],
    xaxis: {
      categories: feelings.happiness.dates
    }
  }

  var chart = new ApexCharts(document.querySelector("#chart"), options);

  chart.render();
}

export { fetchGraphData };
