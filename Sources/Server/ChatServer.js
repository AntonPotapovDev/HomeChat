const dgram = require('dgram')
const emiter = dgram.createSocket('udp4')
const broadcast_address = '255.255.255.255'
const port = 8089
const interval = 500

var local_ip = ""

function init() {
    var os = require('os');
    var ifaces = os.networkInterfaces();

    Object.keys(ifaces).forEach(function (ifname) {
        var alias = 0

        ifaces[ifname].forEach(function (iface) {
            if ('IPv4' !== iface.family || iface.internal !== false)
                return

            if (alias >= 1)
                local_ip = iface.address
            else
                local_ip = iface.address

            ++alias
        });
    });
}

function startBroadcast() {
    emiter.bind(() => {
        emiter.setBroadcast(true)
        broadcast_task = setInterval(broadcast, interval)
    })
}

function broadcast() {
    let msg = Buffer.from(local_ip)
    emiter.send(msg, 0, msg.length, port, broadcast_address, (err) => {
        if (err)
            console.log(err)
    })
}

init()
startBroadcast()
