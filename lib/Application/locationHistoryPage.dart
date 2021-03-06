import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:utmccta/DLL/locationEntryDA.dart';
import 'package:utmccta/Application/helpers/locationHistoryMapper.dart';

class LocationHistoryPage extends StatefulWidget {
  @override
  _LocationHistoryPageState createState() => _LocationHistoryPageState();
}

class _LocationHistoryPageState extends State<LocationHistoryPage> {
  LocationEntryDA _entryDA = new LocationEntryDA();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _entryDA.getUserLocationEntryData().snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.data.data()['locationEntry']);
          if (snapshot.data != null) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("No Connections");
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                return snapshot.data.data() != null
                    ? Timeline.tileBuilder(
                        builder: TimelineTileBuilder.connected(
                          indicatorBuilder: (context, index) {
                            return OutlinedDotIndicator(
                              color: Theme.of(context).accentColor,
                              //Color(0xff6ad192) :
                              backgroundColor: Color(0xffc2c5c9),
                              //Color(0xffd4f5d6) :
                              borderWidth: 3,
                            );
                          },
                          connectorBuilder: (context, index, connectorType) {
                            return SolidLineConnector(
                              color: Theme.of(context).accentColor,
                              thickness: 5.0,
                            );
                          },
                          contentsAlign: ContentsAlign.alternating,
                          contentsBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: LocationHistoryMapper(
                                snapshot.data.data()['locationEntry'][index]
                                    ['locationName'],
                                snapshot.data.data()['locationEntry'][index]
                                    ['visitDate']),
                          ),
                          itemCount:
                              snapshot.data.data()['locationEntry'].length,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: AssetImage(
                                  'assets/img/locationHistoryNull.png')),
                          Text(
                            "No Location History Yet!",
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      );
              default:
                break;
            }
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              color: Colors.black,
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
