import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import HomeChat 1.0

Item 
{
	id:  root

	property alias text : textArea.text

	signal sending
	signal attach

	onFocusChanged : if (focus) textArea.forceActiveFocus()

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
				color        : Colors.uiElement
				radius       : Sizes.roundingRadius
				z            : 1

				ScrollView 
				{
					anchors.fill : parent

					TextArea  
					{
						id               : textArea
						padding          : Sizes.midPadding
						font.family      : Fonts.textFont
						font.pointSize   : Fonts.smallPointSize
						placeholderText  : Strings.messageBarPlaceholderText
						color            : Fonts.textColor
						placeholderTextColor : Fonts.placeholderTextColor
						wrapMode         : TextEdit.Wrap
						selectByKeyboard : true
						selectByMouse    : true 
						focus            : true

						Keys.onReturnPressed:
						{
							if (event.modifiers & Qt.ControlModifier)
								insert(text.length, '\n')
							else
								root.sending()
						}
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
				color          : Colors.uiElement
			}
		}

		Rectangle 
		{
			id                    : centerRec
			Layout.preferredWidth : Sizes.messageBarButtonWidth
			Layout.fillHeight     : true
			color                 : Colors.uiElement
			visible               : false // TODO: enable when this feature will be done

			Text 
			{
				anchors.fill        : parent
				text                : Strings.attachButtonText
				color               : Fonts.textColor
				font.family         : Fonts.textFont
				font.pointSize      : Fonts.largePointSize
				verticalAlignment   : Text.AlignVCenter
				horizontalAlignment : Text.AlignHCenter
			}

			MouseArea 
			{
				id: centerMouseArea
				anchors.fill : parent
				hoverEnabled: true
				onClicked : root.attach()
			}

			states: State 
			{
				name: 'hovered'
				when: centerMouseArea.containsMouse

				PropertyChanges 
				{
					target   : centerRec
					color    : Colors.hoveredUiElement
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

		Item 
		{
			id                    : rightRec
			Layout.preferredWidth : Sizes.messageBarButtonWidth
			Layout.fillHeight     : true

			property color color  : Colors.uiElement
			
			MouseArea 
			{
				id           : rightMouseArea
				anchors.fill : parent
				hoverEnabled : true
				onClicked    : root.sending()
			}

			states: State 
			{
				name : 'hovered'
				when : rightMouseArea.containsMouse

				PropertyChanges 
				{
					target   : rightRec
					color    : Colors.hoveredUiElement
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

			Rectangle
			{
				id           : rightRoundRect
				anchors.fill : parent
				color        : rightRec.color
				radius       : Sizes.roundingRadius
				z            : 1

				Text 
				{
					anchors.fill        : parent
					text                : Strings.sendButtonText
					color               : Fonts.textColor
					font.family         : Fonts.textFont
					font.pointSize      : Fonts.largePointSize
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

