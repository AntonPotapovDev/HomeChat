import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item 
{
	id:  root

	RowLayout 
	{
		anchors.fill : parent
		spacing      : 1

		Item 
		{
			Layout.fillWidth  : true
			Layout.fillHeight : true

			Rectangle
			{
				id           : leftRoundRect
				anchors.fill : parent
				color        : 'white'
				radius       : 20
				z            : 1

				ScrollView 
				{
					anchors.fill : parent

					TextArea  
					{
						padding          : 10
						font.family      : 'Arial'
						font.pointSize   : 12
						wrapMode         : TextEdit.Wrap
						selectByKeyboard : true
						selectByMouse    : true 
						focus            : true
					}
				}
			}

			Rectangle 
			{
				id             : leftSqrRect
				anchors.bottom : leftRoundRect.bottom
				anchors.top    : leftRoundRect.top
				anchors.right  : leftRoundRect.right
				width          : leftRoundRect.radius
				color          : 'white'
			}
		}

		Rectangle 
		{
			id                    : centerRec
			Layout.preferredWidth : 100
			Layout.fillHeight     : true
			color                 : 'white'

			MouseArea 
			{
				id: centerMouseArea
				anchors.fill : parent
				hoverEnabled: true
			}

			states: State 
			{
				name: 'hovered'
				when: centerMouseArea.containsMouse

				PropertyChanges 
				{
					target   : centerRec
					explicit : true
					color    : '#ededed'
				}
			}

			transitions: Transition		
			{
				to         : 'hovered'
				reversible : true

				PropertyAnimation 
				{ 
					properties  : 'color'
					duration    : 100
					easing.type : Easing.InOutQuad 
				}
			}
		}

		Item 
		{
			id                    : rightRec
			Layout.preferredWidth : 100
			Layout.fillHeight     : true

			property color color  : 'white'
			
			MouseArea 
			{
				id           : rightMouseArea
				anchors.fill : parent
				hoverEnabled : true
			}

			states: State 
			{
				name : 'hovered'
				when : rightMouseArea.containsMouse

				PropertyChanges 
				{
					target   : rightRec
					explicit : true
					color    : '#ededed'
				}
			}

			transitions: Transition		
			{
				to         : 'hovered'
				reversible : true

				PropertyAnimation 
				{ 
					properties  : 'color'
					duration    : 100
					easing.type : Easing.InOutQuad 
				}
			}

			Rectangle
			{
				id           : rightRoundRect
				anchors.fill : parent
				color        : rightRec.color
				radius       : 20
				z            : 1

				Text 
				{
					anchors.fill        : parent
					text                : 'Send'
					color               : 'black'
					font.family         : 'Arial'
					font.pixelSize      : 35
					verticalAlignment   : Text.AlignVCenter
					horizontalAlignment : Text.AlignHCenter
				}
			}

			Rectangle 
			{
				id             : rightSqrRect
				anchors.bottom : rightRoundRect.bottom
				anchors.left   : rightRoundRect.left
				anchors.top    : rightRoundRect.top
				width          : rightRoundRect.radius
				color          : rightRec.color
			}
		}
	}
}

