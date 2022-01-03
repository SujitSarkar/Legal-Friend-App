import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legal_friend/providers/public_provider.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/gradient_button.dart';
import 'package:legal_friend/tiles/live_page_app_bar.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';

class LivePage extends StatefulWidget {
  const LivePage({Key key}) : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: PColor.livePageBgColor,
      body: _bodyUI(publicProvider, size),
      bottomNavigationBar: BottomTile(),
    );
  }

  Widget _bodyUI(PublicProvider publicProvider, Size size) => SafeArea(
      child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                children: [
                  LiveAppBar(child: Text('LIVE',
                      style: TextStyle(fontSize: size.width*.06,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
                  SizedBox(height: size.width*.04),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: size.width*.045
                      ),
                      children: [
                        TextSpan(text: 'মহানগর দায়রা জজ আদালত, ঢাকা।\n',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffFFFF24),fontSize: size.width*.05)),
                        TextSpan(text: 'ফৌজদারি বিবিধ মামলা'),
                      ],
                    ),
                  ),
                  SizedBox(height: size.width*.08),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('LiveSerial').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data.docs[index];
                              return Column(
                                children: [

                                  Text('serial',textAlign:TextAlign.center,style: TextStyle(color: Colors.grey.shade300,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * .08)),
                                  Container(
                                    height:size.width * .18,
                                    width: size.width * .5,
                                    color:doc['is_live']
                                        ? Colors.white
                                        : Colors.grey,
                                    alignment: Alignment.center,
                                    child: doc['is_live']
                                        ?Text(doc['serial_number'].toString(),style: TextStyle(color: Colors.red,fontSize: size.width*.15,fontWeight: FontWeight.bold))
                                        :Container(),
                                  ),
                                  SizedBox(height: size.width*.01),

                                  doc['is_live']
                                      ? Text('Last Update: ${DateFormat('hh:mm aa').format(DateTime.fromMillisecondsSinceEpoch(doc['last_update_date']))}',
                                      textAlign:TextAlign.center,style: TextStyle(color: Colors.grey.shade300,
                                      fontSize: size.width * .04))
                                      :Container(),
                                  SizedBox(height: size.width*.1),

                                  doc['is_live']
                                      ?Container()
                                      :Text('[ লাইভ বন্ধ আছে ]',textAlign:TextAlign.center,style: TextStyle(color: Color(0xffFF0000),
                                      fontSize: size.width * .1)),

                                ],
                              );
                            });
                      } else {
                        return Container(
                          height:size.width * .18,
                          width: size.width * .5,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                        );
                      }
                    },
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(bottom: size.width*.1),
                child: GradientButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text('Close',
                      style: TextStyle(fontSize: size.width * .06)),
                  height: size.width * .12,
                  width: size.width * .8,
                  borderRadius: size.width * .03,
                  gradientColors: [
                    Color(0xffFF4B00),
                    Color(0xffC63900),
                  ],
                ),
              ),
            ],
          )));
}
