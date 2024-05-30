import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/presentation/UI/screens/services/service_list_screen.dart';
import 'package:v_commerce/presentation/controllers/service_controller.dart';

class ServiceCategoryItem extends StatelessWidget {
 final String image;
  final String title;
  final String id;
  const ServiceCategoryItem({super.key,required this.image,required this.title,required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:0.0,vertical: 5),
      child: GestureDetector(
        onTap: (){
          ServiceController serviceController = Get.find();
          serviceController.selectedServiceCategory=id;
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ServiceListScreen()));
        },
        child: SizedBox(
          height: 220.h,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(image,height: 180.h,width:double.infinity , fit: BoxFit.cover,)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 5),
                child: Text(title,style: AppTextStyle.blackTextStyle,),
              )
          ]),),
      ),
    );
  }
}