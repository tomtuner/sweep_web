$(document).ready(function(){

	$.plot(
		$("#placeholder"), [ [[0, 0], [1, 1]] ], { yaxis: { max: 1 } });
});