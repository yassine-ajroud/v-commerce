import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Translator{
  static String getCity(String key,BuildContext context){
    if(key=='ariana'){
      return   AppLocalizations.of(context)!.ariana;
    }else{
       return AppLocalizations.of(context)!.city;
    }
//     switch (key) {
//       case "ariana": return AppLocalizations.of(context)!.ariana;
//       case "beja": return AppLocalizations.of(context)!.beja;
//         case "ben_arous": return AppLocalizations.of(context)!.ben_arous;
//         case "bizerte": return AppLocalizations.of(context)!.bizerte;
//         case "gabes": return AppLocalizations.of(context)!.gabes;
//         case "gafsa": return AppLocalizations.of(context)!.gafsa;
//         case "jendouba": return AppLocalizations.of(context)!.jendouba;
//          case "kairouan": return AppLocalizations.of(context)!.kairouan;
//          case "kasserine": return AppLocalizations.of(context)!.kasserine;
//          case "kebili": return AppLocalizations.of(context)!.kebili;
//          case "jenkefdouba": return AppLocalizations.of(context)!.kef;
//          case "mahdia": return AppLocalizations.of(context)!.mahdia;
//          case "manouba": return AppLocalizations.of(context)!.manouba;
//           case "medenine": return AppLocalizations.of(context)!.medenine;
//         case "monastir": return AppLocalizations.of(context)!.monastir;
//           case "nabeul": return AppLocalizations.of(context)!.nabeul;
//           case "sfax": return AppLocalizations.of(context)!.sfax; 
//           case "sidi_bouzid": return AppLocalizations.of(context)!.sidi_bouzid; 
//           case "siliana": return AppLocalizations.of(context)!.siliana; 
//           case "sousse": return AppLocalizations.of(context)!.sousse; 
//           case "tataouine": return AppLocalizations.of(context)!.tataouine; 
//        case "tozeur": return AppLocalizations.of(context)!.tozeur; 
//          case "tunis": return AppLocalizations.of(context)!.tunis;
//          case "zaghouan": return AppLocalizations.of(context)!.zaghouan;

//     }
// return '';
  }
}