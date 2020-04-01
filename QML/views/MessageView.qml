import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls"

Item 
{
	id : root

	property var model : null
	property bool onTop : flick.contentHeigh > flick.height && flick.contentY < flick.contentHeight / 2

	Flickable 
	{
		id            : flick
		anchors.fill  : parent
		contentHeight : column.height
		topMargin     : Sizes.extraLargeMargin
		bottomMargin  : Sizes.extraLargeMargin
		clip          : true

		onAtYBeginningChanged: 
		{
			if (atYBeginning && contentY < -topMargin)
				model.requestOldMessages()
		}

		ColumnLayout
		{
			id      : column
			width   : parent.width
			spacing : Sizes.extraLargeMargin

			Repeater 
			{
				property int prevCount : 0

				model : root.model.list

				onCountChanged:
				{  
					if (count > prevCount && flick.contentHeight > flick.height && !root.onTop)
						flick.contentY = flick.contentHeight - flick.height + flick.bottomMargin

					prevCount = count
				}

				delegate: Item 
				{
					id                     : msgContainer
					Layout.fillWidth       : true
					Layout.preferredHeight : msgBox.height
					Layout.rightMargin     : Sizes.extraLargeMargin
					Layout.leftMargin      : Sizes.extraLargeMargin

					MessageBox 
					{
						id             : msgBox
						anchors.top    : parent.top
						anchors.right  : parent.right
						maxBoxWidth    : parent.width / 2
						isLeftSide     : !model.isOwn
						authorName     : model.name
						dateTimeString : model.dateTime
						text           : model.text
					}

					states: 
					[
						State 
						{
							name : "left"
							when : !model.isOwn

							AnchorChanges 
							{
								target        : msgBox
								anchors.left  : msgContainer.left
								anchors.right : undefined
							}
						},
						State 
						{
							name : "right"
							when : model.isOwn

							AnchorChanges 
							{
								target        : msgBox
								anchors.left  : undefined
								anchors.right : msgContainer.right
							}
						}
					]
				}
			}
		}
	}
}