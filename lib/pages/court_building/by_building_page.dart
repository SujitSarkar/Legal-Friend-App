import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/app_bar_court_building.dart';

class ByBuildingPage extends StatefulWidget {
  const ByBuildingPage({Key key}) : super(key: key);

  @override
  _ByBuildingPageState createState() => _ByBuildingPageState();
}

class _ByBuildingPageState extends State<ByBuildingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CourtBuildingAppBar(
            pageName: 'আদালতের নাম অনুসারে'),
      ),
    );
  }
}

