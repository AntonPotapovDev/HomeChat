import QtQuick 2.14
import QtQuick.Controls 2.14
import HomeChat 1.0

Button 
{
	id           : root
	hoverEnabled : true

	property color backColor : back.color
	property color hoverColor : backColor

	contentItem: Text 
	{
        text                : root.text
        font.family         : Fonts.textFont
		font.pointSize      : Fonts.mediumPointSize
        color               : Fonts.textColor 
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment   : Text.AlignVCenter
    }

	background: Rectangle 
	{
		id     : back
		color  : root.hovered ? root.hoverColor : root.backColor
		radius : Sizes.roundingRadius
	}

	states: State 
	{
		name: 'hovered'
		when: root.hovered

		PropertyChanges 
		{
			target   : background
			color    : hoverColor
		}
	}

	transitions: Transition		
	{
		to         : 'hovered'
		reversible : true

		PropertyAnimation 
		{ 
			properties  : 'color'
			duration    : Sizes.uiResponseAnimationDuration
			easing.type : Easing.InOutQuad 
		}
	}
}
