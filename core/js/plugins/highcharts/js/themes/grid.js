/**
 * Grid theme for Highcharts JS
 * @author Torstein Hønsi
 */

Highcharts.theme = {
	colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
	
	title: {
		style: { 
			color: '#000',
			font: 'bold 16px "Trebuchet MS", Verdana, sans-serif'
		}
	},
	subtitle: {
		style: { 
			color: '#666666',
			font: 'bold 12px "Trebuchet MS", Verdana, sans-serif'
		}
	},
	xAxis: {
		gridLineColor: '#E6E6E6',
		gridLineWidth: 1,
		lineColor: '#ccc',
		tickColor: '#ccc',
		labels: {
			style: {
				color: '#000',
				font: '11px Trebuchet MS, Verdana, sans-serif'
			}
		},
		title: {
			style: {
				color: '#333',
				fontWeight: 'bold',
				fontSize: '12px',
				fontFamily: 'Trebuchet MS, Verdana, sans-serif'

			}				
		}
	},
	yAxis: {
		gridLineColor: '#E6E6E6',
		minorTickInterval: 'auto',
		lineColor: '#ccc',
		lineWidth: 1,
		tickWidth: 1,
		tickColor: '#ccc',
		labels: {
			style: {
				color: '#000',
				font: '11px Trebuchet MS, Verdana, sans-serif'
			}
		},
		title: {
			style: {
				color: '#333',
				fontWeight: 'bold',
				fontSize: '12px',
				fontFamily: 'Trebuchet MS, Verdana, sans-serif'
			}				
		}
	},
	legend: {
		borderRadius: '2',
		borderColor: '#E6E6E6',
		itemStyle: {			
			font: '9pt Trebuchet MS, Verdana, sans-serif',
			color: 'black',
			

		},
		itemHoverStyle: {
			color: '#039'
		},
		itemHiddenStyle: {
			color: 'gray'
		}
	},
	labels: {
		style: {
			color: '#99b'
		}
	},
	tooltip: {
		borderColor: '#E6E6E6',
		shadow: 'false',		
		 shared: 'true',
		 crosshairs: 'true'
	
	}
};

// Apply the theme
var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
	
