import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import 'package:v_commerce/presentation/controllers/service_category_controller.dart';

class SpecialityInput extends StatelessWidget {
  const SpecialityInput({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceCategoryController serviceCategoryController = ServiceCategoryController();
    return GetBuilder<AuthenticationController>(
      init: AuthenticationController(),
      builder: (controller) {
        return FutureBuilder(
          future: serviceCategoryController.getServiceCategories(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
 return DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        
             decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:  BorderRadius.all(
                             Radius.circular(30.0),
                            
                          ),
                        ),
                        filled: true,
                        hintText: AppLocalizations.of(context)!.speciality,
                        fillColor:AppColors.lightgrey,
                        prefixIcon: SvgPicture.string(APPSVG.specialityIcon,fit: BoxFit.scaleDown)
                        ),
                      isExpanded: true,
                      value: controller.speciality,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        child: Text(
                          AppLocalizations.of(context)!.speciality,
                          style: AppTextStyle.smallblackTextStyle,
                        ),
                      ),
                      onChanged: (value) {
                        controller.setSpeciality(value!);
                      },
              
                      items: snapshot.data!.map((e) => DropdownMenuItem<String>(value: e.id,child: Text(e.title))).toList()
                      
                    
                    ),
              );
            }else{
              return Container();
            }
           
          }
        );
      }
    );
  }
}