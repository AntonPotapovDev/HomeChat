import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

Item 
{
	id     : root
	width  : maxWidth
	height : minHeight

	property color color
	property bool isLeftSide : true
	property var text        : ''
	property real maxWidth   : 400
	property real minHeight  : 40

	Component.onCompleted:
	{
		var newWidth = Math.min(root.maxWidth, textArea.contentWidth)
		var newHeight = Math.max(root.minHeight, textArea.contentHeight)
		root.width = newWidth
		root.height = newHeight
	}

	Rectangle 
	{
		id           : roundRect
		anchors.fill : parent
		color        : root.color
		radius       : root.height / 4
		z            : 1

		TextArea  
		{
			id               : textArea
			anchors.fill     : parent
			padding          : Sizes.midPadding
			rightPadding     : roundRect.radius
			leftPadding      : roundRect.radius
			font.family      : Fonts.textFont
			font.pointSize   : Fonts.smallPointSize
			text             : root.text
			color            : Fonts.textColor
			wrapMode         : TextEdit.Wrap
			readOnly         : true
			selectByKeyboard : true
			selectByMouse    : true 
		}
	}

	Rectangle 
	{
		id          : sqrRect
		anchors.top : roundRect.top
		width       : roundRect.radius
		height      : roundRect.radius
		color       : root.color
	}

	states: 
	[
		State 
		{
			name : "left"
			when : root.isLeftSide

			AnchorChanges 
			{
				target        : sqrRect
				anchors.left  : roundRect.left
				anchors.right : undefined
			}
		},
		State 
		{
			name : "right"
			when : !root.isLeftSide

			AnchorChanges 
			{
				target        : sqrRect
				anchors.left  : undefined
				anchors.right : roundRect.right
			}
		}
	]
}
