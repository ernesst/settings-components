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
 * Authored by Andrea Cimitan <andrea.cimitan@canonical.com>
 */

import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Settings.Menus 0.1

MainView {
    // Note! applicationName needs to match the .desktop filename
    applicationName: "SettingsComponents"

    width: units.gu(42)
    height: units.gu(75)

    ListModel {
        id: mediaPlayerModel
        ListElement { song: "Mine"; artist: "Taylor Swift"; album: "Speak Now"; albumArt: "tests/artwork/speak-now.jpg"}
        ListElement { song: "Stony Ground"; artist: "Richard Thompson"; album: "Electric"; albumArt: "tests/artwork/electric.jpg"}
        ListElement { song: "Los Robots"; artist: "Kraftwerk"; album: "The Man-Machine"; albumArt: "tests/artwork/the-man-machine.jpg"}
    }

    ListModel {
        id: timeZoneModel
        ListElement { city: "San Francisco"; time: "3:00am" }
        ListElement { city: "London"; time: "11:00am" }
        ListElement { city: "Rome"; time: "12:00am" }
    }

    ListModel {
        id: eventModel
        ListElement { eventColor: "yellow"; name: "Lunch with Lola"; description: "Some nice Thai food in the bay area"; date: "1:10 PM" }
        ListElement { eventColor: "green"; name: "Gym"; description: "Workout with John"; date: "6:30 PM" }
        ListElement { eventColor: "red"; name: "Birthday Party"; description: "Don't forget your present!"; date: "9:00 PM" }
    }

    Page {
        title: "SettingsComponents"

        Flickable {
            id: flickable

            anchors.fill: parent
            contentWidth: column.width
            contentHeight: column.height

            Column {
                id: column

                width: flickable.width
                height: childrenRect.height

                SliderMenu {
                    id: slider
                    text: i18n.tr("Slider")
                    minimumValue: 0
                    maximumValue: 100
                    value: 20
                }

                ProgressBarMenu {
                    text: i18n.tr("ProgressBar")
                    value: slider.value
                    minimumValue: 0
                    maximumValue: 100
                }

                ProgressValueMenu {
                    text: i18n.tr("ProgressValue")
                    value: slider.value
                }

                ButtonMenu {
                    text: i18n.tr("Button")
                    buttonText: i18n.tr("Hello world!")
                }

                CheckableMenu {
                    text: i18n.tr("Checkable")
                    checked: true
                }

                SwitchMenu {
                    text: i18n.tr("Switch")
                    checked: true
                }

                SectionMenu {
                    text: i18n.tr("Section Starts Here")
                    busy: true
                }

                SeparatorMenu {}

                CalendarMenu {
                    id: calendar
//                    currentDate: new Date(2013, 6, 2) // june 2013
//                    minimumDate: new Date(2013, 4, 2) // april 2013
//                    maximumDate: new Date(2013, 7, 2) // july 2013
                }

                UserSessionMenu {
                    name: i18n.tr("Lola Chang")
                    icon: Qt.resolvedUrl("tests/artwork/avatar.png")
                    active: true
                }

                MediaPlayerMenu {
                    id: mediaPlayer
                    property int index: 0

                    playerName: "Rhythmbox"
                    playerIcon: Qt.resolvedUrl("tests/artwork/rhythmbox.png")
                    song: mediaPlayerModel.get(index).song;
                    artist: mediaPlayerModel.get(index).artist;
                    album: mediaPlayerModel.get(index).album;
                    albumArt: mediaPlayerModel.get(index).albumArt;
                }

                PlaybackItemMenu {
                    canPlay: true
                    canGoNext: true
                    canGoPrevious: true
                    playing: mediaPlayer.running

                    onPrevious: mediaPlayer.index = Math.max(mediaPlayer.index - 1, 0)
                    onNext: mediaPlayer.index = Math.min(mediaPlayer.index + 1, mediaPlayerModel.count - 1)
                    onPlay: { mediaPlayer.running = !mediaPlayer.running; }
                }

                AccessPointMenu {
                    checked: true
                    secure: true
                    adHoc: false
                    signalStrength: 50
                    text: "Access Point"
                }

                GroupedMessageMenu {
                    title: "Group Message"
                    count: "4"
                }

                SnapDecisionMenu {
                    title: "Snap Decision"
                    time: "10:30am"
                    message: "My mother says I'm handsome!"

                    replyMessages: ["Yeah right", "Sure she did"]

                    onTriggered: {
                        selected = !selected;
                    }
                }

                SimpleTextMessageMenu {
                    title: "Simple Text Message"
                    time: "11am"
                    message: "I am a little teacup"

                    onTriggered: {
                        selected = !selected;
                    }
                }

                TextMessageMenu {
                    title: "Text Message"
                    time: "11am"
                    message: "I happen to be tall and thin!"

                    onTriggered: {
                        selected = !selected;
                    }
                }

                Column {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    Repeater {
                        model: timeZoneModel

                        TimeZoneMenu {
                            city: model.city
                            time: model.time
                        }
                    }
                }

                Column {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    Repeater {
                        model: eventModel

                        EventMenu {
                            name: model.name
                            description: model.description
                            eventColor: model.eventColor
                            date: model.date
                        }
                    }
                }
            }
        }
    }
}