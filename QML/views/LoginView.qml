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
			width               : Sizes.customFieldWidth
			text                : Strings.loginText
			color               : Fonts.textColor 
			font.family         : Fonts.textFont
			font.pointSize      : Fonts.largePointSize
			verticalAlignment   : Text.AlignVCenter
			horizontalAlignment : Text.AlignHCenter
		}

		CustomField 
		{
			width           : Sizes.customFieldWidth
			height          : Sizes.customFieldHeight
			focus           : true
			placeholderText : Strings.emailPlaceholderText
			validator: RegularExpressionValidator
			{
				regularExpression : /\w+@\w+\.\w+/
			}
		}

		CustomField 
		{
			width                : Sizes.customFieldWidth
			height               : Sizes.customFieldHeight
			placeholderText      : Strings.passwordPlaceholderText
			placeholderTextColor : Fonts.placeholderTextColor
			echoMode             : TextInput.Password
			passwordCharacter    : Strings.passwordCharacter
			validator: RegularExpressionValidator
			{
				regularExpression : /\w+/
			}
		}
	}
}
