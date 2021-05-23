import 'dart:convert';
import 'package:FootballHighlightsApp/model/match.dart';
import 'package:FootballHighlightsApp/screens/video_screen.dart';
import 'package:FootballHighlightsApp/util/data.dart';
import 'package:FootballHighlightsApp/widgets/overall_widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';
import 'package:FootballHighlightsApp/model/video.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const String routeName= '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BannerAd myBannerAd;
  List<Match> matches = new List();
  bool isLoading = true;
  bool hasError = false;

  BannerAd biuldBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-8107971978330636/9688006341',
      // adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded) {
          myBannerAd..show();
        }
        print("BannerAd $event");
      },
    );
  }

  Future<void> getMatchData() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    isLoading = true;
    hasError = false;
    setState(() {
      matches = [];
      cacheMatches.clear();
        });
    if(connectivityResult != ConnectivityResult.none && matches.length == 0){
      matches.clear();
      cacheMatches.clear();
      await http.get('https://www.scorebat.com/video-api/v1/').then(
        (value){
          dynamic jsonData = jsonDecode(value.body);
          jsonData.forEach(
            (value){
              Match newMatch = new Match();
              newMatch = Match.fromMap(value);
              setState(() {
                matches.add(newMatch);
                cacheMatches.add(newMatch);
              });
            }
          );
        }
      ).catchError((error){
        setState(() {
            hasError = true;
          });
        print(error);
      });
      setState(() {
            isLoading = false;
            hasError = false;
          });
    }else{
      if(matches.length == 0){
        setState((){
          hasError = true;
        });
      }
    }
  }

  covertDynamicToVideo(List<dynamic> dynamicList){
    List<Video> videoList = [];
    dynamicList.forEach(
      (value){
        Video newVideo = new Video();
        newVideo = Video.fromMap(value);
        videoList.add(newVideo);
      }
    );
    return videoList;
  }

  @override
  void initState() { 
    FirebaseAdMob.instance.initialize(
        appId: 'ca-app-pub-8107971978330636~3314169680');
    myBannerAd = biuldBannerAd()
      ..load();
    super.initState();
    if(cacheMatches.length == 0){
      getMatchData();
    }else{
       setState(() {
        matches.clear();
        matches = cacheMatches;
        isLoading = false;
        hasError = false;
      });
    }
  }

  @override
  void dispose() { 
    myBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: mainAppBar(),
         drawer: drawerWidget(context),
       body: Container(
         decoration: BoxDecoration(
           color: Color(0xfffbf9f9),
           borderRadius: BorderRadius.vertical(top: Radius.circular(20),)
         ),
         padding: EdgeInsets.symmetric(horizontal: 10),
         child: hasError ? 
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Failed to load Data !',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20),
                  FlatButton(
                    color: Colors.green[300],
                  onPressed: ()=> getMatchData(),
                  child: Text('Tap to retry'),
                  ),
                ]
              ),
            ),
              ):
          isLoading ?
            Center( child: CircularProgressIndicator(),) :
            RefreshIndicator(
              onRefresh: getMatchData,
              child: GroupedListView<dynamic, String>( 
                    elements: matches, 
                    groupBy: (element) => element.date.substring(0, 10), 
                    groupComparator: (value1, value2) => value2.compareTo(value1), 
                    itemComparator: (item1, item2) => 
                        item1.title.compareTo(item2.title), 
                    order: GroupedListOrder.ASC, 
                    useStickyGroupSeparators: true, 
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.all(8.0), 
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 100),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xffed5565),
                        ),
                        child: Text( 
                          value, 
                          textAlign: TextAlign.center, 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
                          ),
                      ), 
                      ),

                    itemBuilder: (context, element) { 
                    return GestureDetector(
                      onTap: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VideoScreen(videos: covertDynamicToVideo(element.video),statUrl: element.url,)),
                          ),
                      },
                      child: Card( 
                        elevation: 8.0, 
                        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), 
                        child: ListTile( 
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), 
                          title: Text(element.title.toString().toUpperCase(), 
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),
                                ), 
                          subtitle: Text(element.competition.name,
                                textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey[400])),
                        ), 
                      ),
                    ); 
                },  
              ),
            ), 

       ),
    );
  }
}