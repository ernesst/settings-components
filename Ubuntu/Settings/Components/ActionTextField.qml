/*
 * Copyright 2013 Canonical Ltd.
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
 * Authors:
 *      Renato Araujo Oliveira Filho <renato@canonical.com>
 *      Olivier Tilloy <olivier.tilloy@canonical.com>
 */

import QtQuick 2.0
import Ubuntu.Components 1.1
import QtQuick.Layouts 1.1

Item {
    id: textField
    property alias text: replyField.text
    property alias buttonText: sendButton.text
    property bool activateEnabled: false

    signal activated(var value)

    implicitHeight: layout.implicitHeight

    RowLayout {
        id: layout
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: units.gu(1)

        TextField {
            id: replyField
            objectName: "replyText"

            placeholderText: i18n.tr("Reply")
            hasClearButton: false

            Layout.fillWidth: true

            onEnabledChanged: {
                //Make sure that the component lost focus when enabled = false,
                //otherwise it will get focus again when enable = true
                if (!enabled) {
                    focus = false;
                }
            }
        }

        Button {
            id: sendButton
            objectName: "sendButton"
            Layout.preferredWidth: units.gu(9)
            enabled: replyField.text !== "" && textField.activateEnabled
            color: UbuntuColors.green

            onClicked: {
                textField.activated(replyField.text);
            }
        }
    }
}
