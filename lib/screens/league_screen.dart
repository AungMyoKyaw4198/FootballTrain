import 'package:FootballHighlightsApp/model/screen_argument.dart';
import 'package:FootballHighlightsApp/widgets/overall_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:firebase_admob/firebase_admob.dart';

class LeagueScreen extends StatefulWidget {
  static const String routeName= '/league';

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  BannerAd myBannerAd;
  bool isLoading = false;
  InAppWebViewController webView;

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

  @override
  void initState() { 
    FirebaseAdMob.instance.initialize(
        appId: 'ca-app-pub-8107971978330636~3314169680');
    myBannerAd = biuldBannerAd()
      ..load();
    super.initState();
  }

  @override
  void dispose() { 
    myBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        backgroundColor: Color(0xfffbf9f9),
          appBar: mainAppBar(),
          drawer: drawerWidget(context),
          body: Container(
            color: Color(0xfffbf9f9),
            child: isLoading ? Center(
              child: CircularProgressIndicator(),
            ):
            InAppWebView(
              initialUrl: args.url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                  mediaPlaybackRequiresUserGesture : false,
                  preferredContentMode : UserPreferredContentMode.MOBILE,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
              },
              onLoadStop: (InAppWebViewController controller, String url) {
                webView.evaluateJavascript(source: "document.getElementsByClassName('TopBar')[0].style.display='none';");
                webView.evaluateJavascript(source: "document.getElementsByClassName('BatFeedFlexSidebar')[0].style.display='none';");
                webView.evaluateJavascript(source: "document.getElementsByClassName('Ad BatFeedAd BatFeedItem')[0].style.display='none';");
                webView.evaluateJavascript(source: "document.getElementsByClassName('BatFeedItem BatFeedItemExtraPadding')[0].style.display='none';");
                webView.evaluateJavascript(source: "document.getElementsByClassName('CompetitionTdSgg')[0].style.display='none';");
                webView.evaluateJavascript(source: "document.getElementsByClassName('BatFeedItem BatFeedItemNoBackground BatFeedItemFooter')[0].style.display='none';");
                
              },
            ),
      ),
    );
  }
}