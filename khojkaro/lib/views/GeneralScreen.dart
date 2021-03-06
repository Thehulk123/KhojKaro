import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khojkaro/services/PostCrud.dart';

import 'HomeScreen.dart';

class GeneralScreen extends StatefulWidget {
  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  QuerySnapshot postSnapshot;
  PostCrudMethods crudMethods = new PostCrudMethods();

  @override
  void initState() {
    super.initState();
    crudMethods.getGeneralData().then((results) {
      setState(() {
        postSnapshot = results;
      });
    });
  }

  getPost() {
    return Container(
      child: postSnapshot != null
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: postSnapshot.documents.length,
              itemBuilder: (context, index) {
                return PostItem(
                    // ignore: deprecated_member_use
                    imgUrl: postSnapshot.documents[index].get("imageUrl"),
                    // ignore: deprecated_member_use
                    name: postSnapshot.documents[index].get("serviceName"),
                    // ignore: deprecated_member_use
                    desc: postSnapshot.documents[index].get("serviceDesc"),
                    // ignore: deprecated_member_use
                    whatsAppNo:
                        postSnapshot.documents[index].get("whatsappNumber"),
                    // ignore: deprecated_member_use
                    callingNo:
                        postSnapshot.documents[index].get("callingNumber"),
                    category: postSnapshot.documents[index].get("category"));
              })
          : Center(child: Text("")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: postSnapshot != null
            ? getPost()
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
