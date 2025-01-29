import 'package:flutter/material.dart';

extension StringFormatters on String{
  String toUpperCaseFirst(){
    try{
      return this[0].toUpperCase() + substring(1);
    }catch(e){
      debugPrint(e.toString());
      return this;
    }
  }
}