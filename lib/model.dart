class Album{
  final List<Features> features;

  Album({this.features});

  factory Album.fromJson(Map<String, dynamic> json){
    var list = json['features'] as List;
    List<Features> featuresList = list.map((i) => Features.fromJson(i)).toList();

  return Album(
    features: featuresList
  );
}
}

class Features {
  Geometry geometry;
  Properties properties;

  Features({this.properties,this.geometry});
  
factory Features.fromJson(Map<String, dynamic> json){
 return Features(
   geometry: Geometry.fromJson(json['geometry']),
   properties: Properties.fromJson(json['properties'])
 );
}
}   

class Properties {
  String mag;
  String place;

  Properties({this.mag,this.place});

  factory Properties.fromJson(Map<String, dynamic> json){
    return new Properties(
      mag: json['mag'].toString(),
      place:json['place']
    );
  }

}

class Geometry{
  String type;
  List<double> coordinates;

  Geometry({this.type,this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json){
    var coordinatesFromJson = json['coordinates'];
    List<double> coordinatesList = coordinatesFromJson.cast<double>();

  return new Geometry(
    type: json['type'],
    coordinates: coordinatesList
  );
}
}