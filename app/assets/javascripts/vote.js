$(document).ready(function (){
	function refreshPoll() {
		var pollId = $('#results-area').attr('data-id');
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
			console.log(this.innerText);
			$.ajax({
				type: 'PATCH',
				url:  `/api/v1/options/${$(this).attr('data-id')}`,
				success: refreshPoll()
			});
			for (var i = 0; i < $buttons.length; i++) {
				$buttons[i].removeEventListener('click', submitVote);
				$buttons[i].disabled = true;
			};
		});
	};
});