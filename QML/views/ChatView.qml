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
	property var userInfo

	signal logout()
	
	ColumnLayout
	{
		anchors.fill : parent
		spacing : 0

		Row 
		{
			Layout.fillWidth       : true
			Layout.preferredHeight : Sizes.topPanelHeight
			spacing                : 0

			IconButton
			{
				width        : Sizes.backButtonWidth
				height       : Sizes.topPanelHeight
				symbol       : '<' //TODO: do not forget to change symbol to svg
				iconSize     : Fonts.largePointSize
				onClicked    : root.logout()
			}
		}

		Rectangle 
		{
			id                 : chatRect
			Layout.fillWidth   : true
			Layout.fillHeight  : true
			Layout.leftMargin  : Sizes.largeMargin
			Layout.rightMargin : Sizes.largeMargin
			radius             : Sizes.roundingRadius
			color              : Colors.uiElement

			MessageModel
			{
				id        : msgModel
				serverAPI : root.serverAPI
				userInfo  : root.userInfo
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
			Layout.margins         : Sizes.largeMargin

			Component.onCompleted : forceActiveFocus()
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
