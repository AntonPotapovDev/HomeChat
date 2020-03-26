pragma Singleton
import QtQuick 2.14

QtObject
{
	property color background       : '#404040'
	property color uiElement        : '#262626'
	property color hoveredUiElement : '#1a1a1a'

	property color ownMessageColor      : '#4285bd'
	property color ownMessageHoverColor : '#4992c5'
	property color otherMessageColor    : '#191919'

	property color iconColor        : uiElement
	property color hoveredIconCOlor : hoveredUiElement
}
