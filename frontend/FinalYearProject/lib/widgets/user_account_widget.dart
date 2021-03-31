import 'dart:io';
import 'package:FinalYearProject/CustomDialog/CustomDialog.dart';
import 'package:FinalYearProject/CustomDialog/logOutDialog.dart';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

//this is used for updating the profile img
final FirebaseAuth _auth = FirebaseAuth.instance;

class UserAccountWidget extends StatefulWidget {
  FirebaseUser user;
  UserAccountWidget({Key key, this.user}) : super(key: key);
  @override
  _UserAccountWidgetState createState() => _UserAccountWidgetState();
}

class _UserAccountWidgetState extends State<UserAccountWidget> {
  //variable to store the new img file
  File _image;

  //function to launch the img picker
  imageFunction() async {
    pickImageFromGallery();
  }

  //function that handles the img selection
  //calls the function to update the firebase profile pic
  Future pickImageFromGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });

    //disables the button only once the image has been selected
    if (imageFile != null) {
      showDialog(
        context: context,
        child: CustomDialog(
            title: "Profile Picture Updated!",
            description:
                "These changes will take effect after the app is restarted",
            buttonText: "Confirm",
            alertImage: "assets/tick.png",
            buttonColor: Colors.green[400]),
      );
    }

    //update the profile img in firebase
    _updateProfileImg();
  }

  //function that handles the updating of the profile pic
  void _updateProfileImg() async {
    //sets up the firebase storage variable
    final _storage = FirebaseStorage.instance;

    //store the new firebase updated info
    UserUpdateInfo newFirebaseInfo = new UserUpdateInfo();

    //this is the path in the firebase storage we use to save image to
    String savePath = "${widget.user.displayName}/profileImage";

    //uploads the image we selected to our firebase storage
    var snapshot =
        await _storage.ref().child(savePath).putFile(_image).onComplete;

    //gives us the url for the uploaded image to be used throughout the app
    var firebaseImgUrl = await snapshot.ref.getDownloadURL();

    //sets the firebase user photoUrl to the firebase img url
    newFirebaseInfo.photoUrl = firebaseImgUrl;

    await widget.user.updateProfile(newFirebaseInfo);

    //reloads user to ensure changes have been processed
    await widget.user.reload();

    //reauthenticates the user with the updated information
    widget.user = await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75)),
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65.0),
                  bottomRight: Radius.circular(65.0))),
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(widget.user.photoUrl),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: FlatButton(
                    onPressed: () {
                      imageFunction();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Change profile image",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    color: waterBlueColour,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
              width: size.width,
              height: size.height / 1.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 15,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(65.0),
                      topRight: Radius.circular(65.0))),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Account details",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: size.height / 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      width: size.width,
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.userCircle,
                                size: 35,
                              ),
                              title: Text(
                                "${widget.user.displayName}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(
                                FontAwesomeIcons.envelope,
                                size: 35,
                              ),
                              title: Text(
                                "${widget.user.email}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: LogOutDialog(
                              title: "Warning",
                              description: "Are you sure you want to Sign Out?",
                              buttonText: "Logout",
                              alertImage: "assets/warning.png",
                              buttonColor: Colors.amber));
                    },
                    icon: Icon(Icons.logout),
                    iconSize: 50.0,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
