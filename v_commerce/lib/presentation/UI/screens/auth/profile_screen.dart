import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:v_commerce/presentation/UI/screens/auth/update_password_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/update_profile_screen.dart';
import 'package:v_commerce/presentation/UI/screens/settings/language_settings.dart';
import 'package:v_commerce/presentation/UI/widgets/change_profil_image_dialog.dart';
import 'package:v_commerce/presentation/UI/widgets/log_out_dialog.dart';
import 'package:v_commerce/presentation/controllers/authentication_controller.dart';
import '../../../../core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/profile_buttons_item.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<AuthenticationController>(
            builder: (controller) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                        Stack(
                          children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:controller.currentUser.image== '' ? Image.asset('assets/images/userImage.jpeg').image:NetworkImage(controller.currentUser.image!),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(icon:const Icon(Icons.edit),onPressed: (){
                                showDialog(context: context, builder: (_)=> const ProfileImageDialog());
                              },),))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              style: AppTextStyle.blackTitleTextStyle,
                              '${controller.currentUser.firstName} ${controller.currentUser.lastName}'),
                        ),
                        Text(
                            style: AppTextStyle.greyTitleTextStyle,
                           controller.currentUser.oAuth==null? controller.currentUser.email:  controller.currentUser.oAuth=='F'?AppLocalizations.of(context)!.logged_with_facebook:AppLocalizations.of(context)!.logged_with_google
                            ),

                          SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                         controller.currentUser.oAuth !=null? Container(): ProfileButtonItem(text: AppLocalizations.of(context)!.change_password,icon: Icons.lock_outline,click: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const UpdatePasswordScreen()));
                          },),
                          const SizedBox(height: 20,),
                          ProfileButtonItem(
                            trailing: controller.missingData,
                            text: AppLocalizations.of(context)!.edit_user_infos,icon: Icons.account_box_outlined,click: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const UpdateProfileScreen()));
                
                          }),
                          const SizedBox(height: 20,),
                          ProfileButtonItem(text: AppLocalizations.of(context)!.change_language,icon: Icons.language_sharp,click: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SelectLanguageScreen()));
                          }),
                          const SizedBox(height: 20,),
                          ProfileButtonItem(text: AppLocalizations.of(context)!.logout,icon: Icons.exit_to_app_outlined,click: (){
                            showDialog(context: context, builder: ((ctx) =>const LogoutDialog() ));
                          })
                      ]),
                ),

              );
            },
          ),
        ),
      ),
    );
  }
}
