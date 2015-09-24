// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

google.load('visualization', '1.0', { packages:["timeline"] });
google.setOnLoadCallback(drawChart);

function drawChart() {
  var container = document.getElementById('timeline');
  var chart = new google.visualization.Timeline(container);
  var dataTable = new google.visualization.DataTable();

  dataTable.addColumn({ type: 'string', id: 'President' });
  dataTable.addColumn({ type: 'date', id: 'Start' });
  dataTable.addColumn({ type: 'date', id: 'End' });
  dataTable.addRows([
    [ 'Washington', new Date(1789, 3, 30), new Date(1797, 2, 4) ],
    [ 'Adams',      new Date(1797, 2, 4),  new Date(1801, 2, 4) ],
    [ 'Jefferson',  new Date(1801, 2, 4),  new Date(1809, 2, 4) ]]);

  chart.draw(dataTable);
}