import QtQuick 2.14
import HomeChat 1.0

Item 
{
	id : root
	
	property var serverAPI
	property var userInfo
	property int optimalMessageCount
	property int packSize
	
	property alias list     : list_model
	property alias interval : timer.interval 

	property int firstMsgIndex      : -1
	property int lastMsgIndex       : -1
	property var pendingMessages    : []
	property var pendingOldMessages : []

	signal newMessagesReceived()
	signal oldMessagesReceived()

	Component.onCompleted: serverAPI.lastMessages(initReceive, optimalMessageCount)

	function pushNewMessages() {
		if (pendingMessages.length == 0)
			return


		for (var i = 0; i < pendingMessages.length; i++)
			list_model.append(pendingMessages[i])
		pendingMessages = []

		var countToDelete =  Math.max(list_model.count - optimalMessageCount, 0)
		if (countToDelete > 0)
			list_model.remove(0, countToDelete)
	}

	function pushOldMessages() {
		if (pendingOldMessages.length == 0)
			return

		for (var i = pendingOldMessages.length - 1; i >= 0; i--)
			list_model.insert(0, pendingOldMessages[i])
		pendingOldMessages = []

		var countToDelete = Math.max(list_model.count - optimalMessageCount, 0)
		if (countToDelete > 0)
			list_model.remove(list_model.length - countToDelete, countToDelete)
	}

	function receiveMessages(resp) {
		var messages = resp.messages

		for (var i = 0; i < messages.length; i++) {
			var element = formMessage(messages[i])
			pendingMessages.push(element)
		}

		if (messages && messages.length !== 0) {
			lastMsgIndex = messages[messages.length - 1].index + 1
			newMessagesReceived()
		}
	}

	function receiveOldMessages(resp) {
		var messages = resp.messages

		for (var i = 0; i < messages.length; i++) {
			var element = formMessage(messages[i])
			pendingOldMessages.push(element)
		}

		if (messages && messages.length !== 0) {
			firstMsgIndex = messages[0].index
			oldMessagesReceived()
		}
	}

	function initReceive(resp) {
		receiveMessages(resp)
		timer.start()
	}

	function requestOldMessages() {
		serverAPI.messages(receiveOldMessages, firstMsgIndex - packSize, firstMsgIndex)
	}

	function formMessage(message) {
		var element = {
			isOwn : userInfo.email == message.email,
			name : message.name,
			text : message.text,
			dateTime : new Date(message.dateTime).toLocaleString()
		}
		return element
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
		repeat           : true
		triggeredOnStart : false

		onTriggered: serverAPI.messages(receiveMessages, root.lastMsgIndex)
	}
}
