import 'package:flutter/material.dart';
import 'package:legal_friend/pages/archive_details.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/app_bar.dart';
import 'package:legal_friend/tiles/archive_tile.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/variables.dart';
import 'package:provider/provider.dart';

class ArchiveList extends StatefulWidget {
  @override
  _ArchiveListState createState() => _ArchiveListState();
}

class _ArchiveListState extends State<ArchiveList> {
  bool _isLoading = false;
  int _counter = 0;

  _customInit(PublicProvider publicProvider) async {
    setState(() => _counter++);
    if (publicProvider.archiveDataList.isEmpty) {
      setState(() => _isLoading = true);
      await publicProvider.getArchiveDataList().then((value) {
        setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    if (_counter == 0) _customInit(publicProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: PublicAppBar(
          pageName: '',
          bottomText: '',
          image: 'assets/home_image/bodli_khana.png',
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: _isLoading
          ? Center(child: spinCircle())
          : _bodyUI(size, publicProvider),
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(Size size, PublicProvider publicProvider) => RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () async => await publicProvider.getArchiveDataList(),
        child: Column(
          children: [
            GradientButton(
              onPressed: () async => await publicProvider.getArchiveDataList(),
              child: Text(Variables.archive,
                  style: TextStyle(fontSize: size.width * .06)),
              height: size.width * .12,
              width: size.width * .8,
              borderRadius: size.width * .03,
              gradientColors: [
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
              ],
            ),
            SizedBox(height: size.width * .04),
            publicProvider.archiveDataList.isEmpty
                ? SizedBox(height: size.width * .2)
                : Container(),
            publicProvider.archiveDataList.isEmpty
                ? Center(
                    child: Text(
                      'আপনার কোন আর্কাইভ নেই',
                      style: TextStyle(
                          color: Color(0xffFF8219),
                          fontSize: size.width * .045),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: publicProvider.archiveDataList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArchiveDetails(
                                        id: publicProvider
                                            .archiveDataList[index].id,
                                        dataId: publicProvider
                                            .archiveDataList[index].dataId,
                                        userPhone: publicProvider
                                            .archiveDataList[index].userPhone,
                                        amoliAdalot: publicProvider
                                            .archiveDataList[index].amoliAdalot,
                                        bicarikAdalot: publicProvider
                                            .archiveDataList[index]
                                            .bicarikAdalot,
                                        boiNo: publicProvider
                                            .archiveDataList[index].boiNo,
                                        dayraNo: publicProvider
                                            .archiveDataList[index].dayraNo,
                                        entryDate: publicProvider
                                            .archiveDataList[index].entryDate,
                                        mamlaNo: publicProvider
                                            .archiveDataList[index].mamlaNo,
                                        mamlarDhoron: publicProvider
                                            .archiveDataList[index]
                                            .mamlarDhoron,
                                        pokkhoDhara: publicProvider
                                            .archiveDataList[index].pokkhoDhara,
                                        porobortiTarikh: publicProvider
                                            .archiveDataList[index]
                                            .porobortiTarikh,
                                        jojCourt: publicProvider
                                            .archiveDataList[index].jojCourt,
                                        saveDate: publicProvider
                                            .archiveDataList[index].saveDate,
                                      ))),
                          child: ArchiveTile(
                              index: index,
                              dataList: publicProvider.archiveDataList)),
                    ),
                  ),
          ],
        ),
      );
}
