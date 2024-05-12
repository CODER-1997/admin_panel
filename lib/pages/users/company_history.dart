import 'package:admin_version_2/constants/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_version_2/custom_widgets/custom_shimmer.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class CompanyHistory extends StatelessWidget {
  final String title;

  CompanyHistory({required this.title});

  Widget getStatus(String status) {
    if (status == 'finished') {
      return Row(
        children: [
          Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: Colors.greenAccent,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Yetkazilgan'.tr.capitalizeFirst!,
            style: TextStyle(
                color: Colors.greenAccent, fontWeight: FontWeight.w700),
          )
        ],
      );
    } else if (status == 'rejected') {
      return Row(
        children: [
          Icon(
            Icons.cancel,
            color: Colors.redAccent,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Bekor qilingan'.tr.capitalizeFirst!,
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w700),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            CupertinoIcons.cube,
            color: Colors.blueAccent,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Yetkazish jarayonida'.tr.capitalizeFirst!,
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.w700),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,

        title: Text(
          title,
          style: appBarStyle,
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('waterOrders').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomShimmer();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // If data is available
          if (snapshot.hasData) {
            var list = snapshot.data!.docs
                .where((element) => (element['items']['companyId'].toString().removeAllWhitespace.toLowerCase() == title.toString().removeAllWhitespace.toLowerCase()))
                .toList();
            return list.isNotEmpty
                ? GroupedListView(
                    elements: list,
                    groupBy: (element) => element['items']['when'],
                    groupSeparatorBuilder: (String groupByValue) => Visibility(
                      visible: false,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat('d MMM HH:mm')
                            .format(DateTime.parse(groupByValue))),
                      ),
                    ),
                    itemComparator: (item1, item2) => item1['items']['when']
                        .compareTo(item2['items']['when']),
                    floatingHeader: true,
                    order: GroupedListOrder.DESC,
                    itemBuilder: (c, element) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getStatus(element['items']['status']),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "${DateFormat('d MMM').format(DateTime.parse(element['items']['when']))} • "
                              "${element['items']['from']} - ${element['items']['to']}"
                              "",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.black38,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${element['items']['where']}"
                                      .capitalizeFirst!,
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'quantity'.tr.capitalizeFirst! +
                                        ": " +
                                        "${element['items']['count']}",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w800)),
                                Text("${element['items']['price']} so'm",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800))
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 64,
                      ),
                      Center(
                        child: Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/empty.png')),
                      ),
                    ],
                  );
          }
          // If no data available

          else {
            return Text('No data'); // No data available
          }
        },
      ),
    );
  }
}
