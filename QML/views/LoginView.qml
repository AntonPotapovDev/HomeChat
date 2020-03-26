import QtQuick 2.14
import HomeChat 1.0

import "../controls/"

Rectangle 
{
	id    : root
	color : Colors.background
	
	property var serverAPI

	signal successfullAutorized(string email, string name)
	signal join()

	function login() {
		if (!validate_input())
			return

		var info = {
			email: email_field.text,
			password: password_field.text
		}
		serverAPI.login(process_response, info)
	}

	function process_response(response) {
		var text = ''
		switch(response.login_status) {
			case 0: root.successfullAutorized(email_field.text, response.user_name)
					break
			case 1: text = Strings.noSuchUserError
					break
			case 2: text = Strings.badPasswordError
					break
			default: return
		}
		error_text.text = text
	}

	function validate_input() {
		if (!email_field.acceptableInput || !password_field.acceptableInput) {
			error_text.text = Strings.invalidPasswordOrEmail
			return false
		}
		error_text.text = ''
		return true
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
			text : 'protestandprotect52@gmail.com'
			placeholderText : Strings.emailPlaceholderText
			validator: RegularExpressionValidator
			{
				regularExpression : /\w+@\w+\.\w+/
			}

			Keys.onReturnPressed : password_field.forceActiveFocus()
			Component.onCompleted : forceActiveFocus()
		}

		CustomField 
		{
			id                   : password_field
			width                : Sizes.customFieldWidth
			height               : Sizes.customFieldHeight
			text: '11121998q'
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
			id                  : join_link
			width               : Sizes.customFieldWidth
			textFormat          : Text.StyledText 
			text                : Strings.joinLinkText
			color               : Fonts.textColor
			linkColor           : Colors.ownMessageColor
			font.family         : Fonts.textFont
			font.pointSize      : Fonts.smallPointSize
			verticalAlignment   : Text.AlignVCenter
			horizontalAlignment : Text.AlignHCenter

			onLinkActivated: root.join()
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
