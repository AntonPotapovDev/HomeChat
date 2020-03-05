import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item 
{
	id:  root

	RowLayout 
	{
		anchors.fill: parent
		spacing : 1

		Item 
		{
			Layout.fillWidth : true
			Layout.fillHeight : true

			Rectangle
			{
				id : leftRoundRect
				anchors.fill : parent
				color: 'white'
				radius: 20
				z: 1

				ScrollView 
				{
					anchors.fill: parent

					TextArea  
					{
						padding : 10
						font.family : 'Arial'
						font.pixelSize : 30
						wrapMode : TextEdit.Wrap
						focus: true
						selectByKeyboard : true
						selectByMouse : true 
					}
				}
			}

			Rectangle 
			{
				id : leftSqrRect
				color: 'white'
				width: leftRoundRect.radius
				anchors.bottom : leftRoundRect.bottom
				anchors.top : leftRoundRect.top
				anchors.right : leftRoundRect.right
			}
		}

		Rectangle 
		{
			id: centerRec
			Layout.preferredWidth: 100
			Layout.fillHeight : true
			color: 'white'

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
					color    : '#dde4eb'
				}
			}

			transitions: Transition		
			{
				to : 'hovered'
				reversible: true
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
			id: rightRec
			Layout.preferredWidth: 100
			Layout.fillHeight : true

			property color color: 'white'
			
			MouseArea 
			{
				id: rightMouseArea
				anchors.fill : parent
				hoverEnabled: true
			}

			states: State 
			{
				name: 'hovered'
				when: rightMouseArea.containsMouse

				PropertyChanges 
				{
					target   : rightRec
					explicit : true
					color    : '#dde4eb'
				}
			}

			transitions: Transition		
			{
				to : 'hovered'
				reversible: true
				PropertyAnimation 
				{ 
					properties  : 'color'
					duration    : 100
					easing.type : Easing.InOutQuad 
				}
			}

			Rectangle
			{
				id : rightRoundRect
				anchors.fill : parent
				color: rightRec.color
				radius: 20
				z : 1

				Text 
				{
					anchors.fill : parent
					text: 'Send'
					color : 'black'
					font.family : 'Arial'
					font.pixelSize : 35
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
				}
			}

			Rectangle 
			{
				id : rightSqrRect
				color: rightRec.color
				width: rightRoundRect.radius
				anchors.bottom : rightRoundRect.bottom
				anchors.top : rightRoundRect.top
				anchors.left : rightRoundRect.left
			}
		}
	}
}

