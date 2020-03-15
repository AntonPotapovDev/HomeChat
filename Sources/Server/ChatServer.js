const broadcast_address = '255.255.255.255'
const port = 8089

let local_ip = ''

let message_log = []
let lastIndex = 0
let users = []
let access_codes = []

function main() {
    init()
    startListen()
    startBroadcast()
}

function init() {
    const os = require('os')
    let ifaces = os.networkInterfaces()

    Object.keys(ifaces).forEach( ifname => {
        let alias = 0

        ifaces[ifname].forEach( iface => {
            if ('IPv4' !== iface.family || iface.internal !== false)
                return

            if (alias >= 1)
                local_ip = iface.address
            else
                local_ip = iface.address

            ++alias
        })
    })
}

function startBroadcast() {
    const emiter = require('dgram').createSocket('udp4')
    const interval = 500

    let broadcast = () => {
        let msg = Buffer.from(local_ip)
        emiter.send(msg, 0, msg.length, port, broadcast_address, err => {
            if (err)
                console.log(err)
        })
    }

    emiter.bind(() => {
        emiter.setBroadcast(true)
        broadcast_task = setInterval(broadcast, interval)
    })
}

function startListen() {
    const express = require('express')
    const bodyParser = require('body-parser')
    const app = express()

    app.use(bodyParser.json())

    app.post('/message.get', (request, response) => {
        let index = parseInt(request.query.from)

        let result = index !== undefined && index != -1 ? { messages: message_log.slice(index) }
            : { messages: message_log }

        response.status(200).json(result)
    })

    app.post('/message.new', (request, response) => {
        request.body.index = lastIndex
        lastIndex++
        message_log.push(request.body)
        console.log(request.body)
        response.status(200).end()
    })

    app.post('/register', (request, response) => {
        let successCode = 0
        let alreadyUsedEmailCode = 1
        let noAccessCode = 2

        let access_code = parseInt(request.body.code)
        let email = request.body.email

        let is_new_user = users.findIndex((element) => {
            return element.email == email 
        }) == -1

        let let_access = access_codes.findIndex((element) => {
            return element.email == email && element.code == access_code
        })

        if (!is_new_user) {
            response.status(200).json({ register_status: alreadyUsedEmailCode })
            return
        }

        if (let_access >= 0) {
            users.push({ email: email, name: request.body.name, password: request.body.password })
            access_codes.splice(let_access, 1)
            response.status(200).json({ register_status: successCode })
        }
        else {
            response.status(200).json({ register_status: noAccessCode })
        }
    })

    app.post('/login', (request, response) => {

    })

    app.listen(port)
}

main()
