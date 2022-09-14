const express = require('express')
const {Server: HttpServer} = require('http')
const {Server: IOServer} = require('socket.io')
const knex = require('knex')

const knexSqlite = knex({
	client: 'sqlite3',
	connection: {
		filename: __dirname+'./db.sqlite'
	}
})

const app = express()

app.use(express.json())
app.use(express.static('./public'))

const httpServer = new HttpServer(app)

httpServer.listen(8080, () => {
	console.log('server on')
})

const io = new IOServer(httpServer)


async function createTables() {
	const exists = await knexSqlite.schema.hasTable('message')
	if (!exists) {
		await knexSqlite.schema.createTable('message', table => {
			table.increments('id'),
			table.string('from'),
			table.string('text')
		})
	}
}

createTables()

io.on('connection', async socket => {
	const messages = await knexSqlite.from('message').select('from', 'text')
	socket.emit('messages', messages)

	socket.on('newMessage', async msg => {
		await knexSqlite('message').insert({from: socket.id, text: msg})
		const messages = await knexSqlite.from('message').select('from', 'text')
		io.sockets.emit('messages', messages)
	})
})