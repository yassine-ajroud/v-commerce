
import 'package:flutter/material.dart';

class CustomSlideTransition extends PageRouteBuilder{
  final Widget child;
  CustomSlideTransition({required this.child}):super(
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context,animation,secondaryAnimation)=>child);

@override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
   
   return SlideTransition(
    position: Tween<Offset>(
      begin:const Offset(1,0),
      end: const Offset(0, 0)
    ).animate(animation),
    child: child);
  }
}