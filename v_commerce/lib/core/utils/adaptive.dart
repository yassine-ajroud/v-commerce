import 'package:flutter/material.dart';


class Adaptivity{
  
  static AlignmentGeometry alignmentRight(String language){
    if(language=='ar'){
    return Alignment.centerLeft;
    }else{
    return Alignment.centerRight;
    }
  }

   static AlignmentGeometry alignmentLeft(String language){
    if(language=='ar'){
    return Alignment.centerRight;
    }else{
    return Alignment.centerLeft;
    }
  }
}