import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LawyerPage extends StatefulWidget {
  @override
  _LawyerPageState createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
  double progress = 0;
  String pageTitle = 'Loading...';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("   $pageTitle",
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel_outlined, color: Colors.white),
                    splashRadius: 30,
                  )
                ],
              ),
            ),
          ),
          body: Container(
              child: Column(
                  children: <Widget>[
            if (progress != 1.0)
              LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.cyanAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
            Expanded(
              child: Container(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: Uri.parse(
                          'https://www.dhakabarassociation.com/member_of_dba.php')),
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    setState(() => this.progress = progress / 100);
                  },
                  onTitleChanged: (InAppWebViewController controller, String title) {
                    setState(() => pageTitle = title);
                  },
                ),
              ),
            )
            // ignore: unnecessary_null_comparison
          ].where((Object o) => o != null).toList()))),
    );
  }
}
