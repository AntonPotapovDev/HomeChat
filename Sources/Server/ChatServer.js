let local_ip = ''

let message_log = []
let lastIndex = 0
let users = [ { email: 'text1@mail.com', name: 'Tosha', password: '11121998q'} ]
let access_codes = []//[ { code: 12345678, email: 'text1@mail.com' }, { code: 12345678, email: 'text2@mail.com' } ]

const port = 8089
const broadcast_address = '255.255.255.255'

class ChatServer {
    constructor(port, database, broadcaster) {
        this._port = port;
        this._database = database;
        this._broadcaster = broadcaster;
        this._app = require('express')();
        this._app.use(require('body-parser').json());
        this._init_methods();
    }

    Start() {
       this._app.listen(this._port);
       if (this._broadcaster)
           this.this._broadcaster.Start()
    }

    _init_methods() {
        this._app.post('/login', this._login);
        this._app.post('/register', this._register);
        this._app.post('/message.get', this._get_messages);
        this._app.post('/message.new', this._new_message);
    }

    _login(request, response) {
        let success_code = 0;
        let no_such_user_code = 1;
        let bad_password_code = 2;

        let user_index = users.findIndex(element => {
            return element.email == request.body.email;
        });

        if (user_index == -1) {
            response.status(200).json({ login_status: no_such_user_code });
            return;
        }

        if (users[user_index].password == request.body.password)
            response.status(200).json({ login_status: success_code, user_name: users[user_index].name });
        else
            response.status(200).json({ login_status: bad_password_code });
    }

    _register(request, response) {
        let successCode = 0;
        let alreadyUsedEmailCode = 1;
        let noAccessCode = 2;

        let access_code = parseInt(request.body.code);
        let email = request.body.email;

        let is_new_user = users.findIndex(element => {
            return element.email == email;
        }) == -1;

        let let_access = access_codes.findIndex(element => {
            return element.email == email && element.code == access_code;
        });

        if (!is_new_user) {
            response.status(200).json({ register_status: alreadyUsedEmailCode });
            return;
        }

        if (let_access >= 0) {
            users.push({ email: email, name: request.body.name, password: request.body.password });
            access_codes.splice(let_access, 1);
            response.status(200).json({ register_status: successCode });
        }
        else {
            response.status(200).json({ register_status: noAccessCode });
        }
    }

    _get_messages(request, response) {
        let from = parseInt(request.query.from);
        let to   = parseInt(request.query.to);
        let last = parseInt(request.query.last);

        let messages = [];
        if (!isNaN(from)) {
            from = from < 0 ? 0 : from;
            to = isNaN(to) || to < 0 ? undefined : to;
            messages = message_log.slice(from, to);
        }
        else if (!isNaN(last)) {
            last = message_log.length >= last ? last : message_log.length;
            messages = message_log.slice(message_log.length - last);
        }

        response.status(200).json({ messages: messages });
    }

    _new_message(request, response) {
        request.body.index = lastIndex;
        lastIndex++;
        message_log.push(request.body);
        console.log(request.body);
        response.status(200).end();
    }
}

function main() {
    let server = new ChatServer(port);
    server.Start();

    let IPBroadcaster = require('./IPBroadcaster').IPBroadcaster;
    let broadcaster = new IPBroadcaster(port, broadcast_address, 500)
    broadcaster.Start()
}

main();
