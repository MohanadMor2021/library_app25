import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:library_app/shared/bloc_observer.dart';
import 'package:library_app/shared/remote/dio_helper.dart';
import 'package:library_app/shared/shared_pref_helper.dart';
import 'package:library_app/styles/themes.dart';

import 'drawer_screens/home_screen/cubit/home_cubit.dart';
import 'drawer_screens/home_screen/home_sceen.dart';



void main() {
//  MyApp(),
  DioHelper.dioInit();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //MobileAds.instance.initialize();
  RequestConfiguration config = RequestConfiguration(
    testDeviceIds: <String> ["E8F901B8C95DCC8C292B9D20E9454B0B"],
  );
  MobileAds.instance.updateRequestConfiguration(config);

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  BlocOverrides.runZoned(
        () {

      runApp( MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );


}

class MyApp extends StatefulWidget {



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

// FlutterNativeSplash.remove();

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () {
      return
        MultiBlocProvider(
            child: MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:  ThemeMode.light,
              home: HomeScreen(),

            ),
            providers: [
              BlocProvider(
                create: (BuildContext context) => LibraryCubit()..getHomeData()..getSection(id: 0)..getsubSection(id: 0)..getDrawerData()..getAllSection()..getAppData(),

              ),

            ]

        );
    });
  }
}