/*
 * Copyright 2013-2016 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by Nick Dedekind <nick.dedekind@gmail.com>
 *             Marco Trevisan <marco.trevisan@canonical.com>
 */

import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.1

BaseMenu {
    id: menu

    property bool playing: false
    property bool canPlay: false
    property bool canGoNext: false
    property bool canGoPrevious: false

    signal next()
    signal play(bool play)
    signal previous()

    highlightWhenPressed: false
    height: layout.implicitHeight + (divider.visible ? divider.height : 0)

    SlotsLayout {
        id: layout

        RowLayout {
            anchors.centerIn: parent
            spacing: units.gu(3)

            Icon {
                objectName: "previousButton"

                Layout.preferredWidth: units.gu(5)
                Layout.preferredHeight: units.gu(5)

                source: "image://theme/media-skip-backward"
                color: {
                    if (!enabled)
                        return theme.palette.disabled.backgroundText;
                    return prevMA.pressed ? theme.palette.highlighted.backgroundText : theme.palette.normal.backgroundText;
                }
                enabled: canGoPrevious

                MouseArea {
                    id: prevMA
                    anchors.fill: parent
                    onClicked: menu.previous()
                }
            }

            Icon {
                objectName: "playButton"

                Layout.preferredWidth: units.gu(5)
                Layout.preferredHeight: units.gu(5)

                source: playing ? "image://theme/media-playback-pause" : "image://theme/media-playback-start"
                color: {
                    if (!enabled)
                        return theme.palette.disabled.backgroundText;
                    return playMA.pressed ? theme.palette.highlighted.backgroundText : theme.palette.normal.backgroundText;
                }
                enabled: canPlay

                MouseArea {
                    id: playMA
                    anchors.fill: parent
                    onClicked: menu.play(!playing)
                }
            }

            Icon {
                objectName: "nextButton"

                Layout.preferredWidth: units.gu(5)
                Layout.preferredHeight: units.gu(5)

                source: "image://theme/media-skip-forward"
                color: {
                    if (!enabled)
                        return theme.palette.disabled.backgroundText;
                    return nextMA.pressed ? theme.palette.highlighted.backgroundText : theme.palette.normal.backgroundText;
                }
                enabled: canGoNext

                MouseArea {
                    id: nextMA
                    anchors.fill: parent
                    onClicked: menu.next()
                }
            }
        }
    }
}
