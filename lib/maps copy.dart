import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geosafe/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class googleMaps extends StatefulWidget{  
  @override
  googleMapsState createState() => googleMapsState();
}

class googleMapsState extends State<googleMaps>{
  String url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_day.geojson";
  List<Marker> _markers = [];

  @override
  void initState(){
    super.initState();
    loadData();
  }

    loadData() async{
        
        var response = await http.get(url,headers: {"Accept":"application/json"});

        if(response.statusCode == 200){
          String responseBody = response.body;
          var jsonBody = json.decode(responseBody);
          Album album = new Album.fromJson(jsonBody);
    
          setState(() {
          });
                _markers.add(Marker(
                  markerId: MarkerId(album.features[i].properties.place),
                  position: LatLng(album.features[i].geometry.coordinates[1], album.features[i].geometry.coordinates[0]),
                  infoWindow: InfoWindow(title:album.features[i].properties.place, snippet: album.features[i].properties.mag),
                ));  
              }
        }
        else{
          print("Fail to Gather Data");
        }
      }

 
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(10.3157, 123.8854);

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }
  
  _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {  
    return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 2.0,
              ),
              mapType: _currentMapType,
              markers: Set.from(_markers),   
              onCameraMove: _onCameraMove,
            );
  }
  
}