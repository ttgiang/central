var chart1; // globally available
var chart2; // globally available
var chart3; // globally available

    // chart one - description here
	$(document).ready(function() {
      chart1 = new Highcharts.Chart({
         chart: {
            renderTo: 'pasta',
            type: 'line',
			plotBorderColor: 'fff',
			plotBackgroundColor: 'fff',
			borderColor: 'fff',
			backgroundColor: 'fff',
			width: 530
         },
		 tooltip: {
		 },
         title: {
            text: 'Meals To Go - Amounts sold (last 7 days)'
         },
         xAxis: {
        	categories: ['8/29', '8/30', '8/31', '9/1', '9/2', '9/3', '9/4']
    	 },
         yAxis: {
            title: {
               text: ''
            }
         },
         series: [{
            name: 'Whole Turkey',
            data: [1, 0, 4, 1, 9, 9, 0]
         }, {
			name: 'Half Turkey',
            data: [4, 5, 2, 1, 1, 2, 1]
         }, {
			name: 'Pumpkin Pie',
            data: [2, 3, 1, 1, 2, 2, 3]
         }, {
            name: 'Custard Pie',
            data: [5, 7, 3, 4, 5, 5, 5]
         }]
      });
	  
	 // chart two - description here
	 chart2 = new Highcharts.Chart({
         chart: {
            renderTo: 'pastb',
            type: 'line',
			plotBorderColor: 'fff',
			plotBackgroundColor: 'fff',
			borderColor: 'fff',
			backgroundColor: 'fff',
			width: 530
         },
		 tooltip: {
		 },
         title: {
            text: 'Meals To Go - Amounts sold (last 7 days)'
         },
         xAxis: {
        	categories: ['8/29', '8/30', '8/31', '9/1', '9/2', '9/3', '9/4']
    	 },
         yAxis: {
            title: {
               text: ''
            }
         },
         series: [{
            name: 'Whole Turkey',
            data: [1, 0, 4, 1, 9, 9, 0]
         }, {
			name: 'Half Turkey',
            data: [4, 5, 2, 1, 1, 2, 1]
         }, {
			name: 'Pumpkin Pie',
            data: [2, 3, 1, 1, 2, 2, 3]
         }, {
            name: 'Custard Pie',
            data: [5, 7, 3, 4, 5, 5, 5]
         }]
      });
	
	chart3 = new Highcharts.Chart({
         chart: {
            renderTo: 'pastc',
            type: 'line',
			plotBorderColor: 'fff',
			plotBackgroundColor: 'fff',
			borderColor: 'fff',
			backgroundColor: 'fff',
			width: 530
         },
		 tooltip: {
		 },
         title: {
            text: 'Meals To Go - Amounts sold (last 7 days)'
         },
         xAxis: {
        	categories: ['8/29', '8/30', '8/31', '9/1', '9/2', '9/3', '9/4']
    	 },
         yAxis: {
            title: {
               text: ''
            }
         },
         series: [{
            name: 'Whole Turkey',
            data: [1, 0, 4, 1, 9, 9, 0]
         }, {
			name: 'Half Turkey',
            data: [4, 5, 2, 1, 1, 2, 1]
         }, {
			name: 'Pumpkin Pie',
            data: [2, 3, 1, 1, 2, 2, 3]
         }, {
            name: 'Custard Pie',
            data: [5, 7, 3, 4, 5, 5, 5]
         }]
      });
});

