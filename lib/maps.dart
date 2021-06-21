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
  // var loading = false;  
  // List<double> latitude = [];
  // List<double> longitude = [];
  // BitmapDescriptor pinRed, pinGreen, pinOrange, pin;

  @override
  void initState(){
    super.initState();
    // loading = true;
    loadData();
  }

   loadData() async{
        
        // pinRed = await BitmapDescriptor.fromAssetImage(
        // ImageConfiguration(devicePixelRatio: 5.0),
        // 'assets/red.png');
        // pinOrange = await BitmapDescriptor.fromAssetImage(
        //     ImageConfiguration(devicePixelRatio: 5.0),
        //     'assets/orange.png');
        // pinGreen = await BitmapDescriptor.fromAssetImage(
        //     ImageConfiguration(devicePixelRatio: 5.0),
        //     'assets/green.png');

        var response = await http.get(url,headers: {"Accept":"application/json"});

        if(response.statusCode == 200){
          String responseBody = response.body;
          var jsonBody = json.decode(responseBody);
          Album album = new Album.fromJson(jsonBody);
         
    
          setState(() {
            
          });

              for(var i = 0; i < album.features.length; i++){
              //   double mag = double.parse(album.features[i].properties.mag);
              //   if(mag <= 3.0){
              //     pin = pinGreen;
              //   }
              //   else if (mag > 3.0 && mag <= 5.0) {
              //     pin = pinOrange;
              //   } else {
              //     pin = pinRed;
              //   }


                // longitude.add(album.features[i].geometry.coordinates[0]);
                // latitude.add(album.features[i].geometry.coordinates[1]);
                _markers.add(Marker(
                  markerId: MarkerId(album.features[i].properties.place),
                  draggable: true,
                  onTap: (){
                    print("Marker Tapped");
                  },
                  position: LatLng(album.features[i].geometry.coordinates[1], album.features[i].geometry.coordinates[0]),
                  infoWindow: InfoWindow(title:album.features[i].properties.place, snippet: album.features[i].properties.mag),
                ));  
                  
              }
          // print(album.features.length);
      
        }
        else{
          print("Fail");
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