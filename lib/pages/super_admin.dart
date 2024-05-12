import 'package:admin_version_2/constants/theme.dart';
import 'package:admin_version_2/pages/discounts/discounts.dart';
import 'package:admin_version_2/pages/users/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'companies/companies.dart';

class SuperAdmin extends StatelessWidget {
  List categories = ['Firmalar', 'Aksiyalar',"Mijozlar"];

  RxList pages = [Companies(), Discounts(),Users()].obs;
  RxList icons = [Icons.home_work_outlined,Icons.discount,CupertinoIcons.person_2].obs;

  RxInt selectedPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Obx(() => Container(
                      color: dashBoardColor,
                      child: Column(
                        children: [
                          Container(
                            color: dashBoardColor,
                            child: FittedBox(
                              child: Row(
                                children: [
                                  // Container(
                                  //     child: Image.asset(
                                  //       'assets/logo.png',
                                  //       width: 120,
                                  //     )),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  Text(
                                    'Aqua water delivery',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 28),
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
                              onTap: () {
                                selectedPage.value = i;
                              },
                              child: Container(

                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Icon(icons[i],color:selectedPage.value == i ? CupertinoColors.white:lightGrey ,),
                                      SizedBox(width: 8,),
                                      Text(
                                        "${categories[i]}",
                                        style: TextStyle(
                                            color: selectedPage.value == i ? CupertinoColors.white:lightGrey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )),
                            )
                        ],
                      ),
                    ))),
            Expanded(flex: 5, child: Obx(() => pages[selectedPage.value])),
          ],
        ),
      ),
    );
  }
}
