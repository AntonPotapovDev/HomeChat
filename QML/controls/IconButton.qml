import QtQuick 2.14
import QtQuick.Controls 2.14
import HomeChat 1.0

Button
{	
	id           : root
	hoverEnabled : true

	property string symbol : ''
	property int iconSize  : 0 

	contentItem: Text 
	{
		id                  : pseudo_icon
		anchors.fill        : parent
		text                : root.symbol
		font.family         : Fonts.textFont
		font.pointSize      : root.iconSize
		color               : Colors.iconColor 
		horizontalAlignment : Text.AlignHCenter
		verticalAlignment   : Text.AlignVCenter
	}

	background: Item{}

	states: State 
	{
		name : 'hovered'
		when : root.hovered

		PropertyChanges 
		{
			target : pseudo_icon
			color  : Colors.hoveredIconCOlor
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
