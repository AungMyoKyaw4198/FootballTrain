import 'package:FootballHighlightsApp/model/competition.dart';

class Match{
  String title;
  String url;
  String thumbnail;
  String date;
  Competition competition;
  List<dynamic> video;

  Match({this.title,this.url,this.thumbnail,this.date,this.competition,this.video});

  factory Match.fromMap(Map<String, dynamic> jsonData){
    return Match(
      title: jsonData['title'],
      url: jsonData['url'],
      thumbnail: jsonData['thumbnail'],
      date: jsonData['date'],
      competition: Competition.fromMap(jsonData['competition']),
      video: jsonData['videos'],
      );
  }
}