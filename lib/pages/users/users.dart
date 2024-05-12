import 'package:admin_version_2/constants/text_styles.dart';
import 'package:admin_version_2/constants/theme.dart';
import 'package:admin_version_2/pages/companies/company_history.dart';
import 'package:admin_version_2/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Users extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();


  RxInt allUsers = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdadada),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              allUsers.value =  snapshot.data!.docs.length;
              print("All users ");
              return ListView.builder(

                itemCount: snapshot.data!.docs.length,

                itemBuilder: (BuildContext context, int index) {
                  var element  = snapshot.data!.docs[index];
                  return  Column(
                    children: [
             index == 0 ? Container(
               padding: EdgeInsets.all(16),
               color: CupertinoColors.white,
                 margin: EdgeInsets.only(bottom: 16),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text("Jami mijozlar ${allUsers.value} ta",style: appBarStyle,),
                   ],
                 )) :SizedBox(height: 0,),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white
                        ),
                        child: Row(children: [
                          Icon(Icons.person,color: Colors.blue,),
                          SizedBox(width: 16,),
                          Text(element['items']['name'].toString()  + " " + element['items']['surname'].toString())
                        ],),
                      ),
                    ],
                  );
                },
              );
            }
            // If no data available

            else {
              return Text('No data'); // No data available
            }
          }),
    );
  }
}
