let server_ip = ''
let server_port = 0

function init(address, port) {
    server_ip = address
    server_port = port 
}

function messages(callback) {
    let request = method('message.get', callback)
    request.send()
}

function send(message) {
    let request = method('message.new')
    let json = JSON.stringify(message)
    request.send(json)
}

function method(name, callback) {
    let url = 'http://' + server_ip + ':' + server_port + '/' + name

    let request = new XMLHttpRequest()
    request.open('POST', url)

    request.onreadystatechange = () => {
        if (request.readyState !== XMLHttpRequest.DONE)
            return

        let resp = { status: request.status }

        if (request.status === 200 && request.responseText.length != 0)
            resp = JSON.parse(request.responseText)

        if (callback)
            callback(resp)
    }

    request.setRequestHeader('Content-Type', 'application/json; charset=utf-8')
    return request
}

