
class IPBroadcaster {
	constructor(port, broadcast_address, broadcast_interval) {
        this._port = port;
        this._local_ip = '';
        this._address = broadcast_address;
        this._interval = broadcast_interval;

        this._find_local_ip();
        if (this._local_ip.length == 0)
            console.log('error!');
	}

    Start() {
        const emiter = require('dgram').createSocket('udp4');

        emiter.bind(() => {
            emiter.setBroadcast(true);
            broadcast_task = setInterval(this._broadcast, this._interval);
        });
    }

    _broadcast() {
        let msg = Buffer.from(this._local_ip);
        emiter.send(msg, 0, msg.length, this._port, this._address, error => {
            if (error)
                console.log(error);
        });
    }

    _find_local_ip() {
        const os = require('os');
        let ifaces = os.networkInterfaces();

        Object.keys(ifaces).forEach( ifname => {
            let alias = 0;

            ifaces[ifname].forEach( iface => {
                if ('IPv4' !== iface.family || iface.internal !== false)
                    return;

                if (alias >= 1)
                    this._local_ip = iface.address;
                else
                    this._local_ip = iface.address;

                ++alias;
            });
        });
    }
}

module.exports = {
    IPBroadcaster: IPBroadcaster
};
