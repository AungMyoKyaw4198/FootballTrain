import 'package:FootballHighlightsApp/model/video.dart';
import 'package:FootballHighlightsApp/widgets/overall_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoScreen extends StatefulWidget {
  final String statUrl;
  final List<Video> videos;
  VideoScreen({Key key, this.videos, this.statUrl}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  InAppWebViewController webView;
  String videoUrl;

  @override
  void initState() { 
    super.initState();
    videoUrl = convertUrl(widget.videos[0].embed);
  }

  @override
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: mainAppBar(),
        body:  Container(
            color: Color(0xfffbf9f9),
            child: webViewVideoPlayer(widget.statUrl,webView)),
      );
  }
}

convertUrl(String iframeString){
  List<String> tags = iframeString.replaceAll('<', ' ').replaceAll('>', ' ').split(' ');
  String srcTag = tags.where((s) => s.startsWith('src=')).first;
  String url = srcTag.substring(5, srcTag.length - 1);
  return url;
}

Widget webViewVideoPlayer(String url,InAppWebViewController webView){
  return Container(
            child: Column(children: <Widget>[
          Expanded(
              child: InAppWebView(
            initialUrl: url,
            initialHeaders: {},
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onLoadStart: (InAppWebViewController controller, String url) {},
            onLoadStop: (InAppWebViewController controller, String url) {
              webView.evaluateJavascript(source: "document.getElementsByClassName('TopBar')[0].style.display='none';");
              webView.evaluateJavascript(source: "document.getElementsByClassName('BatFeedFlexSidebar')[0].style.display='none';");
              webView.evaluateJavascript(source: "document.getElementsByClassName('MatchViewTodaysGames')[0].style.display='none';");
              webView.evaluateJavascript(source: "document.getElementsByClassName('Ad BatFeedAd BatFeedItem')[0].style.display='none';");
              webView.evaluateJavascript(source: "document.getElementsByClassName('BatFeedItem BatFeedItemNoBackground BatFeedItemFooter')[0].style.display='none';");
            },
          ))
        ]));
}