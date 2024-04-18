import 'package:admin_version_2/pages/companies/company_history.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../controllers/companies_controller.dart';
import '../../controllers/discounts_controller.dart';
import '../../custom_widgets/FormFieldDecorator.dart';
import '../../custom_widgets/gradient_button.dart';

class Discounts extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final DiscountsController discountController =
      Get.put(DiscountsController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: [
          FilledButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      insetPadding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      //this right here
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          width: Get.width,
                          height: 220,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("Aksiya"),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                        controller:
                                        discountController  .Title,
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoratione(
                                            'Aksiya nomini kiriting'
                                                .tr
                                                .capitalizeFirst! ??
                                                ''),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Maydonlar bo'sh bo'lmasligi kerak";
                                          }
                                          return null;
                                        }),
                                  ),


                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    discountController.addNewDiscount();
                                  }
                                },
                                child: Obx(() => CustomButton(
                                    isLoading: discountController.isLoading.value,
                                    text: "Yarating".tr.capitalizeFirst!)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
              label: Text("Aksiya yaratish")),
          SizedBox(
            width: 32,
          )
        ],
      ),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('waterDiscounts')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              return GroupedListView(
                elements: snapshot.data!.docs,
                groupBy: (element) => element['items']['createdAt'],
                groupSeparatorBuilder: (String groupByValue) => Visibility(
                  visible: false,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(DateFormat('d MMM HH:mm')
                        .format(DateTime.parse(groupByValue))),
                  ),
                ),
                itemComparator: (item1, item2) => item1['items']['createdAt']
                    .compareTo(item2['items']['createdAt']),
                floatingHeader: true,
                order: GroupedListOrder.DESC,
                itemBuilder: (c, element) {
                  return InkWell(
                    onTap: (){
                      Get.to(CompanyHistory(title: element['items']['Title']));
                    },
                    child: Container(
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [

                                  Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(111)),
                                    child: Text(
                                      element['items']['Title']
                                          .toString()
                                          .substring(0, 1)
                                          .capitalizeFirst!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 28),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 32),
                                      child: Text(
                                        element['items']['Title'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 33),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            discountController.setValues(
                                              element['items']['Title'],);

                                            return Dialog(
                                              backgroundColor: Colors.white,
                                              insetPadding: EdgeInsets.all(16),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12.0)),
                                              //this right here
                                              child: Form(
                                                key: _formKey,
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                                  width: Get.width,
                                                  height: 220,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text("Tahrirlash"),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          SizedBox(
                                                            child: TextFormField(
                                                                decoration:
                                                                buildInputDecoratione(
                                                                    ''),
                                                                controller:
                                                                discountController
                                                                    .TitleEdit,
                                                                keyboardType:
                                                                TextInputType
                                                                    .text,
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return "Maydonlar bo'sh bo'lmasligi kerak";
                                                                  }
                                                                  return null;
                                                                }),
                                                          ),

                                                          SizedBox(
                                                            height: 16,
                                                          ),

                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            discountController
                                                                .editDiscount(element
                                                                .id
                                                                .toString());
                                                          }
                                                        },
                                                        child: Obx(() => CustomButton(
                                                            isLoading:
                                                            discountController
                                                                .isLoading
                                                                .value,
                                                            text: "Tahrirlash"
                                                                .tr
                                                                .capitalizeFirst!)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(onPressed: (){
                                    discountController.deleteDiscount(element.id.toString());
                                  }, icon: Icon(Icons.delete,color: Colors.deepOrange,))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
