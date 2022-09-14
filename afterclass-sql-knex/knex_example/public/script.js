const ioClient = io()

const msgSender = document.querySelector('#msgSender')
const msgContent = document.querySelector('#msgContent')
const chat = document.querySelector('.chat')

msgSender.addEventListener('click', () => {
	ioClient.emit('newMessage', msgContent.value)
})

ioClient.on('messages', msgs => {
	const html = msgs.map(msg => `<p>${msg.from}: ${msg.text}</p>`).join(' ')
	chat.innerHTML = html
})