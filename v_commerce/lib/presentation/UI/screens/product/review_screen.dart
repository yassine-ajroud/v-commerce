import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: CustomScrollView(
        slivers: [
            SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading:IconButton(
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    padding: EdgeInsets.zero,
                    icon:const Icon(Icons.arrow_back,size: 30,)) ,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                   shadowColor: Colors.grey,
                      pinned: true,
                      floating: true,
                      snap: true,
                          
                  ),  
        ],
      ),
    ));
  }
}