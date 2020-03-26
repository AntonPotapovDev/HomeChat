import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14
import HomeChat 1.0

Button
{	
	id           : root
	hoverEnabled : true

	property string iconSource
	property color color
	property color hoverColor

	contentItem: Item
	{
		id : content

		Image
		{
			id                : svg
			anchors.fill      : parent
			source            : root.iconSource
			sourceSize.width  : width
			sourceSize.height : height
		}

		ColorOverlay 
		{
			id           : overlay
			anchors.fill : svg
			source       : svg
			color        : root.color
		}
	}

	background: Item{}

	states: State 
	{
		name : 'hovered'
		when : root.hovered

		PropertyChanges 
		{
			target : overlay
			color  : root.hoverColor
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
