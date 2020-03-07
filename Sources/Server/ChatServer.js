const broadcast_address = '255.255.255.255'
const port = 8089

let local_ip = ''

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

    app.post('/', (request, response) => {
        console.log(request.body)
    })

    app.listen(port)
}

main()
