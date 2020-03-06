import QtQuick 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls/"

Rectangle
{
	id     : root
    width  : Sizes.appDefaultWidth
    height : Sizes.appDefaultHeight
    color  : Colors.background

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

			MessageView 
			{
				id           : msgView
				anchors.fill : parent
				model        : chatRect.msgModel
			}

			property var msgModel : [
				{
					isOwn : true,
					name : 'Anton',
					text : 'Short test message!',
					dateTime : '6/3/2020'
				},
				{
					isOwn : false,
					name : 'Blyad',
					text : 'Multiline test message! Wow! Many word! Such communication!',
					dateTime : '6/3/2020'
				},
				{
					isOwn : false,
					name : 'Suka',
					text : 'Medium length message to test out.',
					dateTime : '6/3/2020'
				},
				{
					isOwn : true,
					name : 'Anton',
					text : '.',
					dateTime : '6/3/2020'
				}
			]
		}

		MessageBar 
		{
			Layout.fillWidth       : true
			Layout.preferredHeight : Sizes.messageBarHeight
			Layout.bottomMargin    : Sizes.largeMargin
			Layout.leftMargin      : Sizes.largeMargin
			Layout.rightMargin     : Sizes.largeMargin
		}
	}

	ServerAddress
	{
		id   : server_address
		port : 8089

		Component.onCompleted: server_address.find()
		onAddressFound: console.log(server_address.address)
	}
}
