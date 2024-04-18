import 'package:admin_version_2/pages/companies/company_history.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../controllers/companies_controller.dart';
import '../../custom_widgets/FormFieldDecorator.dart';
import '../../custom_widgets/gradient_button.dart';

class Companies extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final CompaniesController companiesController =
      Get.put(CompaniesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          height: 520,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("Firma qo'shish"),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                        controller:
                                            companiesController.companyName,
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoratione(
                                            'Firma nomini kiriting'
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
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      controller:
                                          companiesController.company20lPrice,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Maydonlar bo'sh bo'lmasligi kerak";
                                        }
                                        return null;
                                      },
                                      decoration: buildInputDecoratione(
                                          '20 litrlik bitta suv narxi'
                                                  .tr
                                                  .capitalizeFirst! ??
                                              ''),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      controller:
                                          companiesController.companyPhone,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Maydonlar bo'sh bo'lmasligi kerak";
                                        }
                                        return null;
                                      },
                                      decoration: buildInputDecoratione(
                                          'Firmaning telefon raqami'
                                                  .tr
                                                  .capitalizeFirst! ??
                                              ''),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      controller:
                                      companiesController.companyDiscountRate,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Maydonlar bo'sh bo'lmasligi kerak";
                                        }
                                        return null;
                                      },
                                      decoration: buildInputDecoratione(
                                          'Firmaning chegirma berish soni '
                                              .tr
                                              .capitalizeFirst! ??
                                              ''),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  // SizedBox(
                                  //   height: 16,
                                  // ),
                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //
                                  //     SizedBox(height: 20),
                                  //     ElevatedButton(
                                  //       onPressed: companiesController.uploadImage,
                                  //       child: Text('Upload Image'),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 16,
                                  // ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    companiesController.addNewCompany();
                                  }
                                },
                                child: CustomButton(
                                  isLoading: companiesController.isLoading.value,
                                    text: "Qo'shish".tr.capitalizeFirst!),
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
              label: Text("Firma qo'shish")),
          SizedBox(
            width: 32,
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('waterCompanies')
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
                      Get.to(CompanyHistory(title: element['items']['companyName']));
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
                                  // element['items']['companyLogo']
                                  //         .toString()
                                  //         .isNotEmpty
                                  //     ? Container(
                                  //         alignment: Alignment.center,
                                  //         height: 100,
                                  //         width: 100,
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(100)),
                                  //         child: Image.network(
                                  //           element['items']['companyLogo'].toString(),
                                  //         ),
                                  //       )
                                  //     :
                                  Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(111)),
                                    child: Text(
                                      element['items']['companyName']
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
                                        element['items']['companyName'],
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
                                            companiesController.setValues(
                                                element['items']['companyName'],
                                                element['items']['companyPhone'],
                                                element['items']['price20LWater'],
                                                element['items']['discountRate']);

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
                                                  height: 520,
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
                                                                    companiesController
                                                                        .companyNameEdit,
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
                                                          SizedBox(
                                                            child: TextFormField(
                                                              controller:
                                                                  companiesController
                                                                      .company20lPriceEdit,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              validator: (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return "Maydonlar bo'sh bo'lmasligi kerak";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: buildInputDecoratione(
                                                                  '20 litrlik bitta suv narxi'
                                                                          .tr
                                                                          .capitalizeFirst! ??
                                                                      ''),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          SizedBox(
                                                            child: TextFormField(
                                                              controller:
                                                                  companiesController
                                                                      .companyPhoneEdit,
                                                              validator: (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return "Maydonlar bo'sh bo'lmasligi kerak";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: buildInputDecoratione(
                                                                  'Firmaning telefon raqami'
                                                                          .tr
                                                                          .capitalizeFirst! ??
                                                                      ''),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          SizedBox(
                                                            child: TextFormField(
                                                              controller:
                                                              companiesController
                                                                  .companyDiscountRateEdit,
                                                              validator: (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return "Maydonlar bo'sh bo'lmasligi kerak";
                                                                }
                                                                return null;
                                                              },
                                                              decoration: buildInputDecoratione(
                                                                  'Chegirma miqdori'
                                                                      .tr
                                                                      .capitalizeFirst! ??
                                                                      ''),
                                                            ),
                                                          ),
                                                          // SizedBox(
                                                          //   height: 16,
                                                          // ),
                                                          // Column(
                                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                                          //   children: [
                                                          //
                                                          //     SizedBox(height: 20),
                                                          //     ElevatedButton(
                                                          //       onPressed: companiesController.uploadImage,
                                                          //       child: Text('Upload Image'),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          // SizedBox(
                                                          //   height: 16,
                                                          // ),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            companiesController
                                                                .editCompany(element
                                                                    .id
                                                                    .toString());
                                                          }
                                                        },
                                                        child: Obx(() => CustomButton(
                                                            isLoading:
                                                            companiesController
                                                                .isLoading
                                                                .value,
                                                            text: "Tahrirlash"
                                                                .tr
                                                                .capitalizeFirst!)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.edit))
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
