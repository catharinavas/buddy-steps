import ApexCharts from 'apexcharts';

var placeholderGraph = () => {
  var options = {
    chart: {
      title: 'This graph could be yours',
      type: 'line',
      height: '100rem',
      toolbar: {
          show: false,
        },
    },
    colors: ['#38A89D'],
    stroke: {
      curve: 'smooth'
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
    series: [{
      name: '',
      data: [3,4,4,4,5,4,2,5,3,3]
    }],
    xaxis: {
      categories: ["","","","","","","","","",""]
    }
  }

  var chart = new ApexCharts(document.querySelector("#placeholder-chart"), options);

  chart.render();
}

export { placeholderGraph }
