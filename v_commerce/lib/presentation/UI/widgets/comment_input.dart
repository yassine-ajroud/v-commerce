import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/controllers/review_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return           GetBuilder(
      init: ReviewController(),
      builder: (controller) {
        return Container(
          width: double.infinity,
          color: AppColors.backgroundWhite,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  controller.f != null
                  ? Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.file(controller.f!,height: 200.h,width: double.infinity,fit: BoxFit.cover,)),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                controller.clearImage();
                              },
                              icon: const Icon(Icons.clear)))
                    ])
                  : Container(),
                   controller.f != null
                  ?const SizedBox(height: 10,):Container(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightgrey,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextField(
                    onChanged: (s) {
                      controller.typeComment(s);
                    },
                    minLines: 1,
                    maxLines: 3,
                    controller: controller.editingController,
                    decoration: InputDecoration(
                      contentPadding:const EdgeInsets.all(15),
                       border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.add_comment,
                      hintStyle: AppTextStyle.hintTextStyle,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                               IconButton(
                              onPressed: () {
                                controller.pickImage(context);
                              },
                              icon:  SvgPicture.string(APPSVG.pickImageIcon,color: AppColors.darkGrey,)),
                          IconButton(
                              onPressed: controller.comment==''?null:
                                   () async {
                                    controller.addReview();
                                    },
                              icon:  SvgPicture.string(APPSVG.sendIcon,color:controller.comment==''?AppColors.darkGrey:AppColors.secondary ,)),
                     
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}