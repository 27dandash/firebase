import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/item_model.dart';
import 'package:social_app/core/model/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({Key? key, required this.usermodel}) : super(key: key);

  ItemModel usermodel;

  var MessageControler = TextEditingController();

  // ChatDetailsScreen(this.usermodel);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage('${usermodel.itemimg}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('${usermodel.itemname}'),
                  Text('${usermodel.itemdescribtion}'),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
