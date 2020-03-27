import QtQuick 2.14
import HomeChat 1.0

Item 
{
	id : root
	
	property var serverAPI
	property var userInfo
	property int lastMsgIndex : -1
	
	property alias model : list_model 

	Component.onCompleted: serverAPI.lastMessages(initReceive, Sizes.optimalMessageCount)

	function initReceive(resp) {
		receiveMessages(resp)
		timer.start()
	}

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
			list_model.append(element)
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

	Timer 
	{
		id               : timer
		interval         : Sizes.messageFetchingInterval
		repeat           : true
		triggeredOnStart : false

		onTriggered: serverAPI.messages(root.receiveMessages, root.lastMsgIndex)
	}
}
