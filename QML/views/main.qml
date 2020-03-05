import QtQuick 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls/"

Rectangle
{
	id     : root
    width  : 1000
    height : 600
    color  : '#617cff'

	ColumnLayout
	{
		anchors.fill : parent

		Rectangle 
		{
			Layout.fillWidth  : true
			Layout.fillHeight : true
			Layout.margins    : 20
			radius            : 20
			color             : 'white'
		}

		MessageBar 
		{
			Layout.fillWidth       : true
			Layout.preferredHeight : 100
			Layout.bottomMargin    : 20
			Layout.leftMargin      : 20
			Layout.rightMargin     : 20
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
