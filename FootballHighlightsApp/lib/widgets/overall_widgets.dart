import 'package:FootballHighlightsApp/model/screen_argument.dart';
import 'package:FootballHighlightsApp/util/routes.dart';
import 'package:flutter/material.dart';

Widget mainAppBar(){
  return AppBar(
        // backgroundColor: Color(0xff01172d),
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.green[300],
        title: Image.asset('assets/logo.png', fit: BoxFit.contain,height: 130,),
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
         elevation: 0.0,
        );
}

Widget drawerWidget(context){
  return Drawer(
          child: Container(
            color: Colors.green[300],
                      child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                   DrawerHeader(
                    margin: EdgeInsets.only(top: 10),
                  child: Text(''),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    image: DecorationImage(
                       image: AssetImage("assets/logo.png"),
                         fit: BoxFit.fitWidth)
                      ),
                  ),
                Divider(color: Color(0xffed5565),),
                drawerListTile(icon: Icons.sports_soccer,name: 'Football Matches', context: context),
                Divider(color: Color(0xffed5565),),
                drawerListTileLeagues(assetName: 'assets/epl.png',name: 'Premier League', context: context,url: 'https://www.scorebat.com/england-premier-league-live-scores/'),
                drawerListTileLeagues(assetName: 'assets/laliga.png',name: 'La Liga', context: context,url: 'https://www.scorebat.com/spain-la-liga-live-scores/'),
                drawerListTileLeagues(assetName: 'assets/bundesliga.png',name: 'Bundesliga', context: context,url: 'https://www.scorebat.com/germany-bundesliga-live-scores/'),
                drawerListTileLeagues(assetName: 'assets/seriea.png',name: 'Serie A', context: context,url: 'https://www.scorebat.com/italy-serie-a-live-scores/'),
                drawerListTileLeagues(assetName: 'assets/ligue1A.png',name: 'Ligue 1', context: context,url: 'https://www.scorebat.com/france-ligue-1-live-scores/'),
                Divider(color: Color(0xffed5565),),
                ListTile(
                  title: Text('version 1.0.0', style: TextStyle(color: Colors.black),textAlign: TextAlign.right,)
                )
                ]
              ),
          ),
            );
}

Widget drawerListTile({IconData icon, String name,context}){
  return InkWell(
    onTap: (){
      Navigator.pushReplacementNamed(context,Routes.home);
    },
    child:Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.only(left: 10),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 30,color: Colors.black,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(name , style: TextStyle(
                  color: Colors.black,
                ),)),
            ],
            ),
            Icon(Icons.arrow_right, color: Colors.black,),
        ],),
    )
  );
}

Widget drawerListTileLeagues({String assetName, String name,context,String url}){
  return InkWell(
    onTap: (){
      Navigator.pushReplacementNamed(context, Routes.lague, arguments: ScreenArguments(url));
    },
    child:Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.only(left: 10),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                  radius: 15.0,
                  backgroundImage: AssetImage(assetName),
                ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(name , style: TextStyle(
                  color: Colors.black,
                ),)),
            ],
            ),
            Icon(Icons.arrow_right, color: Colors.black,),
        ],),
    )
  );
}