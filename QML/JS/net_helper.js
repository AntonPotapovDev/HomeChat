
var server_ip = ''

function init(address) {
    server_ip = address
}

function request(method) {
    let url = 'https://' + server_ip + '/' + method
    fetch(url)
}
