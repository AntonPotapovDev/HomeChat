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

	property bool isLeftSide : true
	property var authorName  : ''
	property var dateTimeString : ''

	Component.onCompleted: resize()

	function resize() 
	{
		var newWidth = contentWidth + leftPadding + rightPadding
		var newHeight = contentHeight + padding * 2
		width = newWidth
		height = newHeight
	}

	background : Item 
	{
		id                       : backItem
		property color backColor : isLeftSide ? Colors.otherMessageColor : Colors.ownMessageColor

		Rectangle 
		{
			id           : roundRect
			anchors.fill : parent
			color        : backItem.backColor
			radius       : root.height / 4
			z            : 1

			Text 
			{
				text           : root.authorName
				font.family    : Fonts.textFont
				font.pointSize : Fonts.verySmallPointSize
				color          : Fonts.textColor
				y : -contentHeight
				x : root.isLeftSide ? Sizes.smallMargin : parent.width - contentWidth - Sizes.smallMargin
			}

			Text
			{
				text : root.dateTimeString
				font.family    : Fonts.textFont
				font.pointSize : Fonts.verySmallPointSize
				color          : Colors.background
				y : parent.height
				x : root.isLeftSide ? Sizes.smallMargin : parent.width - contentWidth - Sizes.smallMargin
			}
		}

		Rectangle 
		{
			id          : sqrRect
			anchors.top : roundRect.top
			width       : roundRect.radius
			height      : roundRect.radius
			color       : backItem.backColor
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

