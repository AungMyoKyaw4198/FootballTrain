class Competition{
  String name;
  String url;

  Competition({this.name,this.url});

  factory Competition.fromMap(Map<String, dynamic> jsonData){
    return Competition(
      name: jsonData['name'],
      url: jsonData['url'],
    );
  }
}