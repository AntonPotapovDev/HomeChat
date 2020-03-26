import QtQuick 2.14
import HomeChat 1.0

import "../JS/net_helper.js" as ChatAPI

Rectangle 
{
	id : root
	color : Colors.background

	property string state : 'login'
	property var userInfo

	function runAnimation(target) {
		switch_animation.target = target
		switch_animation.running = true
	}

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
		onActiveChanged: if (active) root.runAnimation(chat_view_loader.item)
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
			onJoin: root.state = 'register'
		}
		onActiveChanged: if (active) root.runAnimation(login_view_loader.item)
	}

	Loader
	{
		id           : register_view_loader
		anchors.fill : parent
		active       : root.state == 'register'
		sourceComponent: RegisterView 
		{
			serverAPI : ChatAPI
			onSuccessfullRegistered:
			{
				var info = {
					email: email,
					name: name
				}
				root.userInfo = info
				root.state = 'chat'
			}
			onBack: root.state = 'login'
		}
		onActiveChanged: if (active) root.runAnimation(register_view_loader.item)
	}

	NumberAnimation 
	{
        id          : switch_animation
        property    : 'x'
        from        : -root.width
        to          : 0
        duration    : Sizes.viewSwitchingAnimationDuration
        easing.type : Easing.InOutQuad 
    }

	ServerAddressProvider
	{
		id   : server_address
		port : 8089

		Component.onCompleted: find()
		onAddressFound: ChatAPI.init(address, port)
	}
}
