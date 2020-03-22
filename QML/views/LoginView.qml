import QtQuick 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls/"

Rectangle 
{
	id    : root
	color : Colors.background

	Column 
	{
		anchors.horizontalCenter : parent.horizontalCenter
		anchors.verticalCenter   : parent.verticalCenter
		spacing                  : Sizes.largeMargin

		Text 
		{
			width               : 300
			text                : 'Sign In'
			color               : Fonts.textColor 
			font.family         : Fonts.textFont
			font.pointSize      : Fonts.largePointSize
			verticalAlignment   : Text.AlignVCenter
			horizontalAlignment : Text.AlignHCenter
		}

		CustomField 
		{
			width           : 300
			height          : 50
			placeholderText : Strings.emailPlaceholderText
		}

		CustomField 
		{
			width                : 300
			height               : 50
			placeholderText      : Strings.passwordPlaceholderText
			placeholderTextColor : Fonts.placeholderTextColor
			echoMode             : TextInput.Password
			passwordCharacter    : Strings.passwordCharacter
		}
	}
}
