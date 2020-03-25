pragma Singleton
import QtQuick 2.14

QtObject 
{
	property real appDefaultWidth  : 1000
	property real appDefaultHeight : 600

	property real messageBarHeight      : 100
	property real messageBarButtonWidth : 100

	property real customFieldWidth  : 300
	property real customFieldHeight : 50

	property int smallMargin      : 5
	property int mediumMargin     : 10
	property int largeMargin      : 20
	property int extraLargeMargin : 50

	property int midPadding : 10

	property int roundingRadius     : 20
	property int messageBoxRounding : 10

	property int uiResponseAnimationDuration    : 100
	property int viewSwitchingAnimationDuration : 100
	property int messageFetchingInterval        : 250
}
