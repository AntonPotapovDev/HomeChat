import QtQuick 2.14
import HomeChat 1.0

import "../JS/net_helper.js" as ChatAPI

Rectangle 
{
	id : root
	color : Colors.background

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
		onActiveChanged: if (active) chat_animation.running = true
		NumberAnimation 
		{
            id          : chat_animation
            target      : chat_view_loader.item
            property    : 'x'
            from        : -root.width
            to          : 0
            duration    : 100
            easing.type : Easing.InOutQuad 
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
		onActiveChanged: if (active) login_animation.running = true
		NumberAnimation 
		{
            id          : login_animation
            target      : login_view_loader.item
            property    : 'x'
            from        : -root.width
            to          : 0
            duration    : 100
            easing.type : Easing.InOutQuad 
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
