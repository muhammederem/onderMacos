import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onder2020/models/connection_model.dart';

class ConnectionWidget extends StatefulWidget {
  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = Set();
    return FutureBuilder(
        future: fetchConnection(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? (Builder(builder: (BuildContext context) {
                  for (int i = 0; i < snapshot.data.length; i++) {
                    var data = snapshot.data[i].location.split('#');
                    Marker resultMarker = Marker(
                      markerId: MarkerId((snapshot.data[i].order.toString())),
                      infoWindow: InfoWindow(title: snapshot.data[i].name),
                      position:
                          LatLng(double.parse(data[0]), double.parse(data[1])),
                    );
                    markers.add(resultMarker);
                  }

                  return (Column(
                    children: <Widget>[
                      Container(
                          height: 300,
                          width: double.maxFinite,
                          child: GoogleMap(
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(41.0082376, 28.9783589),
                                zoom: 9.0),
                            markers: markers,
                            gestureRecognizers:
                                <Factory<OneSequenceGestureRecognizer>>[
                              new Factory<OneSequenceGestureRecognizer>(
                                () => new EagerGestureRecognizer(),
                              ),
                            ].toSet(),
                          )),
                      Container(
                          height: 400,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                  child: Text(
                                                      snapshot
                                                          .data[position].name,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      softWrap: true)),
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10)),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.location_city),
                                              Flexible(
                                                child: Text(
                                                    snapshot
                                                        .data[position].adress,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    softWrap: true),
                                              )
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10)),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.phone),
                                              Flexible(
                                                  child: Text(
                                                snapshot.data[position].gsm,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.start,
                                                softWrap: true,
                                              )),
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10)),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.web),
                                              Flexible(
                                                  child: Text(
                                                      snapshot
                                                          .data[position].email,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      softWrap: true)),
                                            ],
                                          ),
                                        ],
                                      )),
                                );
                              }))
                    ],
                  ));
                }))
              : Center(child: CircularProgressIndicator());
        });
  }
}
