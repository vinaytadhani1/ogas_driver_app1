import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/homescreen/language/controller.dart';
import 'package:ogas_driver_app/util/language.dart';
import 'package:ogas_driver_app/widgets/background.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:ogas_driver_app/widgets/language_model_Custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main.dart';
import '../../util/language_constants.dart';


int? ggvalue = 0;
String method = 'English';

final List locales = [
    {
      'name':'English',
      'locale':const Locale('en','US'),
    },
    {
      'name':'عَمّان',
      'locale':const Locale('ar','OM'),
    }
  ];

updateLocale(Locale locale , BuildContext context ){
    Get.updateLocale(locale );
  }
class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  
  String? lang = 'English';
  getLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    lang = pref.getString(PrefString.language);
    if (lang == null) {
      lang = 'English';
      setState(() {});
    }
    print(lang);
    ggvalue = lang == 'English' ? 0 : 1;
    setState(() {});
  }

  // Controller controller = Get.put(Controller());

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      imagename: "asset/icons/drawerList_icon/leftarrow2x.png",
      text: 'language'.tr,
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Container(
            //       margin: const EdgeInsets.all(5),
            //       height: MediaQuery.of(context).size.height/5,
            //       // color: Colors.white,
            //       child: ListView.separated(
            //         itemCount: locales.length,
            //         itemBuilder: (context, index) {
            //           return GestureDetector(
            //             onTap: ()async{
            //               ggvalue = index;
            //               updateLocale(locales[index]['locale'],context);
            //               SharedPreferences pref = await SharedPreferences.getInstance();
            //               // if(ggvalue==0){
            //               //   SharedPreferences pref = await SharedPreferences.getInstance();
            //               //   pref.setString(PrefString.language, 'English');
            //               // }else{
            //               //   SharedPreferences pref = await SharedPreferences.getInstance();
            //               //   pref.setString(PrefString.language, 'Arabic');
            //               // }
            //               ggvalue == index ?  pref.setString(PrefString.language, 'English') : 
            //                               pref.setString(PrefString.language, 'Arabic');
            //               setState(() {});
            //             },
            //             child: Container(
            //               padding: const EdgeInsets.only(left: 10,right: 10),
            //               alignment:ggvalue == index ?  Alignment.centerLeft : Alignment.centerRight,
            //               height: 50, width:340,
            //               // height: 50,width: 340,
            //               decoration: BoxDecoration(
            //                 boxShadow:  [
            //                   BoxShadow(
            //                     color: Colors.grey.shade200,
            //                     blurRadius: 1,
            //                     spreadRadius: 1,
            //                   ),
            //                 ],
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(8),
            //                 border: ggvalue == index ? Border.all( color: const Color(0xffF58823), width: 1.5): null,
            //               ),
            //               child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children:  [
            //                       Text(locales[index]['name'].toString(),
            //                         // "Arabic",
            //                         style: const TextStyle(
            //                             fontSize: 17, fontWeight: FontWeight.bold),
            //                       ),
            //                     ],
            //                   ),
            //                   Radio<int>(
            //                     value: index,
            //                     groupValue:ggvalue,
            //                     onChanged: (value) async {
            //                       ggvalue = index;
            //                       updateLocale(locales[index]['locale'],context);
            //                         SharedPreferences pref = await SharedPreferences.getInstance();
            //                         ggvalue == index ?  pref.setString(PrefString.language, 'English') : 
            //                                             pref.setString(PrefString.language, 'Arabic');
            //                       setState(() {});
            //                     },
            //                     activeColor: Colors.orange,
            //                     fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            //                       if (states.contains(MaterialState.selected)) {
            //                         return Colors.orange;
            //                       }
            //                       return Colors.orange;
            //                     }),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //         separatorBuilder: (context, index) => const SizedBox(height: 15),
            //       ),
            //     ),
                  
            LanguageModel(
              lname: "English",
              height: 50,
              width: 340,
              onTap: (() async {
                Locale _locale = await setLocale(ENGLISH);
                MyApp.setLocale(context, _locale);
                updateLocale(locales[0]['locale'],context);
                // controller.changeLanguage('en', 'US');
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString(PrefString.language, 'English');
                ggvalue = 0;
                // method = 'English';
                setState(() {});
              }),
              fontSize: 15,
              groupValue: ggvalue,
              value: 0,
              border: ggvalue == 0
                  ? Border.all(color: ColorConstnt.mainorange, width: 1.5)
                  : null,
              onChanged: (value) async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString(PrefString.language, 'English');
                ggvalue = 0;
                // method = 'English';
                setState(() {});
              },
            ),
            SizedBox(height: 15),
            LanguageModel(
              lname: "عَمّان",
              onTap: () async {
                ggvalue = 1;
                Locale _locale = await setLocale(ARABIC);
                MyApp.setLocale(context, _locale);
                updateLocale(locales[1]['locale'],context);
                // controller.changeLanguage('ar', 'OM');
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString(PrefString.language, 'Arabic');
                // method = 'عَمّان';
                setState(() {});
              },
              height: 50,
              width: 340,
              fontSize: 15,
              groupValue: ggvalue,
              value: 1,
              border: ggvalue == 1
                  ? Border.all(color: ColorConstnt.mainorange, width: 1.5)
                  : null,
              onChanged: (value) async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString(PrefString.language, 'Arabic');
                ggvalue = 1;
                // method = 'عَمّان';
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
