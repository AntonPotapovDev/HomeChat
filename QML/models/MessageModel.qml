import QtQuick 2.14
import HomeChat 1.0

Item 
{
	id : root
	
	property var serverAPI
	property var userInfo
	property int lastMsgIndex : -1
	
	property alias model : list_model 

	function receiveMessages(resp) {
		var messages = resp.messages

		for (var i = 0; i < messages.length; i++) 
		{
			var msg = messages[i]
			var element = {
				isOwn : userInfo.email == msg.email,
				name : msg.name,
				text : msg.text,
				dateTime : new Date(msg.dateTime).toLocaleString()
			}
			listModel.append(element)
		}

		if (messages && messages.length)
			lastMsgIndex = messages[messages.length - 1].index + 1
	}

	function send(msg_text) {
			var msg = {
			email: userInfo.email,
			name: userInfo.name,
			text: msg_text,
			dateTime: new Date()
		}

		serverAPI.send(msg)
	}

	ListModel 
	{
		id : list_model
	}

	ServerAddressProvider
	{
		id   : server_address
		port : 8089

		Component.onCompleted: find()
		onAddressFound: 
		{
			serverAPI.init(address, port)
			timer.start()

			let user = {
				name: root.userInfo.name,
				email: root.userInfo.email,
				password: '11121998q',
				code: 123
			}

			serverAPI.register(resp => { console.log(resp.register_status) }, user)

			let info = {
				email: root.userInfo.email,
				password: '11121998q'
			}

			serverAPI.login(resp => {
				//console.log('Tosha samii lychii chom!lasia tebia lubit kak i ia tebia lublu!chom! ti ymnitsa!')
				console.log(resp.login_status)
			}, info)
		}
	}

	Timer 
	{
		id               : timer
		interval         : Sizes.messageFetchingInterval
		repeat           : true
		triggeredOnStart : true

		onTriggered: serverAPI.messages(root.receiveMessages, root.lastMsgIndex)
	}
}
