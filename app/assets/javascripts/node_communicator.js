$(document).ready {
	const io = require('socket.io');
	var socket = io('http://localhost:4000')

	io.on('connection', function() {
		socket.emit('connectionOK', 'Connection established.')
	})
}