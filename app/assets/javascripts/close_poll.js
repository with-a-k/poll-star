$(document).ready(function (){
	var socket = io('http://localhost:4000');
	var pollId = $('#poll-title').attr('data-id');
	var pollClosed = $('#poll-title').attr('data-closed');

	var $button = $('#close-poll');

	if(pollClosed) {
		$button.disabled = true;
	} else {
		$button.on('click', function closePoll() {
			$.ajax({
				type: 'PATCH',
				url:  `/api/v1/polls/${pollId}`,
				success: function(response) {
					socket.send(pollId, "close")
					$button.removeEventListener('click', closePoll);
					$button.disabled = true;
				} 
			})
		});
	}
});