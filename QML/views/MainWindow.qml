import QtQuick 2.14
import HomeChat 1.0

import "../JS/net_helper.js" as ChatAPI

Item 
{
	id : root

	property string state : 'login'

	Loader 
	{
		id           : chat_view_loader
		anchors.fill : parent
		active       : root.state == 'chat'
		sourceComponent: ChatView
		{
			serverAPI : ChatAPI
		}
	}
	
	Loader 
	{
		id           : login_view_loader
		anchors.fill : parent
		active       : root.state == 'login'
		sourceComponent: 
		LoginView 
		{
			serverAPI : ChatAPI
		}
	}

	ServerAddressProvider
	{
		id   : server_address
		port : 8089

		Component.onCompleted: find()
		onAddressFound: 
		{
			ChatAPI.init(address, port)

			let user = {
				name: root.userInfo.name,
				email: root.userInfo.email,
				password: '11121998q',
				code: 123
			}

			serverAPI.register(resp => { console.log(resp.register_status) }, user)
		}
	}
}
