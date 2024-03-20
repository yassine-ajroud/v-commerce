import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/string_const.dart';
import '../../../core/errors/exceptions/exceptions.dart';

abstract class SettingsLocalDataSourc {
  Future<String> loadLocale();
  Future<void> saveLocale(String locale);

}

class SettingsLocalDataSourcImpl
    implements SettingsLocalDataSourc {
      @override
      Future<String> loadLocale() async{
    try {
      final sp = await SharedPreferences.getInstance();
      final data = sp.getString(StringConst.SP_LANGUAGE_KEY)??'fr';
      return data;
    } catch (e) {
      throw LocalStorageException();
    }
      }
    
      @override
      Future<void> saveLocale(String locale) async{
      try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_LANGUAGE_KEY,locale);
    } catch (e) {
      throw LocalStorageException();
    }
      }
 


}
