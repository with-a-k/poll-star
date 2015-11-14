$(document).ready(function (){
	var $buttons = $('.option-vote');

	for (var i = 0; i < $buttons.length; i++) {
		$buttons[i].addEventListener('click', function submitVote(){
			console.log(this.innerText);
			for (var i = 0; i < $buttons.length; i++) {
				$buttons[i].removeEventListener('click', submitVote);
				$buttons[i].disabled = true);
			};
		});
	};
});