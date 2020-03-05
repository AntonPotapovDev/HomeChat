import QtQuick 2.14
import QtQuick.Layouts 1.14

Item 
{
	id:  root

	RowLayout 
	{
		anchors.fill: parent
		spacing : 0

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
			Layout.preferredWidth: 100
			Layout.fillHeight : true
			color: 'white'
		}

		Item 
		{
			Layout.preferredWidth: 100
			Layout.fillHeight : true

			Rectangle
			{
				id : rightRoundRect
				anchors.fill : parent
				color: 'white'
				radius: 20
			}

			Rectangle 
			{
				id : rightSqrRect
				color: 'white'
				width: rightRoundRect.radius
				anchors.bottom : rightRoundRect.bottom
				anchors.top : rightRoundRect.top
				anchors.left : rightRoundRect.left
			}
		}
	}
}

