import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class DatabaseMethods {


  // student profile deitals stroing..

  Future Storeprofile(Map<String,dynamic>profiledata,String uid) async{
    return await FirebaseFirestore.instance.collection("Studentprofile").doc(uid).set(profiledata);
  }
}