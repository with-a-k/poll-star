$(document).ready(function (){
	var socket = io('http://localhost:4000');
	var pollId = $('#poll-title').attr('data-id');
	var pollClosed = $('#poll-title').attr('data-closed');

	socket.on(pollId, function(message) {
		refreshPoll(message)
	});

	function refreshPoll(data_object) {
		$('#results-area').empty();

		$.ajax({
			type: 'GET',
			url:  `/api/v1/polls/${pollId}`,
			success: function(poll) {
				pollClosed = poll['closed']
				$.each(poll['options'], function(index, option) {
					renderResult(option)
				})
			}
		});
	}

	function renderResult(option) {
		$('#results-area').append(
			`<div class="option-result">
			<strong class="result-body">${option.body}:</strong> <span class="result-votes">${option.votes}</span>
			</div>`
		)
	}

	function submitVote(){
		var text = $(this).innerText
		$.ajax({
			type: 'PATCH',
			url:  `/api/v1/options/${$(this).attr('data-id')}`,
			success: function(response) {
				socket.send(pollId, response);
			}
		});
		for (var i = 0; i < $buttons.length; i++) {
			$buttons[i].removeEventListener('click', submitVote);
			$buttons[i].disabled = true;
		};
	};

	var $buttons = $('.option-vote');

	for (var i = 0; i < $buttons.length; i++) {
		if(pollClosed) {
			for (var i = 0; i < $buttons.length; i++) {
				$buttons[i].removeEventListener('click', submitVote);
				$buttons[i].disabled = true;
			};
		} else {
			$buttons[i].addEventListener('click', submitVote);
		}
	};
});