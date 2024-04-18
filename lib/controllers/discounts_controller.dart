import 'package:admin_version_2/models/discount_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../models/company_model.dart';

class DiscountsController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController Title = TextEditingController();

  //

  TextEditingController TitleEdit = TextEditingController();

  setValues(
    String Title,
  ) {
    TitleEdit = TextEditingController(text: Title);
  }

  final CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection('waterDiscounts');

  void addNewDiscount() async {
    Get.back();
    isLoading.value = true;
    try {
      DiscountModel newData = DiscountModel(
        Type: 'discount',
        Title: Title.text, createdAt: DateTime.now().toString(),
      );
      // Create a new document with an empty list
      await _dataCollection.add({
        'items': newData.toMap(),
      });
      Get.snackbar(
        "Success !",
        "Aksiys yaratildi !",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      print('Data added to the list in Firestore');
      isLoading.value = false;
 Title.clear();
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

  void editDiscount(String documentId) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =
          _firestore.collection('waterDiscounts').doc(documentId);

      // Update the desired field
      await documentReference.update({
        'items.Title': TitleEdit.text,
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
  void deleteDiscount(String documentId) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =
          _firestore.collection('waterDiscounts').doc(documentId);

      // Update the desired field
      await documentReference.delete();
      print('Updated succesfully');
      isLoading.value = false;
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
