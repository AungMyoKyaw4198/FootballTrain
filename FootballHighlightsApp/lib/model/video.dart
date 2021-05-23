class Video{
  String title;
  String embed;

  Video({this.title,this.embed});

  factory Video.fromMap(Map<String, dynamic> jsonData){
    return Video(
      title: jsonData['title'],
      embed: jsonData['embed'],
      );
  }
}