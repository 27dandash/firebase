import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/model/message_model.dart';
import 'package:social_app/core/model/user_model.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/features/chat/user_details.dart';

import '../../core/cubit/state.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getMessages(
          recivreId: userModel.uId!,
        );

        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            // var message = snapshot.data.documents[index]["content"];
            // var from = snapshot.data.documents[index]["idFrom"];
            return Scaffold(
              appBar: AppBar(
                titleSpacing: -10.0,
                backgroundColor: Colors.grey[400]!,
                title: InkWell(
                  onTap: () {
                    navigateTo(context, User_Details());
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          userModel.img!,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: 290,
                        child: Text(
                          userModel.name!,
                          // style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                child: Stack(
                  children: [
                    if (AppCubit.get(context).messages.isNotEmpty)
                      BuildCondition(
                        condition: AppCubit.get(context).messages.isNotEmpty,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var message =
                                        AppCubit.get(context).messages[index];

                                    if (AppCubit.get(context).userModel?.uId ==
                                        message.senderId) {
                                      return buildMyMessage(message);
                                    }
                                    return buildMessage(message);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 15.0,
                                  ),
                                  itemCount:
                                      AppCubit.get(context).messages.length,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50.0,
                                      color: Colors.blue,
                                      child: MaterialButton(
                                        onPressed: () {
                                          AppCubit.get(context).getitemImage();
                                          messageController.clear();
                                        },
                                        minWidth: 1.0,
                                        child: const Icon(
                                          Icons.add_a_photo,
                                          size: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                        ),
                                        child: TextFormField(
                                          controller: messageController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'type your message here ...',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50.0,
                                      color: Colors.blue,
                                      child: MaterialButton(
                                        onPressed: () {
                                          AppCubit.get(context).sendMessage(
                                            dateTime: DateTime.now().toString(),
                                            text: messageController.text,
                                            recivreId: userModel.uId!,
                                          );
                                          messageController.clear();
                                        },
                                        minWidth: 1.0,
                                        child: Icon(
                                          Icons.send,
                                          size: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        fallback: (context) => const Center(
                          child: Text(
                            'No Message Now , Start Messaging ...',
                            style:
                                TextStyle(fontSize: 25, color: Colors.orange),
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          SizedBox(
                            height: 330,
                          ),
                          Center(
                            child: Text(
                              'No Message Now , Start Messaging ...',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Container(
                                  height: 50.0,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      AppCubit.get(context).getitemImage();
                                      messageController.clear();
                                    },
                                    minWidth: 1.0,
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type your message here ...',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      AppCubit.get(context).sendMessage(
                                        recivreId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                      messageController.clear();
                                    },
                                    minWidth: 1.0,
                                    child: Icon(
                                      Icons.send,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text!,
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(
              .2,
            ),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text!,
          ),
        ),
      );
}

// import 'package:buildcondition/buildcondition.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app/core/cubit/cubit.dart';
// import 'package:social_app/core/cubit/cubit.dart';
// import 'package:social_app/core/model/message_model.dart';
// import 'package:social_app/core/model/user_model.dart';
//
// import '../../core/cubit/state.dart';
//
// class ChatDetailsScreen extends StatelessWidget {
//   UserModel userModel;
//   ChatDetailsScreen({Key? key,required this.userModel}) : super(key: key);
//
//
//   var messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         AppCubit.get(context).getMessages(
//             recivreId: userModel.uId!,
//         );
//
//         return BlocConsumer<AppCubit, AppStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 titleSpacing: 0.0,
//                 backgroundColor: Colors.grey[400]!,
//                 title: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20.0,
//                       backgroundImage: NetworkImage(
//                         userModel.img!,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 15.0,
//                     ),
//                     Text(
//                       userModel.name!,
//                     ),
//                   ],
//                 ),
//               ),
//               body: BuildCondition(
//                 condition: AppCubit.get(context).messages.isNotEmpty,
//                 builder: (context) => Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           physics: const BouncingScrollPhysics(),
//                           itemBuilder: (context, index)
//                           {
//                             var message = AppCubit.get(context).messages[index];
//
//                             if(AppCubit.get(context).userModel?.uId! == message.senderId) {
//                               return buildMyMessage(message);
//                             }
//                             return buildMessage(message);
//                           },
//                           separatorBuilder: (context, index) => const SizedBox(
//                             height: 15.0,
//                           ),
//                           itemCount: AppCubit.get(context).messages.length,
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey[300]!,
//                             width: 1.0,
//                           ),
//                           borderRadius: BorderRadius.circular(
//                             15.0,
//                           ),
//                         ),
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 15.0,
//                                 ),
//                                 child: TextFormField(
//                                   controller: messageController,
//                                   decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'type your message here ...',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 50.0,
//                               color: Colors.blue,
//                               child: MaterialButton(
//                                 onPressed: () {
//                                   AppCubit.get(context).sendMessage(
//                                     recivreId:userModel.uId!,
//                                     dateTime: DateTime.now().toString(),
//                                     text: messageController.text,
//                                   );
//                                   messageController.clear();
//                                 },
//                                 minWidth: 1.0,
//                                 child: const Icon(
//                                   Icons.send,
//                                   size: 16.0,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 fallback: (context) => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildMessage(MessageModel model) => Align(
//     alignment: AlignmentDirectional.centerStart,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: const BorderRadiusDirectional.only(
//           bottomEnd: Radius.circular(
//             10.0,
//           ),
//           topStart: Radius.circular(
//             10.0,
//           ),
//           topEnd: Radius.circular(
//             10.0,
//           ),
//         ),
//       ),
//       padding: const EdgeInsets.symmetric(
//         vertical: 5.0,
//         horizontal: 10.0,
//       ),
//       child: Text(
//         model.text!,
//       ),
//     ),
//   );
//
//   Widget buildMyMessage(MessageModel model) => Align(
//     alignment: AlignmentDirectional.centerEnd,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.blue.withOpacity(
//           .2,
//         ),
//         borderRadius:  const BorderRadiusDirectional.only(
//           bottomStart:  Radius.circular(
//             10.0,
//           ),
//           topStart:  Radius.circular(
//             10.0,
//           ),
//           topEnd: Radius.circular(
//             10.0,
//           ),
//         ),
//       ),
//       padding: const EdgeInsets.symmetric(
//         vertical: 5.0,
//         horizontal: 10.0,
//       ),
//       child: Text(
//         model.text!,
//       ),
//     ),
//   );
// }