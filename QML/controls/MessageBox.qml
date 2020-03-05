import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

TextArea  
{
	id               : root
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

	property color backColor
	property bool isLeftSide : true

	Component.onCompleted: 
	{
		var newWidth = contentWidth + leftPadding + rightPadding
		var newHeight = contentHeight + padding * 2
		width = newWidth
		height = newHeight
	}

	background : Item 
	{
		Rectangle 
		{
			id           : roundRect
			anchors.fill : parent
			color        : root.backColor
			radius       : root.height / 4
		}

		Rectangle 
		{
			id          : sqrRect
			anchors.top : roundRect.top
			width       : roundRect.radius
			height      : roundRect.radius
			color       : root.backColor
		}
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
