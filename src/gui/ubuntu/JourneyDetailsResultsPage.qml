/****************************************************************************
**
**  This file is a part of Fahrplan.
**
**  This program is free software; you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation; either version 2 of the License, or
**  (at your option) any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
**  GNU General Public License for more details.
**
**  You should have received a copy of the GNU General Public License along
**  with this program.  If not, see <http://www.gnu.org/licenses/>.
**
****************************************************************************/

import Fahrplan 1.0
import QtQuick 2.3
import Ubuntu.Components 1.1
import "components"

Page {
    title: qsTr("Result Details")
    id: searchDetailResultsPage

    property alias titleText: journeyStations.text
    property alias subTitleText: lbljourneyDate.text
    property alias subTitleText2: lbljourneyDuration.text
    property alias searchIndicatorVisible: searchIndicator.visible

    property JourneyDetailResultList currentResult;

//    tools: journeyDetailResultsToolbar
    Item {
        id: searchResults

        width:  parent.width
        height: parent.height

        Item {
            id: titleBar

            height: journeyStations.height + journeyDate.height + units.gu(2)
            width: parent.width

            Label {
                id: journeyStations
                text: ""
                fontSize: "medium"
                anchors {
                    left: parent.left
                    leftMargin: units.gu(1)
                    right: parent.right
                    rightMargin: units.gu(1)
                    top: parent.top
                    topMargin: units.gu(1)
                }
                width: parent.width
                elide: Text.ElideRight
            }

            Item {
                id: journeyDate
                anchors {
                    left: parent.left
                    leftMargin: units.gu(1)
                    right: parent.right
                    rightMargin: units.gu(1)
                    top: journeyStations.bottom
                    topMargin: units.gu(1)
                }
                width: parent.width
                height: lbljourneyDate.height

                Label {
                    id: lbljourneyDate
                    anchors {
                        left: parent.left
                        top: parent.top
                    }
                    width: ((parent.width / 3) * 2) - units.gu(2)
                    color: "Grey"
                }

                Label {
                    id: lbljourneyDuration
                    anchors {
                        right: parent.right
                        left: lbljourneyDate.right
                        top: parent.top
                    }
                    width: (parent.width / 3) - units.gu(2)
                    color: "Grey"
                    horizontalAlignment: Text.AlignRight
                }
            }
        }

        ActivityIndicator {
            id: searchIndicator
            anchors {
                top: titleBar.bottom
                topMargin: units.gu(5);
                horizontalCenter: parent.horizontalCenter
            }
            running: true
            visible: false

//            platformStyle: BusyIndicatorStyle { size: "large" }
        }

        ListView {
            id: listView
            anchors {
                top: titleBar.bottom
                topMargin: units.gu(1)
            }
            visible: !searchIndicator.visible
            height: (parent.height - titleBar.height) - units.gu(2)
            width: parent.width
            model: journeyDetailResultModel
            delegate:  journeyDetailResultDelegate
            clip: true
        }

        Scrollbar {
            flickableItem: listView
        }
    }

    Component {
        id: journeyDetailResultDelegate

        Item {
            id: delegateItem
            width: listView.width
            height: isStation ? isTrain ? item_train.height + item_station.height : item_station.height : isTrain ? item_train.height : 0

            Item {
                anchors {
                    verticalCenter: parent.verticalCenter
                }

                width: parent.width
                height: parent.height

                Item {
                     id: item_station

                     visible: isStation
                     height: visible ? lbl_station.height + units.gu(2) : 0

                     width: parent.width

                     Rectangle {
                         anchors {
                             fill: parent
                         }
                         color: "White"
                     }

                     Rectangle {
                         anchors {
                             left: parent.left
                             leftMargin: units.gu(8)
                             top: parent.top
                             topMargin: (isStart) ? parent.height / 2 : 0
                         }
                         color: "#0d70c5"
                         height: (isStart || isStop) ? parent.height / 2  : parent.height
                         width: units.gu(1)
                     }

                     Rectangle {
                         anchors {
                             left: parent.left
                             leftMargin: units.gu(7)
                             verticalCenter: parent.verticalCenter
                         }

                         gradient: Gradient {
                             GradientStop {
                                 position: 0.00;
                                 color: "#0d70c5";
                             }
                             GradientStop {
                                 position: 0.38;
                                 color: "#0d70c5";
                             }
                             GradientStop {
                                 position: 0.39;
                                 color: "White"
                             }
                             GradientStop {
                                 position: 0.50;
                                 color: "White"
                             }
                             GradientStop {
                                 position: 0.61;
                                 color: "White"
                             }
                             GradientStop {
                                 position: 0.62;
                                 color: "#0d70c5";
                             }
                             GradientStop {
                                 position: 1.0;
                                 color: "#0d70c5";
                             }
                         }
                         radius: units.gu(1.5)
                         height: units.gu(3)
                         width: units.gu(3)
                     }

                     Label {
                         anchors {
                             left: parent.left
                             leftMargin: units.gu(1)
                             top: parent.top
                         }

                         text: arrivalTime
                         width: parent.width - units.gu(1)
                     }

                     Label {

                         anchors {
                             left: parent.left
                             leftMargin: units.gu(1)
                             bottom: parent.bottom
                         }

                         text: departureTime
                         width: parent.width - units.gu(1)
                     }

                     Item {
                        id: lbl_station

                        height: lbl_station_name.height + lbl_station_info.height
                        width: (parent.width - units.gu(11))

                        anchors {
                            left: parent.left
                            leftMargin: units.gu(11)
                            verticalCenter: parent.verticalCenter
                        }

                        Label {
                            id: lbl_station_name
                            text: stationName
                            width: parent.width - units.gu(1)
                            wrapMode: Text.WordWrap
                        }

                        Label {

                            anchors {
                                top: lbl_station_name.bottom
                            }
                            color: "DarkGrey"
                            id: lbl_station_info
                            text: stationInfo
                            width: parent.width - units.gu(1)
                            wrapMode: Text.WordWrap
                        }
                     }
                }

                Item {
                    id: item_train

                    anchors {
                        top: item_station.bottom
                    }

                    visible: isTrain
                    height: visible ? lbl_train.height + units.gu(3) : 0

                    width: parent.width

                    Rectangle {
                        anchors {
                            fill: parent
                        }
                        color: "LightGrey"
                    }

                    Rectangle {
                        anchors {
                            left: parent.left
                            leftMargin: units.gu(8)
                        }
                        color: "#0d70c5"
                        height: parent.height
                        width: units.gu(1)
                    }

                    Label {
                        id: lbl_train
                        anchors {
                            left: parent.left
                            leftMargin: units.gu(11)
                            verticalCenter: parent.verticalCenter
                        }
                        text: {
                            var result;
                            if (model.trainDirection.length > 0) {
                                //: As in "%1 in direction %2"
                                result = qsTr("%1 to %2", "Direction")
                                         .arg("<b>" + model.trainName + "</b>")
                                         .arg(model.trainDirection);
                            } else {
                                result = "<b>" + model.trainName + "</b>";
                            }
                            if (model.trainInfo)
                                result += "<br /><i>" + model.trainInfo + "</i>";

                            return result;
                        }
                        width: (parent.width  - units.gu(12))
                        wrapMode: Text.WordWrap
                        onLinkActivated : Qt.openUrlExternally(link)
                    }
                }
            }
        }
    }

    ListModel {
        id: journeyDetailResultModel
    }

    Connections {
        target: fahrplanBackend

        onAddCalendarEntryComplete: {
            // TODO: Make this work once the calendar is accessible on Ubuntu
/*            if (success)
                banner.text = qsTr("Journey has been added to your calendar.");
            else
                banner.text = qsTr("Failed to add Journey to your calendar!");
            banner.show();
            calendarIcon.enabled = true
*/
        }

        onParserJourneyDetailsResult: {
            currentResult = result;
            console.log("Got detail results");
            console.log(result.count);

            if (result.count > 0) {
                journeyStations.text = result.viaStation.length == 0 ? qsTr("<b>%1</b> to <b>%2</b>").arg(result.departureStation).arg(result.arrivalStation) : qsTr("<b>%1</b> via <b>%3</b> to <b>%2</b>").arg(result.departureStation).arg(result.arrivalStation).arg(result.viaStation);
                var departureDate = Qt.formatDate(result.departureDateTime);
                var arrivalDate = Qt.formatDate(result.arrivalDateTime);

                if (departureDate == arrivalDate) {
                    arrivalDate = "";
                }

                lbljourneyDate.text = departureDate + " " + Qt.formatTime(result.departureDateTime, Qt.DefaultLocaleShortDate) + " - " +
                        arrivalDate + " " + Qt.formatTime(result.arrivalDateTime, Qt.DefaultLocaleShortDate);

                lbljourneyDuration.text = qsTr("Dur.: %1").arg(result.duration);

                journeyDetailResultModel.clear();
                for (var i = 0; i < result.count; i++) {
                    var item = result.getItem(i);

                    var nextItem = null;
                    if (i < result.count -1) {
                        nextItem = result.getItem(i+1);
                    }

                    /*
                    console.log("-------------" + i);
                    console.log(item.departureStation);
                    console.log(item.train);
                    console.log(item.arrivalStation);
                    if (nextItem) {
                        console.log(nextItem.departureStation);
                        console.log(nextItem.train);
                        console.log(nextItem.arrivalStation);
                    }
                    */

                    var isStart = (i == 0);
                    var isStop = (i == result.count -1);

                    //Add first departure Station and the train
                    if (isStart) {
                        journeyDetailResultModel.append({
                                                            "isStart" : true,
                                                            "isStop" : false,
                                                            "trainName" : item.train,
                                                            "trainDirection" : item.direction,
                                                            "trainInfo" : item.info,
                                                            "stationName" : item.departureStation,
                                                            "stationInfo" : item.departureInfo,
                                                            "arrivalTime" : "",
                                                            "departureTime" : Qt.formatTime(item.departureDateTime, "hh:mm"),
                                                            "isStation" : true,
                                                            "isTrain" : true

                        });
                    }

                    //Add arrival station
                    if (isStop) {
                        journeyDetailResultModel.append({
                                                            "isStart" : false,
                                                            "isStop" : isStop,
                                                            "trainName" : "",
                                                            "trainDirection": "",
                                                            "trainInfo" : "",
                                                            "stationName" : item.arrivalStation,
                                                            "stationInfo" :  item.arrivalInfo,
                                                            "arrivalTime" :  Qt.formatTime(item.arrivalDateTime, "hh:mm"),
                                                            "departureTime" : "",
                                                            "isStation" : true,
                                                            "isTrain" : false

                        });
                    }

                    //Add one Station
                    if (nextItem) {
                        var stationInfo = item.arrivalInfo;
                        var stationName = item.arrivalStation;

                        if (stationInfo.length > 0 && nextItem.departureInfo) {
                            stationInfo = stationInfo + " / ";
                        }
                        if (nextItem.departureStation != item.arrivalStation) {
                            stationName += " / " + nextItem.departureStation;
                        }

                        stationInfo = stationInfo + nextItem.departureInfo;

                        journeyDetailResultModel.append({
                                                            "isStart" : false,
                                                            "isStop" : false,
                                                            "trainName" :  nextItem.train,
                                                            "trainDirection" : nextItem.direction,
                                                            "trainInfo" : nextItem.info,
                                                            "stationName" : stationName,
                                                            "stationInfo" : stationInfo,
                                                            "arrivalTime" : Qt.formatTime(item.arrivalDateTime, "hh:mm"),
                                                            "departureTime" :  Qt.formatTime(nextItem.departureDateTime, "hh:mm"),
                                                            "isStation" : true,
                                                            "isTrain" : true

                        });
                    }

                }
                searchIndicator.visible = false;
            } else {
                mainStack.pop();
            }
        }
    }

//    ToolBarLayout {
//        id: journeyDetailResultsToolbar

//        ToolIcon {
//            id : backIcon;
//            iconId: "toolbar-back"
//            onClicked: {
//                pageStack.pop();
//            }
//        }

//        ToolIcon {
//            id : calendarIcon
//            iconSource: enabled ? "qrc:/src/gui/harmattan/icon/icon-m-content-calendar" + inverseSuffix + ".svg" : "image://theme/progress_78_01"

//            visible: (!searchIndicator.visible) && (fahrplanBackend.supportsCalendar())

//            onClicked: {
//                calendarIcon.enabled = false
//                fahrplanBackend.addJourneyDetailResultToCalendar(currentResult);
//            }

//            BusyIndicator {
//                visible: !calendarIcon.enabled
//                running: true
//                style: BusyIndicatorStyle { size: "small" }
//                anchors.centerIn: parent
//            }
//        }
//    }
}
