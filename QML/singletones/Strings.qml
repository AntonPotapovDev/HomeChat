pragma Singleton
import QtQuick 2.14

QtObject 
{
	property string appName : 'Home Chat'

	property string sendButtonText    : 'Send'
	property string attachButtonText  : 'Add'

	property string passwordCharacter       : '*'
	property string emailPlaceholderText    : 'Email: email@address.com'
	property string passwordPlaceholderText : 'Password'
	property string loginText               : 'Sign In'

	property string noSuchUserError  : 'Could not find such user'
	property string badPasswordError : 'Invalid email or password'
}
