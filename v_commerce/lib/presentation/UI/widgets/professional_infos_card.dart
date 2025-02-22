import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/domain/entities/user.dart';
import 'package:v_commerce/presentation/UI/widgets/change_profil_image_dialog.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/service_category_controller.dart';

class ProfessionalInfoCard extends StatelessWidget {
 final String serviceId;
 final User user;
 final bool? update;
  const ProfessionalInfoCard({super.key,required this.serviceId,required this.user ,this.update});

  @override
  Widget build(BuildContext context) {
    ServiceCategoryController serviceCategoryController = Get.find();
    return GetBuilder(
      init: AuthenticationController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.extraLightBlueColor,
            borderRadius: BorderRadius.circular(25)
          ),
          width: double.infinity,
          child:Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                   Stack(
                            children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:user.image== '' ? Image.asset('assets/images/userImage.jpeg').image:NetworkImage(user.image!),
                            ),
                         update??true ?   Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(icon:const Icon(Icons.edit),onPressed: (){
                                  showDialog(context: context, builder: (_)=> const ProfileImageDialog());
                                },),)):Container(),
                            ],
                          ),
                         const SizedBox(width: 20,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.firstName} ${user.lastName}',style: AppTextStyle.appBarTextButtonStyle,),
                    const SizedBox(height: 5,),
                    Text(serviceCategoryController.serviceTitle(serviceId),style: AppTextStyle.smallblackTextStyle,),
                    const SizedBox(height: 5,),

Text.rich( TextSpan(children:[WidgetSpan(child: SvgPicture.string(APPSVG.locationIcon),alignment: PlaceholderAlignment.middle,),TextSpan(text:' ${user.address}',style: AppTextStyle.smallblackTextStyle)]),textAlign: TextAlign.center,),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}