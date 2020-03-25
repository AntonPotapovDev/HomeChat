import QtQuick 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls/"

Rectangle 
{
	id    : root
	color : Colors.background
	
	property var serverAPI

	function login() {
		if (!email_field.acceptableInput || !password_field.acceptableInput)
			return

		var info = {
			email: email_field.text,
			password: password_field.text
		}
		serverAPI.login(resp => process_error(resp.login_status), info)
	}

	function process_error(error_code) {
		var text = ''
		switch(error_code) {
			case 0: break
			case 1: text = Strings.noSuchUserError
					break
			case 2: text = Strings.badPasswordError
					break
			default: return
		}
		error_text.text = text
	}

	Column 
	{
		anchors.horizontalCenter : parent.horizontalCenter
		anchors.verticalCenter   : parent.verticalCenter
		spacing                  : Sizes.mediumMargin

		Text 
		{
			width               : Sizes.customFieldWidth
			text                : Strings.appName
			color               : Colors.ownMessageColor
			font.family         : Fonts.textFont
			font.pointSize      : Fonts.extraLargePointSize
			verticalAlignment   : Text.AlignVCenter
			horizontalAlignment : Text.AlignHCenter
		}

		CustomField 
		{
			id              : email_field
			width           : Sizes.customFieldWidth
			height          : Sizes.customFieldHeight
			focus           : true
			placeholderText : Strings.emailPlaceholderText
			validator: RegularExpressionValidator
			{
				regularExpression : /\w+@\w+\.\w+/
			}

			Keys.onReturnPressed : password_field.forceActiveFocus()
		}

		CustomField 
		{
			id                   : password_field
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

			Keys.onReturnPressed : root.login()
		}

		CustomButton 
		{
			width       : Sizes.customFieldWidth
			height      : Sizes.customFieldHeight
			backColor   : Colors.ownMessageColor
			hoverColor  : Colors.ownMessageHoverColor
			text        : Strings.loginText
			focusPolicy : Qt.NoFocus

			onClicked : root.login()
		}

		Text 
		{
			id                  : error_text
			width               : Sizes.customFieldWidth
			color               : Fonts.errorTextColor
			font.family         : Fonts.textFont
			font.pointSize      : Fonts.smallPointSize
			verticalAlignment   : Text.AlignVCenter
			horizontalAlignment : Text.AlignHCenter
		}
	}
}
