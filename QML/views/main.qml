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
			Layout.fillWidth  : true
			Layout.fillHeight : true
			Layout.margins    : Sizes.largeMargin
			radius            : Sizes.roundingRadius
			color             : Colors.uiElement
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
