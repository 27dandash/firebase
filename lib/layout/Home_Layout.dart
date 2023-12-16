import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/features/InternetConnectionPage.dart';

import '../core/components/components.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // how to start firebase notification
  // final navigatorKey = GlobalKey<NavigatorState>();
  //
  // @override
  //
  // void initState() {
  //   super.initState();
  //   // print token .
  //   FirebaseMessaging.instance
  //       .getToken()
  //       .then((value) => print('token is $value'));
  //
  //   FirebaseMessaging.onMessage.listen((event) {
  //     print('test notification is ----- ${event.data}');
  //     print('test notification is ----- ${event.notification!.title}');
  //     print('test notification is ----- ${event.notification!.body}');
  //     showNotification(event.notification!);
  //   });
  // }
  //
  // void showNotification(RemoteNotification notification) async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //   FlutterLocalNotificationsPlugin();
  //   // initialise the plugin.
  //   // app_icon needs to be a added as a
  //   // drawable resource to the Android head project
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  //
  //   /// define platforms .
  //   // final IOSInitializationSettings initializationSettingsIOS =
  //   //     IOSInitializationSettings(
  //   //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //   //
  //   // final MacOSInitializationSettings initializationSettingsMacOS =
  //   //     MacOSInitializationSettings();
  //
  //
  //   /// Initialization platforms
  //   const InitializationSettings initializationSettings =
  //   InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     // iOS: initializationSettingsIOS,
  //     // macOS: initializationSettingsMacOS
  //   );
  //
  //   // select notification | payload = data from FirebaseMessaging
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (payload) => selectNotification(payload!),);
  //
  //   // channels notification .
  //   channelNotification(flutterLocalNotificationsPlugin,notification);
  //
  // }
  //
  // void selectNotification(String payload) {
  //   navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
  //     builder: (context) => const Home(),
  //   ),);
  //   // navigateAndFinish(context, const AllUserChattingPage());
  // }
  //
  // void channelNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin ,
  //     RemoteNotification notification) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails('your channel id', 'your channel name',
  //       channelDescription: 'your channel description',
  //       // Importance
  //       importance: Importance.max,
  //       // Priority
  //       priority: Priority.high,
  //       ticker: 'ticker');
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //
  //     // 1- number of notification => notification.hashCode = Not a specific number
  //     // 0 = one message only .
  //
  //     // 2- title of message
  //     // 3- body of message
  //
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       platformChannelSpecifics,
  //       payload: 'item x');}

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: BuildCondition(
              condition: !AppCubit.get(context).noInternetConnection,
              builder: (context) => Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  // backgroundColor: Colors.orange,
                  title: Text(cubit.Titels[cubit.currentIndex]),

                ),
                body: cubit.bottomScreen[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottom(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_max_rounded), label: "Items"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.message), label: "Users "),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.drag_indicator), label: "Add New Item "),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart), label: "Cart "),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "settings"),
                  ],
                ),
              ),
              fallback: (context) => const InternetConnectionPage(),
            ));
      },
    );
  }
}
