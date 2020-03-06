import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls"

Item 
{
	id : root

	property var model : null

	Flickable 
	{
		id : flick
		anchors.fill : parent
		contentHeight : column.height
		topMargin : Sizes.extraLargeMargin
		clip : true

		ColumnLayout
		{
			id : column
			width : parent.width
			spacing : 0

			Repeater 
			{
				model : root.model

				Item 
				{
					Layout.fillWidth : true
					Layout.preferredHeight : Sizes.messageBoxPreferredHeight
					Layout.rightMargin : Sizes.extraLargeMargin
					Layout.leftMargin : Sizes.extraLargeMargin

					MessageBox 
					{
						id : msgBox
						anchors.top : parent.top
						anchors.right : parent.right
						width : Sizes.messageBoxPreferredWidth
						height : Sizes.messageBoxPreferredHeight
						isLeftSide : false
						authorName : 'Anton Potapov'
						dateTimeString : ''
						text : 'Hello all! I am glad to see you here in this stupid chat! I need to type mode words to test this veiw.'

						Component.onCompleted : dateTimeString = new Date().toLocaleTimeString()
					}
				}
			}
		}
	}
}