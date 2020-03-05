import QtQuick 2.14
import HomeChat 1.0

Rectangle
{
    width: 800
    height: 600
    color: 'skyblue'

	ServerAddress
	{
		id : server_address
		port : 8089
		Component.onCompleted:
		{
			server_address.find()
		}
		onAddressFound:
		{
			console.log(server_address.address)
		}
	}
}
