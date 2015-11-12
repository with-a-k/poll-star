var $options = $('.options-fields')

$('#add-option').on('click', function(){
	$("<label>Option</label><input type='text' name='poll[options][]' id='poll_options'></input>").appendTo($options);
});