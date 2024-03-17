// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // import 'core/components/components.dart';
// //
// // class NotificationPage extends StatelessWidget {
// //   const NotificationPage({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child:
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             OutlinedButton(onPressed: (){
// //               FirebaseMessaging.instance.subscribeToTopic('AM');
// //               showToast(message: 'subscribed', toastStates: ToastStates.SUCCESS);
// //             }, child: const Text('Suscribe AM',style: TextStyle(color: Colors.blue),),style: OutlinedButton.styleFrom(
// //               side: const BorderSide(width: 1.0, color: Colors.blue),
// //             ),),
// //             SizedBox(height: 10,),
// //             OutlinedButton(onPressed: (){
// //               FirebaseMessaging.instance.unsubscribeFromTopic('AM');
// //               showToast(message: 'Un subscribed', toastStates: ToastStates.SUCCESS);
// //             }, child: const Text('unSuscribe AM',style: TextStyle(color: Colors.blue)),style: OutlinedButton.styleFrom(
// //               side: const BorderSide(width: 1.0, color: Colors.blue),
// //             ),),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //-----------------------------------------------------------------
//
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/cupertino.dart';
// //
// // class Application extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => _Application();
// // }
// //
// // class _Application extends State<Application> {
// //   // It is assumed that all messages contain a data field with the key 'type'
// //   Future<void> setupInteractedMessage() async {
// //     // Get any messages which caused the application to open from
// //     // a terminated state.
// //     RemoteMessage? initialMessage =
// //     await FirebaseMessaging.instance.getInitialMessage();
// //
// //     // If the message also contains a data property with a "type" of "chat",
// //     // navigate to a chat screen
// //     if (initialMessage != null) {
// //       _handleMessage(initialMessage);
// //     }
// //
// //     // Also handle any interaction when the app is in the background via a
// //     // Stream listener
// //     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
// //   }
// //
// //   void _handleMessage(RemoteMessage message) {
// //     if (message.data['type'] == 'chat') {
// //       Navigator.pushNamed(context, '/chat',
// //         arguments: ChatArguments(message),
// //       );
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     // Run code required to handle interacted messages in an async function
// //     // as initState() must not be async
// //     setupInteractedMessage();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text("...");
// //   }
// // }
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:social_app/layout/Home_Layout.dart';
//
// class any extends StatefulWidget {
//   const any({Key? key, required this.startWidget}) : super(key: key);
//   final Widget startWidget;
//
//   @override
//   State<any> createState() => _anyState();
// }
//
// class _anyState extends State<any> {
//   final navigatorKey = GlobalKey<NavigatorState>();
//   @override
//   void initState() {
//     super.initState();
//     // print token .
//     FirebaseMessaging.instance
//         .getToken()
//         .then((value) => print('token is $value'));
//
//     FirebaseMessaging.onMessage.listen((event) {
//       print('test notification is ----- ${event.data}');
//       print('test notification is ----- ${event.notification!.title}');
//       print('test notification is ----- ${event.notification!.body}');
//       showNotification(event.notification!);
//     });
//   }
//
//   void showNotification(RemoteNotification notification) async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     // initialise the plugin.
//     // app_icon needs to be a added as a
//     // drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//
//     /// define platforms .
//     // final IOSInitializationSettings initializationSettingsIOS =
//     //     IOSInitializationSettings(
//     //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     //
//     // final MacOSInitializationSettings initializationSettingsMacOS =
//     //     MacOSInitializationSettings();
//
//
//     /// Initialization platforms
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: initializationSettingsAndroid,
//       // iOS: initializationSettingsIOS,
//       // macOS: initializationSettingsMacOS
//     );
//
//     // select notification | payload = data from FirebaseMessaging
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (payload) => selectNotification(payload!),);
//
//     // channels notification .
//     channelNotification(flutterLocalNotificationsPlugin,notification);
//
//   }
//
//   void selectNotification(String payload) {
//     navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
//       builder: (context) => const Home(),
//     ),);
//     // navigateAndFinish(context, const AllUserChattingPage());
//   }
//
//   void channelNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin ,
//       RemoteNotification notification) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails('your channel id', 'your channel name',
//         channelDescription: 'your channel description',
//         // Importance
//         importance: Importance.max,
//         // Priority
//         priority: Priority.high,
//         ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//
//       // 1- number of notification => notification.hashCode = Not a specific number
//       // 0 = one message only .
//
//       // 2- title of message
//       // 3- body of message
//
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         platformChannelSpecifics,
//         payload: 'item x');}
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       useInheritedMediaQuery: true,
//       debugShowCheckedModeBanner: false,
//       navigatorKey: navigatorKey,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.black12,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.black12,
//         ),
//         focusColor: Colors.white,
//         textTheme: const TextTheme(
//             bodyText1: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//             )),
//         primarySwatch: Colors.blue,
//       ),
//       home: widget.startWidget,
//     );
//   }
//
//
// }
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// import 'core/components/components.dart';
//
// class NotificationPage extends StatelessWidget {
//   const NotificationPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child:
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             OutlinedButton(onPressed: (){
//               FirebaseMessaging.instance.subscribeToTopic('AM');
//               showToast(message: 'subscribed', toastStates: ToastStates.SUCCESS);
//             }, child: const Text('Suscribe AM',style: TextStyle(color: Colors.blue),),style: OutlinedButton.styleFrom(
//               side: const BorderSide(width: 1.0, color: Colors.blue),
//             ),),
//             // space10Horizontal,
//             OutlinedButton(onPressed: (){
//               FirebaseMessaging.instance.unsubscribeFromTopic('AM');
//               showToast(message: 'Un subscribed', toastStates: ToastStates.SUCCESS);
//             }, child: const Text('unSuscribe AM',style: TextStyle(color: Colors.blue)),style: OutlinedButton.styleFrom(
//               side: const BorderSide(width: 1.0, color: Colors.blue),
//             ),),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// import 'anr.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Shimmer',
//       routes: <String, WidgetBuilder>{
//         'loading': (_) => const LoadingListPage(),
//         'slide': (_) => SlideToUnlockPage(),
//       },
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shimmer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           children: <Widget>[
//             ListTile(
//               title: const Text('Loading List'),
//               onTap: () => Navigator.of(context).pushNamed('loading'),
//             ),
//             ListTile(
//               title: const Text('Slide To Unlock'),
//               onTap: () => Navigator.of(context).pushNamed('slide'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LoadingListPage extends StatefulWidget {
//   const LoadingListPage({super.key});
//
//   @override
//   State<LoadingListPage> createState() => _LoadingListPageState();
// }
//
// class _LoadingListPageState extends State<LoadingListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Loading List'),
//       ),
//       body: Shimmer.fromColors(
//           baseColor: Colors.grey.shade300,
//           highlightColor: Colors.grey.shade100,
//           enabled: true,
//           child:  SingleChildScrollView(
//             physics: const NeverScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 BannerPlaceholder(),
//                 TitlePlaceholder(width: double.infinity),
//                 SizedBox(height: 16.0),
//                 ContentPlaceholder(
//                   lineType: ContentLineType.threeLines,
//                 ),
//                 SizedBox(height: 16.0),
//                 TitlePlaceholder(width: 200.0),
//                 SizedBox(height: 16.0),
//                 ContentPlaceholder(
//                   lineType: ContentLineType.twoLines,
//                 ),
//                 SizedBox(height: 16.0),
//                 TitlePlaceholder(width: 200.0),
//                 SizedBox(height: 16.0),
//                 ContentPlaceholder(
//                   lineType: ContentLineType.twoLines,
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
//
// class SlideToUnlockPage extends StatelessWidget {
//   final List<String> days = <String>[
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday'
//   ];
//   final List<String> months = <String>[
//     'January',
//     'February',
//     'March',
//     'April',
//     'May',
//     'June',
//     'July',
//     'August',
//     'September',
//     'October',
//     'November',
//     'December',
//   ];
//
//   SlideToUnlockPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final DateTime time = DateTime.now();
//     final int hour = time.hour;
//     final int minute = time.minute;
//     final int day = time.weekday;
//     final int month = time.month;
//     final int dayInMonth = time.day;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Slide To Unlock'),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Image.asset(
//             'assets/images/onboarding1.jpg',
//             fit: BoxFit.cover,
//           ),
//           Positioned(
//             top: 48.0,
//             right: 0.0,
//             left: 0.0,
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     '${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}',
//                     style: const TextStyle(
//                       fontSize: 60.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 4.0),
//                   ),
//                   Text(
//                     '${days[day - 1]}, ${months[month - 1]} $dayInMonth',
//                     style: const TextStyle(fontSize: 24.0, color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               bottom: 32.0,
//               left: 0.0,
//               right: 0.0,
//               child: Center(
//                 child: Opacity(
//                   opacity: 0.8,
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.black12,
//                     highlightColor: Colors.white,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Image.asset(
//                           'assets/images/onboarding2.png',
//                           height: 20.0,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 4.0),
//                         ),
//                         const Text(
//                           'Slide to unlock',
//                           style: TextStyle(
//                             fontSize: 28.0,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
