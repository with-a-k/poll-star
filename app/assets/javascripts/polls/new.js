$(document).ready(function(){
  $('#add-option').on('click', function(){
    $('.options-fields').append("<label>Option</label><input type='text' name='poll[options][]' id='poll_options'></input>");
  });
});