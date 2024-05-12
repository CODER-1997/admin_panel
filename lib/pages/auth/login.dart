import 'package:admin_version_2/pages/super_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../companies/company_history.dart';

class LoginPage extends StatelessWidget {

  TextEditingController username=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return 1 > 0  ? SuperAdmin():Scaffold(
        backgroundColor: Colors.blueGrey[900], // Set background color
        body: Center(
          child: Container(
            width: 400, // Set container width
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
              color: Colors.white, // Container background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow effect
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Content fits container
              children: [
                Text(

                  'Aqua water delivery',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900], // Text color
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded input field
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if(username.text=='superadmin'){
                      Get.to(SuperAdmin());
                    }
                    else{
                      Get.to(CompanyHistory(title: username.text,));
                    }
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blueGrey[900], // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}
