import QtQuick 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls/"
import "../models/"

Rectangle
{
	id     : root
    width  : Sizes.appDefaultWidth
    height : Sizes.appDefaultHeight
    color  : Colors.background

	property var serverAPI
	property var ownEmail : 'protestandprotect52@gmail.com'
	property var ownName : 'Anton'
	
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

			MessageModel
			{
				id        : msgModel
				serverAPI : root.serverAPI
				userInfo:
				{
					"email": root.ownEmail,
					"name": root.ownName
				}
			}

			MessageView 
			{
				id           : msgView
				anchors.fill : parent
				model        : msgModel.model
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

				msgModel.send(msgBar.text)
				msgBar.text = ''
			}
		}
	}
}
