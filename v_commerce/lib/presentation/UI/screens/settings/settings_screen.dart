import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:v_commerce/core/styles/colors.dart';
import 'package:v_commerce/core/styles/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/core/utils/svg.dart';
import 'package:v_commerce/presentation/UI/widgets/expandable_setting_header.dart';
import 'package:v_commerce/presentation/UI/widgets/language_section.dart';
import 'package:v_commerce/presentation/UI/widgets/support_section.dart';
import 'package:v_commerce/presentation/controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: GetBuilder(
        init: SettingsController(),
        builder: (controller) {
          return CustomScrollView(
            slivers: [
                    SliverAppBar(
                      title: Text(AppLocalizations.of(context)!.settings,style: AppTextStyle.appBarTextButtonStyle,),
                      centerTitle: true,
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

                              SliverToBoxAdapter(child: 
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(children: [
                                  GetBuilder(
                                    init: SettingsController(),
                                    id: ControllerID.UPDTAE_LANGUAGE,
                                    builder: (languageSettings) {
                                      return ExpandableSettingsHeader(
                                                    title: AppLocalizations.of(context)!.lang,
                                                    icon: APPSVG.langugeIcon,
                                                    onPress: (){
                                                      languageSettings.toggleLangugeExpandable(!languageSettings.expandedlanguge);
                                                    },
                                                    expanded: languageSettings.expandedlanguge,
                                                  );
                                    }
                                  ),
                                  ExpandablePanel(
                                              controller: ExpandableController()..expanded=controller.expandedlanguge,
                                              collapsed: Container(),
                                              expanded:
                                            const LanguageSection()
                                              
                                              ),
                              const SizedBox(height: 20,),
                                               Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 0),
                                                 child: Row(children: [
                                                              SvgPicture.string(APPSVG.notificationIcon,),
                                                             const SizedBox(width: 10,),
                                                               Text(AppLocalizations.of(context)!.notifications,style:AppTextStyle.blackSettingsTitleTextStyle,),
                                                               const Spacer(),
                                                                  GetBuilder(
                                                                    init: SettingsController(),
                                                                    id: ControllerID.UPDTAE_NOTIFICATION,
                                                                    builder: (notifController) {
                                                                      return FlutterSwitch(
                                                                 //  width: 80,     
              showOnOff: true,
              value: notifController.activeNotification,
              //activeIcon: Text(AppLocalizations.of(context)!.off),
              activeText: AppLocalizations.of(context)!.on,
              //inactiveIcon: Text(AppLocalizations.of(context)!.on),
              inactiveText: AppLocalizations.of(context)!.off,
              inactiveColor: AppColors.grey,
              activeColor: AppColors.secondary,
              activeTextFontWeight: FontWeight.normal,
              inactiveTextFontWeight: FontWeight.normal,
              onToggle: (val) {
                notifController.toggleNotification(val);
              },
            );
                                                                    }
                                                                  ),


                                                                  
                                                           ],),
                                               ),
                                                                             const SizedBox(height: 20,),

                                                                                         GetBuilder(
                                    init: SettingsController(),
                                    id: ControllerID.UPDTAE_CONTACT,
                                    builder: (contactController) {
                                      return ExpandableSettingsHeader(
                                                    title: AppLocalizations.of(context)!.support,
                                                    icon: APPSVG.phoneIcon,
                                                    onPress: (){
                                                      contactController.toggleContactExpandable(!contactController.expandedContact);
                                                    },
                                                    expanded: contactController.expandedContact,
                                                  );
                                    }
                                  ),
                                  ExpandablePanel(
                                              controller: ExpandableController()..expanded=controller.expandedContact,
                                              collapsed: Container(),
                                              expanded:
                                            const SupportSection()
                                              
                                              ),   
                              const SizedBox(height: 20,),

                                               Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 0),
                                                 child: Row(children: [
                                                                SvgPicture.string(APPSVG.infosIcon,),
                                                               const SizedBox(width: 10,),
                                                                 Text(AppLocalizations.of(context)!.faq,style:AppTextStyle.blackSettingsTitleTextStyle,),
                                                                  
                                                             ],),
                                               ),

                                ]),
                              ),)
            ],
          );
        }
      ),

    ));
  }
}

