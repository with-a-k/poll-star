$(document).ready(function (){
	var socket = io('http://localhost:4000');
	var pollId = $('#poll-title').attr('data-id');

	socket.on(pollId, function() {
		refreshPoll()
	});

	function refreshPoll() {
		$('#results-area').empty();

		$.ajax({
			type: 'GET',
			url:  `/api/v1/polls/${pollId}`,
			success: function(poll) {
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

	var $buttons = $('.option-vote');

	for (var i = 0; i < $buttons.length; i++) {
		$buttons[i].addEventListener('click', function submitVote(){
			var text = $(this).innerText
			$.ajax({
				type: 'PATCH',
				url:  `/api/v1/options/${$(this).attr('data-id')}`,
				success: function() {
					socket.send(pollId, "Update " + pollId); 
				}
			});
			for (var i = 0; i < $buttons.length; i++) {
				$buttons[i].removeEventListener('click', submitVote);
				$buttons[i].disabled = true;
			};
		});
	};
});