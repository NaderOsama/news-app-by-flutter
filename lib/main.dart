import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/news_layout.dart';
import 'package:udemy_flutter/shared/cubit/changeCubit/changeCubit.dart';
import 'package:udemy_flutter/shared/cubit/changeCubit/changeStates.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/bloc_observe/observe.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark =CacheHelper.getData(key: 'isDark');

  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  const MyApp(this.isDark, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) =>AppCubit()..getBusiness()..getScience()..getSports() ,),
        BlocProvider(
          create: (BuildContext context) => AppCubitt()..changeAppMode(
             fromShared: isDark,
          ),),
          ],
          child: BlocConsumer<AppCubitt, AppChangeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.purple,
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.purple),
                    systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark,),
                    titleTextStyle: TextStyle(
                        color: Colors.purple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                    elevation: 0.0,

                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.purple,
                    elevation: 10,
                    backgroundColor: Colors.black26,
                  ),
                ),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('#333739'),
                  primarySwatch: Colors.purple,
                  appBarTheme: AppBarTheme(
                    iconTheme: const IconThemeData(color: Colors.white),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('#333739'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: HexColor('#333739'),
                    titleTextStyle: const TextStyle(
                        color: Colors.purple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    elevation: 0.0,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.purple,
                    elevation: 10000,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: HexColor('#333739'),
                  ),
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),),
                themeMode:AppCubitt.get(context).isDark?
                ThemeMode.dark : ThemeMode.light,

                routes: {
                  '/': (BuildContext context) => NewsLayout(),
                  //'/SettingScreen' : (BuildContext context)=>SettingScreen(),
                },
              );
            },
          ),


    );
  }
}
