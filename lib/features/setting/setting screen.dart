// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app/core/cubit/cubit.dart';
// import 'package:social_app/core/cubit/state.dart';
//
// class SettingScreen extends StatelessWidget {
//   const SettingScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//   listener: (context, state) {},
//   builder: (context, state) {
//     // var Usermodel=AppStates.get(context).userModel;
//
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//
//       child: Column(
//         children: [
//           SizedBox(
//             height: 180,
//             child: Stack(
//               // alignment: AlignmentDirectional.bottomCenter,
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     decoration:  BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft:Radius.circular(5) ,
//                         topRight:Radius.circular(5) ,
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                         '${Usermodel!.coverimg}'
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     height: 140,
//                     width: double.infinity,
//                   ),
//                 ),
//                 CircleAvatar(
//                   radius: 58,
//                   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                   child:  CircleAvatar(
//                     radius: 55,
//                     backgroundImage: NetworkImage(
//                         '${Usermodel.img}'                    ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//
//           Text(
//             '${Usermodel.name}',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//           SizedBox(
//             height: 3,
//           ),
//           Text(
//             '${Usermodel.bio}',
//             style: Theme.of(context).textTheme.caption,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         Text(
//                           '5',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         Text(
//                           'Posts',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         Text(
//                           '10',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         Text(
//                           'Photo',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         Text(
//                           '1000',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         Text(
//                           'Followers',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         Text(
//                           '5000',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                         Text(
//                           'Friends',
//                           style: Theme.of(context).textTheme.subtitle1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(child: OutlinedButton(onPressed: (){}  , child:Text('Add Photos'))),
//               OutlinedButton(onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context){
//                   return edit_profile_screen();
//                 }));
//
//               }  , child:Icon(Icons.edit)),
//             ],
//           ),
//           Column(
//             children: [
//               SizedBox(
//                 height: 60,
//               ),
//               TextButton(
//                   onPressed: () {
//                     SocialCubit.get(context).onchangeappmode();
//                   },
//                   child: Row(
//                     children: const [
//                       Text(
//                         'Change Theme',
//                       ),
//                       Spacer(),
//                       Icon(Icons.dark_mode)
//                     ],
//                   )),
//               const Divider(thickness: 2, height: 5, color: Colors.grey),
//               TextButton(
//                   onPressed: () {
//                     SocialCubit.get(context).changeLanguage();
//                   },
//                   child: Row(
//                     children: const [
//                       Text('Change Language'),
//                       Spacer(),
//                       Icon(Icons.language)
//                     ],
//                   )),
//               const Divider(thickness: 2, height: 5, color: Colors.grey),
//               TextButton(
//                   onPressed: () {
//                     CacheHelper.removeData(key: 'uId');
//                     navigateFinish(context, LoginScreen());
//                   },
//                   child: Row(
//                     children: const [
//                       Text('Log Out'),
//                       Spacer(),
//                       Icon(Icons.logout)
//                     ],
//                   )),
//             ],
//           )
//
//         ],
//       ),
//     );
//   },
// );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/Home/NotificationPage.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/network/local/SharedPreferences.dart';
import 'package:social_app/features/login/login_screen.dart';
import 'package:social_app/features/setting/updet_user_data.dart';
import '../../core/components/components.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var Usermodel = AppCubit.get(context).userModel!.img;
        var cubit = AppCubit.get(context);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(Usermodel!),
                      // backgroundImage: NetworkImage('${Usermodel?.img}'),
                      radius: 90,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Center(
                    // width: 900,
                      child: Text(
                        cubit.userModel!.name!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                  // Text(cubit!.userDataModel!.!),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        navigateTo(context, const Update());
                      },
                      text: 'Change User Information'),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        AppCubit.get(context).changeLanguage();
                      },
                      text: 'Change App Language'),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        AppCubit.get(context).onchangeappmode();
                      },
                      text: 'Change Theme'),
                  SizedBox(height: 15,),
                  defaultButton(
                      function: () {
                        navigateTo(context, NotificationPage());
                      },
                      text: 'Active Notification'),
                  // Spacer(),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        CacheHelper.removeData(
                          key: 'uId',
                        );
                        navigateFinish(context, LoginScreen());
                      },
                      text: 'Log out'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
