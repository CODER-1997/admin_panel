
import 'package:admin_version_2/pages/discounts/discounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'companies/companies.dart';

class SuperAdmin extends StatelessWidget {
  List categories = ['Firmalar', 'Aksiyalar'];
  
  RxList pages=[Companies(),Discounts()].obs;

  RxInt selectedPage=0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Obx(() => Container(
                  color: Colors.lightBlueAccent,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: FittedBox(
                          child: Row(
                            children: [
                              Container(
                                  child: Image.asset(
                                    'assets/logo.png',
                                    width: 120,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Aqua12 water delivery',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 33),
                              ),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      for (int i = 0; i < categories.length; i++)
                        InkWell(
                          onTap: (){
                            selectedPage.value=i;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: selectedPage.value==i? Colors.white:Colors.transparent))
                            ),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.all(16),
                              child: FittedBox(child:
                              Text("${categories[i]}",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 33,
                                  fontWeight: FontWeight.w700
                              ),))),
                        )
                    ],
                  ),
                ))),
            Expanded(
                flex: 5,
                child: Obx(() => pages[selectedPage.value])),
          ],
        ),
      ),
    );
  }
}
