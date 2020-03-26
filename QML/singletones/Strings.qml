pragma Singleton
import QtQuick 2.14

QtObject 
{
	property string appName : 'Home Chat'

	property string sendButtonText    : '>'
	property string attachButtonText  : '+'
	property string messageBarPlaceholderText : 'Type message here'

	property string passwordCharacter       : '*'
	property string emailPlaceholderText    : 'Email: email@address.com'
	property string passwordPlaceholderText : 'Password'
	property string loginText               : 'Sign In'
	property string joinLinkText            : 'Or <a href="http://">join</a>'

	property string noSuchUserError  : 'Could not find such user'
	property string badPasswordError : 'Invalid email or password'

	property string registerViewLabel         : 'Register'
	property string accessCodePlaceholderText : 'Access code from email'
	property string namePlaceholderText       : 'Your name'
	property string confirmPasswordPlaceholderText : 'Confirm passoword'

	property string emailAreadyUsedError : 'This email address is already registered'
	property string noAccessError        : 'This email address is not registered in the system or access code is incorrect'
	property string incorrectEmailError  : 'This email address is incorrect'
	property string incorrectCodeError   : 'Access code is an 8 digits number, please, check your email box'
	property string emptyNameError       : 'Your name should not be empty'
	property string incorrectPasswordError  : 'Password is an 8-16 symbols string, consist of latin characters, numbers and \'_\''
	property string passwordsNotMatchError  : 'Passwords are not match'
}
