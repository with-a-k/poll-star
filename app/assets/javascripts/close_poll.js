$(document).ready(function (){
	var socket = io('https://salty-beach-2241.herokuapp.com');
	var pollId = $('#poll-title').attr('data-id');
	var pollClosed = $('#poll-title').attr('data-closed');

	var $button = $('#close-poll');

	if(pollClosed === "true") {
		$button.disabled = true;
	} else {
		$button.on('click', function closePoll() {
			$.ajax({
				type: 'PATCH',
				url:  '/api/v1/polls/' + pollId,
				success: function(response) {
					socket.send(pollId, response)
					$button.removeEventListener('click', closePoll);
					$button.disabled = true;
				} 
			})
		});
	}
});