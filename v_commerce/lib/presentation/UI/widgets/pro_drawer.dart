import 'package:flutter/material.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/screens/auth/update_password_screen.dart';
import 'package:v_commerce/presentation/UI/screens/auth/update_profile_screen.dart';
import 'package:v_commerce/presentation/UI/screens/settings/language_settings.dart';
import 'package:v_commerce/presentation/UI/widgets/drawer_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/presentation/UI/widgets/log_out_dialog.dart';

class ProfessionalDrawer extends StatelessWidget {
  const ProfessionalDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
          backgroundColor: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
                DrawerItem(label: AppLocalizations.of(context)!.messaging, icon: APPSVG.messageIcon, index: 0, onTap: (){}),

                DrawerItem(label: AppLocalizations.of(context)!.general_informations, icon: APPSVG.profileIcon, index: 1, onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const UpdateProfileScreen()));
                }, ),
                DrawerItem(label: AppLocalizations.of(context)!.security, icon: APPSVG.securityIcon2, index: 2, onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const UpdatePasswordScreen()));

                }),
                DrawerItem(label: AppLocalizations.of(context)!.settings, icon: APPSVG.settingsIcon, index: 3, onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SelectLanguageScreen()));
                }),
                DrawerItem(label: AppLocalizations.of(context)!.logout, icon: APPSVG.logoutIcon, index: 4, onTap: ()async{showDialog(context: context, builder: ((ctx) =>const LogoutDialog() ));                                      
                }),

            ]),
          ),
        );
  }
}