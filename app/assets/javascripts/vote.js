$(document).ready(function (){
	var socket = io('http://localhost:4000');
	var pollId = $('#results-area').attr('data-id');

	function refreshPoll() {
		$('#results-area').empty();

		$.ajax({
			type: 'GET',
			url:  `/api/v1/polls/${pollId}`,
			success: function(poll) {
				$.each(poll['options'], function(index, option) {
					$('#results-area').append(
							`<div class="option-result">
			<strong class="result-body">${option.body}:</strong> <span class="result-votes">${option.votes}</span>
		</div>`
						)
				})
			}
		});
	}

	var $buttons = $('.option-vote');

	for (var i = 0; i < $buttons.length; i++) {
		$buttons[i].addEventListener('click', function submitVote(){
			$.ajax({
				type: 'PATCH',
				url:  `/api/v1/options/${$(this).attr('data-id')}`,
				success: function() {
					socket.emit('message', `${$(this).innerText} From ${pollId}`); 
				}
			});
			for (var i = 0; i < $buttons.length; i++) {
				$buttons[i].removeEventListener('click', submitVote);
				$buttons[i].disabled = true;
			};
			refreshPoll()
		});
	};
});