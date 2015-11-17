$(document).ready(function (){
	var socket = io('http://localhost:4000');
	var pollId = $('#poll-title').attr('data-id');

	var $button = $('#close-poll');

	$button.on('click', function closePoll() {
		$.ajax({
			type: 'PATCH',
			url:  `api/v1/polls/${pollId}`,
			success: function(response) {
				socket.sent(pollId, "close")
				$button.removeEventListener('click', closePoll);
				$button.disabled = true;
			} 
		})
	});
});