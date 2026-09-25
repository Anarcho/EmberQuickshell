import QtQuick
import QtQuick.Layouts
import Quickshell
import "Singletons" as T
import "components" as C

PanelWindow {
    id: shell

    property string profileName: "compactPill"
    property var profile: T.SurfaceProfiles.forSurface(profileName)

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: content.implicitHeight + (T.Spacing.sm * 2)

    color: "transparent"

    // Surface Frame
    Rectangle {
        id: surface
        anchors.centerIn: parent

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight
        color: "transparent"

        // PillSurface
        Item {
            id: content
            anchors.fill: parent

            implicitWidth: Math.max(shell.profile.minimumWidth, shell.profile.preferredWidth, layout.implicitWidth + shell.profile.horizontalPadding * 2)
            implicitHeight: shell.profile.height

            C.GlassMaterial {
                active: false
                anchors.fill: parent
                backdropRect: Qt.rect(0, 0, surface.width, surface.height)
                backdropSource: null
                glassAmount: 0.70
                rimWidth: T.SurfaceMetrics.rimWidth
                arcReflections: false
            }

            RowLayout {
                id: layout
                anchors.fill: parent
                anchors.leftMargin: shell.profile.horizontalPadding
                anchors.rightMargin: shell.profile.horizontalPadding
                anchors.topMargin: shell.profile.verticalPadding
                anchors.bottomMargin: shell.profile.verticalPadding

                Layout.preferredHeight: shell.profile.contentHeight
                Layout.preferredWidth: shell.profile.preferredContentWidth

                spacing: T.Spacing.sm

                C.EmberAbstractButton {
                    id: emblemButton

                    Layout.preferredWidth: shell.profile.emblemWidth
                    Layout.preferredHeight: shell.profile.emblemHeight

                    borderColor: emblemButton.visualFocus ? T.Colors.accent : "transparent"
                    borderStrokeWidth: T.Strokes.focus
                    backgroundColor: "transparent"
                    backgroundRadius: Math.min(width, height) / 2

                    contentItem: C.EmberMark {
                        expanded: false
                    }
                }

                C.EmberAbstractButton {
                    id: clockButton
                    Layout.preferredHeight: shell.profile.contentHeight
                    Layout.preferredWidth: shell.profile.clockWidth
                    focusPolicy: Qt.StrongFocus

                    contentItem: Item {
                        C.ClockDisplay {
                            anchors.centerIn: parent
                            dateText: T.Clock.dateLabel
                            timeText: T.Clock.timeLabel
                        }
                    }
                }

                C.Divider {
                    Layout.preferredHeight: shell.profile.dividerHeight
                    Layout.preferredWidth: T.Strokes.hairline
                }

                Item {
                    id: workspace
                    Layout.preferredHeight: shell.profile.contentHeight
                    Layout.preferredWidth: shell.profile.clockWidth

                    ColumnLayout {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            Repeater {
                                model: 4
                                Rectangle {
                                    required property int index

                                    implicitWidth: 12
                                    implicitHeight: 12
                                    radius: T.Radii.pill(height)
                                    color: index === 2 ? T.Colors.accent : "transparent"
                                    border.color: T.Colors.textMuted
                                }
                            }
                        }
                        Text {
                            id: wsName
                            Layout.alignment: Qt.AlignHCenter
                            color: T.Colors.text
                            text: "code"
                        }
                    }
                }
                C.Divider {
                    Layout.preferredHeight: shell.profile.dividerHeight
                    Layout.preferredWidth: T.Strokes.hairline
                }
                C.GlyphButton {
                    accessibilityName: "Wi-Fi"
                }
                C.GlyphButton {
                    accessibilityName: "Audio"
                }
                C.GlyphButton {
                    accessibilityName: "Power"
                }
            }
        }
    }
}
