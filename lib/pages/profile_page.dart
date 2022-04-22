import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:legal_friend/tiles/bottom_tile.dart';
import 'package:legal_friend/tiles/notification_widget.dart';
import 'package:legal_friend/variables/pColor.dart';
import 'package:provider/provider.dart';
import '../providers/api_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        showToast('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      backgroundColor: PColor.greyBgColor,
      bottomNavigationBar: BottomTile(),
      body: _bodyUI(size,apiProvider),
    );
  }

  Widget _bodyUI(Size size,ApiProvider apiProvider)=>SafeArea(
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*.08,vertical: size.width*.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.width*.1),

            ///Top Container
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Image
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: size.width*.3,
                        width: size.width*.3,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(size.width*.2))
                        ),
                        child: _image!=null
                            ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(size.width*.2)),
                            child: Image.file(_image,
                                fit: BoxFit.cover,height: size.width*.3,
                              width: size.width*.3))
                            : Icon(Icons.person,size: size.width*.28,
                            color: Theme.of(context).primaryColor),
                      ),
                      Positioned(
                          bottom: size.width*.02,
                          right: 0.0,
                          child: InkWell(
                            onTap: ()=>_getImage(),
                            child: Container(
                                alignment: Alignment.center,
                                height: size.width*.08,
                                width: size.width*.08,
                                decoration: BoxDecoration(
                                    color:  PColor.greyBgColor,
                                    borderRadius: BorderRadius.all(Radius.circular(size.width*.2))
                                ),
                                child: Icon(CupertinoIcons.photo_camera,size: size.width*.058)),
                          ))
                    ],
                  ),
                  SizedBox(height: size.width*.02),

                  ///Name, Designation, Address
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: size.width*.06,
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: '${apiProvider.loginModel.user.name}\n',style: TextStyle(
                              color: Colors.teal,
                              fontSize: size.width*.09,fontWeight: FontWeight.w900)),
                          TextSpan(text: '${apiProvider.loginModel.user.profession}\n'),
                          TextSpan(text: '${apiProvider.loginModel.user.address}\n')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///Personal Info Section
            Row(
              children: [
                Text('Personal Info',style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: size.width*.05,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic
                )),
                SizedBox(width: size.width*.02),
                InkWell(
                    onTap: (){},
                    child: Icon(Icons.edit,size: size.width*.06,color: Colors.teal))
              ],
            ),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: size.width*.045,
                  fontWeight: FontWeight.w400,
                  height: 1.35
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Name: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${apiProvider.loginModel.user.name}\n'),
                  TextSpan(text: 'Profession: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${apiProvider.loginModel.user.profession}\n'),
                  TextSpan(text: 'Company: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${apiProvider.loginModel.user.company}\n'),
                  TextSpan(text: 'From: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${apiProvider.loginModel.user.address}\n'),
                  TextSpan(text: 'Gender: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${apiProvider.loginModel.user.gender}\n'),
                  TextSpan(text: 'Date of Birth: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(apiProvider.loginModel.user.dob)}\n'),
                  TextSpan(text: 'Religion: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${apiProvider.loginModel.user.religion}\n'),
                  TextSpan(text: 'Marital Status: ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade900)),
                  TextSpan(text: '${apiProvider.loginModel.user.materialStatus}\n'),
                ],
              ),
            ),

            ///Profile Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profile Status',style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: size.width*.05,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic
                      )),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: size.width*.045,
                              fontWeight: FontWeight.w500,
                              height: 1.35
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Status: '),
                            TextSpan(text: 'Paid\n'),
                            TextSpan(text: 'Until: '),
                            TextSpan(text: '${DateFormat('dd-MMM-yyyy, hh:mm aa').format(apiProvider.loginModel.user.expireDate)}\n'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/unpaid_user.png',width: size.width*.16)
              ],
            ),

            ///About Me
            Row(
              children: [
                Text('About Me',style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: size.width*.05,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic
                )),
                SizedBox(width: size.width*.02),
                InkWell(
                    onTap: (){},
                    child: Icon(Icons.edit,size: size.width*.06,color: Colors.teal))
              ],
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: size.width*.045,
                    fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(text: '${apiProvider.loginModel.user.aboutMe}'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
