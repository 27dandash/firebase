import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/core/theme/app_theme.dart';
import 'features/Home/NotificationPage.dart';
import 'core/components/components.dart';
import 'core/components/constants.dart';
import 'core/cubit/cubit.dart';
import 'core/cubit/state.dart';
import 'core/network/bloc_observer.dart';
import 'core/network/local/SharedPreferences.dart';
import 'core/network/remote/dio_helper.dart';
import 'features/login/cubit/cubit.dart';
import 'features/login/login_screen.dart';
import 'features/register/cubit/cubit.dart';
import 'layout/Home_Layout.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());
  showToast(message: 'on background message', toastStates: ToastStates.SUCCESS,);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance();
  Bloc.observer = MyBlocObserver();
  var tokenFCM = await FirebaseMessaging.instance.getToken();
  print('tken fcm : $tokenFCM');

  // onUseApp
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());
    showToast(message: 'on message', toastStates: ToastStates.SUCCESS,);
  });

  //background (pause or minimize app)
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    showToast(message: 'on message opened app', toastStates: ToastStates.SUCCESS,);
  });

  // background fcm (destroy or close app)
  FirebaseMessaging.onBackgroundMessage.call(

      // print(event.data.toString());
  // showToast(message: 'on message opened app', toastStates: ToastStates.SUCCESS,);
    // methode work with destroy or close app
      firebaseMessagingBackgroundHandler);

  DioHelper.init();
  await CacheHelper.init();
  bool? isdark = CacheHelper.getData(key: 'Isdark');
  Widget widget;
  bool isRtl = true;
  // bool onBoarding = CacheHelper.getData(key: 'onBoarding') == null ? false  : CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'uId');
  isRtl = CacheHelper.getData(key: 'isRtl');
  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  if (token != null) {
    widget = const Home();
    print(token);
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isRtl: isRtl,
    translation: translation,
    isdark: isdark,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isdark;
  final Widget startWidget;
  final bool isRtl;
  final String translation;

  MyApp(
      {
        required this.startWidget,
        required this.isRtl,
        required this.isdark,
        required this.translation});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
            create: (BuildContext context) => AppCubit()
              ..setTranslation(translation: translation)
              ..checkConnectivity()
              ..onchangeappmode(formShared: isdark,)
              ..checkConnectivity()
                ..getAllUsers()
              ..getMessages
                ..GetOneImage()     //Get 1 Image
                ..GetSmartImages()
                ..GetClothesImages()
                ..GetAllItems()
                ..GetCrt()
                ..getUserData()
              // ..getUserData()
              // ..getPosts()
            // ..getMessages
        ),
        BlocProvider<SocialLoginCubit>(
            create: (BuildContext context) => SocialLoginCubit()),
        BlocProvider<SocialRegisterCubit>(
            create: (BuildContext context) => SocialRegisterCubit())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme,
            darkTheme: AppTheme().darkTheme,
            themeMode: cubit.appTheme ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            // home: any(startWidget: startWidget),
            // home: NotificationPage(),
          );
        },
      ),
    );
  }
}

