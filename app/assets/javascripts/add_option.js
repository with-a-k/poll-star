$(document).ready(function (){
	var $options = $('.options-fields');
	var idField = 1;

	$('#add-option').on('click', function (e){
		e.preventDefault();
		idField++;
		$(`<label>Option</label> <input type='text' name='poll[options][]' id='poll_options-${idField}'></input><br>`).appendTo($options);
	});
});