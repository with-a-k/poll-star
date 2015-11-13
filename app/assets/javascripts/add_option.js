$(document).ready(function (){
	var $options = $('.options-fields');

	$('#add-option').on('click', function (e){
		e.preventDefault();
		$("<label>Option</label> <input type='text' name='poll[options][]' id='poll_options'></input><br>").appendTo($options);
	});
});