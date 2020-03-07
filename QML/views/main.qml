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
					isOwn : true,
					name : 'Anton',
					text : msgBar.text,
					dateTime : '6/3/2020'
				}
				msgModel.append(msg)
				msgBar.text = ''
			}
		}
	}

	ServerAddress
	{
		id   : server_address
		port : 8089

		Component.onCompleted: server_address.find()
		onAddressFound: {
			console.log(address)
			var url = 'http://' + server_address.address + ':' + port

			var json = JSON.stringify({
				name: "Foo",
				surname: "bar"
			});

			var request = new XMLHttpRequest()
			request.open('POST', url)
			request.setRequestHeader('Content-Type', 'application/json; charset=utf-8')
			request.send(json)
		}
	}
}
