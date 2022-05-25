import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:library_app/ads/cubit/ads_cubit.dart';
import 'package:library_app/shared/bloc_observer.dart';
import 'package:library_app/shared/local/cache_helper.dart';
import 'package:library_app/shared/remote/dio_helper.dart';
import 'package:library_app/shared/shared_pref_helper.dart';
import 'package:library_app/styles/themes.dart';

import 'components/constant.dart';
import 'drawer_screens/home_screen/cubit/home_cubit.dart';
import 'drawer_screens/home_screen/home_sceen.dart';
import 'inner_screens/search_cubit/cubit.dart';
import 'inner_screens/splash.dart';



void main() {
//  MyApp(),
  DioHelper.dioInit();


  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();
//  RequestConfiguration config = RequestConfiguration(
//    testDeviceIds: <String> ["E8F901B8C95DCC8C292B9D20E9454B0B"],
//  );
//  MobileAds.instance.updateRequestConfiguration(config);

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  BlocOverrides.runZoned(
        () async{
          await CacheHelper.init();
          bool isDark = CacheHelper.getBoolean(key: 'isDark');

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
    //    CacheHelper.init();
    //

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
              home: SplashScreen(),

            ),
            providers: [
              BlocProvider(
                create: (BuildContext context) => LibraryCubit()..getAppData()..getHomeData()..getSection(id: 0)..getsubSection(id: 0)..getDrawerData()..getAllSection()..getAdsData()..userResult(),

              ),
              BlocProvider(
                create: (BuildContext context) => SearchCubit()..getSearch()

              ),

            ]

        );
    });
  }
}














