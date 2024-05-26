import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v_commerce/core/utils/string_const.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/settings_local_data_source.dart';

class SettingsController extends GetxController{
  String currentlocale='ar';
  bool expandedlanguge=false;
  bool expandedContact=false;
  bool activeNotification=false;

  Future<String> loadLocale()async{
    currentlocale = await SettingsLocalDataSourcImpl().loadLocale();
        update();

    return currentlocale;
  }

  void setLocal(String value){
    currentlocale = value;
    update();
  }
  void toggleLangugeExpandable(bool value){
    expandedlanguge = value;
    update([ControllerID.UPDTAE_LANGUAGE]);
  }

  void toggleContactExpandable(bool value){
    expandedContact = value;
    update([ControllerID.UPDTAE_CONTACT]);
  }
  void toggleNotification(bool value){
    activeNotification = value;
    update([ControllerID.UPDTAE_NOTIFICATION]);
  }

   Future<void> saveLocale(String locale)async{
   await SettingsLocalDataSourcImpl().saveLocale(locale);
       currentlocale = locale;
        update([ControllerID.UPDTAE_LANGUAGE]);
  }
}