import QtQuick 2.14
import HomeChat 1.0

import "../JS/net_helper.js" as ChatAPI

Item 
{
	id : root

	property string state : 'login'
	property var userInfo

	Loader 
	{
		id           : chat_view_loader
		anchors.fill : parent
		active       : root.state == 'chat'
		sourceComponent: ChatView
		{
			serverAPI : ChatAPI
			userInfo  : root.userInfo
		}
	}
	
	Loader 
	{
		id           : login_view_loader
		anchors.fill : parent
		active       : root.state == 'login'
		sourceComponent: LoginView 
		{
			serverAPI : ChatAPI
			onSuccessfullAutorized:
			{
				var info = {
					email: email,
					name: name
				}
				root.userInfo = info
				root.state = 'chat'
			} 
		}
	}

	ServerAddressProvider
	{
		id   : server_address
		port : 8089

		Component.onCompleted: find()
		onAddressFound: ChatAPI.init(address, port)
	}
}
