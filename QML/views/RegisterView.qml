import QtQuick 2.14
import HomeChat 1.0

import "../controls/"

Rectangle 
{
	id    : root
	color : Colors.background

	property var serverAPI

	signal successfullRegistered(string email, string name)
	signal back()

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
			case 0: successfullRegistered(email_field.text, user_name_field.text)
					break
			case 1: text = Strings.emailAreadyUsedError
					break
			case 2: text = Strings.noAccessError
					break
			default: return
		}
		error_text.text = text
	}

	function validate_input() {
		if (!email_field.acceptableInput) {
			error_text.text = Strings.incorrectEmailError
			return false
		}
		if (!access_code_field.acceptableInput) {
			error_text.text = Strings.incorrectCodeError
			return false
		}
		if (user_name_field.text.length == 0) {
			error_text.text = Strings.emptyNameError
			return false
		}
		if (!password_field.acceptableInput) {
			error_text.text = Strings.incorrectPasswordError
			return false
		}
		if (confirm_password_field.text != password_field.text) {
			error_text.text = Strings.passwordsNotMatchError
			return false
		}
		error_text.text = ''
		return true
	}

	IconButton
	{
		anchors.left : root.left
		anchors.top  : root.top
		width        : Sizes.backButtonWidth
		height       : Sizes.backButtonHeight
		symbol       : '<' //TODO: do not forget to change symbol to svg
		iconSize     : Fonts.largePointSize
		onClicked    : root.back()
	}

	Column 
	{
		anchors.horizontalCenter : parent.horizontalCenter
		anchors.verticalCenter   : parent.verticalCenter
		spacing                  : Sizes.mediumMargin

		Text 
		{
			width               : Sizes.customFieldWidth
			text                : Strings.registerViewLabel
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
			placeholderText      : Strings.accessCodePlaceholderText
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
			placeholderText      : Strings.namePlaceholderText
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
			placeholderText      : Strings.confirmPasswordPlaceholderText
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
			text        : Strings.registerViewLabel
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
