import QtQuick 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

import "../controls/"
import "../JS/net_helper.js" as API

Rectangle 
{
	id    : root
	color : Colors.background

	property var serverAPI : API

	signal successfullRegistered(string email, string password)

	function register() {
		if (!validate_input())
			return
		
		var info = {
			email: email_field.text,
			code: access_code_field.text,
			password: password_field.text,
			name: user_name_field.text
		}
		serverAPI.register(process_response, info)
	}

	function process_response(response) {
		var text = ''
		switch (response.register_status) {
			case 0: successfullRegistered(email_field.text, password_field.text)
					break
			case 1: text = 'This email address is already registered'
					break
			case 2: text = 'This email address is not registered in the system or access code is invalid'
					break
			default: return
		}
		error_text.text = text
	}

	function validate_input() {
		if (!email_field.acceptableInput) {
			error_text.text = 'This email address is incorrect'
			return false
		}
		if (!access_code_field.acceptableInput) {
			error_text.text = 'Access code is an 8 digits number, please, check your email box'
			return false
		}
		if (user_name_field.text.length == 0) {
			error_text.text = 'Your name should not be empty'
			return false
		}
		if (!password_field.acceptableInput) {
			error_text.text = 'Password is an 8-16 symbols string, consist of latin characters, numbers and \'_\''
			return false
		}
		if (confirm_password_field.text != password_field.text) {
			error_text.text = 'Passwords are not match'
			return false
		}
		error_text.text = ''
		return true
	}

	Component.onCompleted : serverAPI.init('192.168.1.5', 8089)

	Column 
	{
		anchors.horizontalCenter : parent.horizontalCenter
		anchors.verticalCenter   : parent.verticalCenter
		spacing                  : Sizes.mediumMargin

		Text 
		{
			width               : Sizes.customFieldWidth
			text                : 'Register'
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

			Keys.onReturnPressed : access_code_field.forceActiveFocus()
			Component.onCompleted : forceActiveFocus()
		}

		CustomField 
		{
			id                   : access_code_field
			width                : Sizes.customFieldWidth
			height               : Sizes.customFieldHeight
			placeholderText      : 'Access code from email'
			placeholderTextColor : Fonts.placeholderTextColor
			validator: RegularExpressionValidator
			{
				regularExpression : /\d{8}/
			}

			Keys.onReturnPressed : user_name_field.forceActiveFocus()
		}

		CustomField 
		{
			id                   : user_name_field
			width                : Sizes.customFieldWidth
			height               : Sizes.customFieldHeight
			placeholderText      : 'Your name'
			placeholderTextColor : Fonts.placeholderTextColor

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
				regularExpression : /\w{8,16}/
			}

			Keys.onReturnPressed : confirm_password_field.forceActiveFocus()
		}

		CustomField 
		{
			id                   : confirm_password_field
			width                : Sizes.customFieldWidth
			height               : Sizes.customFieldHeight
			placeholderText      : 'Confirm passoword'
			placeholderTextColor : Fonts.placeholderTextColor
			echoMode             : TextInput.Password
			passwordCharacter    : Strings.passwordCharacter

			Keys.onReturnPressed : root.register()
		}

		CustomButton 
		{
			width       : Sizes.customFieldWidth
			height      : Sizes.customFieldHeight
			backColor   : Colors.ownMessageColor
			hoverColor  : Colors.ownMessageHoverColor
			text        : 'Register'
			focusPolicy : Qt.NoFocus

			onClicked : root.register()
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
