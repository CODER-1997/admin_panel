import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../models/company_model.dart';

class CompaniesController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController companyName = TextEditingController();
  TextEditingController company20lPrice = TextEditingController();
  TextEditingController companyPhone = TextEditingController();
  TextEditingController companyDiscountRate = TextEditingController();

  //


  TextEditingController companyNameEdit =
  TextEditingController();
  TextEditingController company20lPriceEdit =
  TextEditingController();
  TextEditingController companyPhoneEdit =
  TextEditingController();
  TextEditingController companyDiscountRateEdit = TextEditingController();


  setValues(String companyName, String companyPhone, String price20lwater,String companyDiscountRateEditText ) {
    companyNameEdit =TextEditingController(text: companyName);
    company20lPriceEdit =
        TextEditingController(text: price20lwater);
    companyPhoneEdit =
        TextEditingController(text: companyPhone);
    companyDiscountRateEdit = TextEditingController(text: companyDiscountRateEditText);

  }


  final CollectionReference _dataCollection =
  FirebaseFirestore.instance.collection('waterCompanies');

  void addNewCompany() async {
    Get.back();
    isLoading.value = true;
    try {
      CompanyData newData = CompanyData(
        companyName: companyName.text,
        companyPhone: companyPhone.text,
        price20LWater: company20lPrice.text,
        companyLogo: '',
        createdAt: DateTime.now().toString(), discountRate: companyDiscountRate.text,
      );
      // Create a new document with an empty list
      await _dataCollection.add({
        'items': newData.toMap(),
      });
      Get.snackbar(
        "Success !",
        "Firma qo'shildi !",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      print('Data added to the list in Firestore');
      isLoading.value = false;
      company20lPrice.clear();
      companyPhone.clear();
      companyName.clear();
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error:${e}',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;

// Firestore
  }
  void editCompany(String documentId) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =_firestore.collection('waterCompanies').doc(documentId);


      // Update the desired field
      await documentReference.update({
        'items.companyName':companyNameEdit.text,
        'items.companyPhome':companyPhoneEdit.text,
        'items.price20LWater':company20lPriceEdit.text,
      });
      print('Updated succesfully');
      isLoading.value = false;
      Get.back();
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }
  void deleteCompany(String documentId) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =_firestore.collection('waterCompanies').doc(documentId);


      // Update the desired field
      await documentReference.delete();
      print('Updated succesfully');
      isLoading.value = false;
      Get.back();
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
