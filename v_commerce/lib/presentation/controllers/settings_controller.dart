import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:v_commerce/data/data_sources/local_data_sorce/settings_local_data_source.dart';

class SettingsController extends GetxController{
  String currentlocale='en';

  Future<String> loadLocale()async{
    currentlocale = await SettingsLocalDataSourcImpl().loadLocale();
        update();

    return currentlocale;
  }

  void setLocal(String value){
    currentlocale = value;
    update();
  }

   Future<void> saveLocale(String locale)async{
   await SettingsLocalDataSourcImpl().saveLocale(locale);
       currentlocale = locale;
        update();

  }
}