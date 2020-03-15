import QtQuick 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls/"
import "../JS/net_helper.js" as Chat

Rectangle
{
	id     : root
    width  : Sizes.appDefaultWidth
    height : Sizes.appDefaultHeight
    color  : Colors.background

	property var ownEmail : 'protestandprotect52@gmail.com'
	property var ownName : 'Anton'
	property int lastMsgIndex : -1

	function receiveMessages(resp) {
		var messages = resp.messages

		for (var i = 0; i < messages.length; i++) 
		{
			var msg = messages[i]
			var element = {
				isOwn : ownEmail == msg.email,
				name : msg.name,
				text : msg.text,
				dateTime : new Date(msg.dateTime).toLocaleString()
			}

			msgModel.append(element)
		}
	}

	ColumnLayout
	{
		anchors.fill : parent

		Rectangle 
		{
			id                : chatRect
			Layout.fillWidth  : true
			Layout.fillHeight : true
			Layout.margins    : Sizes.largeMargin
			radius            : Sizes.roundingRadius
			color             : Colors.uiElement

			ListModel
			{
				id : msgModel
			}

			MessageView 
			{
				id           : msgView
				anchors.fill : parent
				model        : msgModel
			}
		}

		MessageBar 
		{
			id                     : msgBar
			Layout.fillWidth       : true
			Layout.preferredHeight : Sizes.messageBarHeight
			Layout.bottomMargin    : Sizes.largeMargin
			Layout.leftMargin      : Sizes.largeMargin
			Layout.rightMargin     : Sizes.largeMargin

			onSending: 
			{
				if (msgBar.text.length == 0)
					return

				var msg = {
					email: root.ownEmail,
					name: root.ownName,
					text: msgBar.text,
					dateTime: new Date()
				}

				msgBar.text = ''
				Chat.send(msg)
				//Chat.messages(root.receiveMessages)
			}
		}
	}

	Timer 
	{
		id             : timer
		interval       : 10000
		repeat         : true
		triggeredOnStart : true

		onTriggered: Chat.messages(root.receiveMessages, root.lastMsgIndex)
	}

	ServerAddress
	{
		id   : server_address
		port : 8089

		Component.onCompleted: find()
		onAddressFound: 
		{
			Chat.init(address, port)
			timer.start()
		}
	}
}
