import QtQuick 2.14
import QtQuick.Controls 2.14
import HomeChat 1.0

TextField 
{
	leftPadding          : Sizes.roundingRadius
	rightPadding         : Sizes.roundingRadius
	color                : Fonts.textColor 
	placeholderTextColor : Fonts.placeholderTextColor
	font.family          : Fonts.textFont
	font.pointSize       : Fonts.mediumPointSize
	verticalAlignment    : Text.AlignVCenter
	horizontalAlignment  : Qt.AlignLeft
	background : Rectangle 
	{
		color  : Colors.uiElement
		radius : Sizes.roundingRadius
	}
}
