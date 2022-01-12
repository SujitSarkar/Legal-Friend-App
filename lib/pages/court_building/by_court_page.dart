import 'package:flutter/material.dart';
import 'package:legal_friend/tiles/app_bar_court_building.dart';

class ByCourtPage extends StatefulWidget {
  const ByCourtPage({Key key}) : super(key: key);

  @override
  _ByCourtPageState createState() => _ByCourtPageState();
}

class _ByCourtPageState extends State<ByCourtPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CourtBuildingAppBar(
            pageName: 'আদালতের নাম অনুসারে',
            courtName: 'যুগ্ম মহানগর দায়রা জজ'),
      ),
    );
  }
}
