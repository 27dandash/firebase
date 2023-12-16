import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/user_model.dart';

class User_Details extends StatefulWidget {
  UserModel ? usermodel;

  User_Details({Key? key,  this.usermodel}) : super(key: key);

  @override
  State<User_Details> createState() => _User_DetailsState();
}

class _User_DetailsState extends State<User_Details> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body:  ListView.separated(
            // scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),

            itemBuilder: (context, index) {
              return buildItemModel(context, cubit.userModel!, cubit);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                  thickness: 2, height: 5, color: Colors.grey);
            },
            itemCount: 1,
          ),

        );
      },
    );
  }
  Widget buildItemModel(context, UserModel model, AppCubit cubit) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Center(child: Text('DWKHBDWJHBWI'),)
          ],

        ),
      ),
    );
  }
}
