import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/item_model.dart';
import 'package:social_app/core/model/user_model.dart';

import 'chat_details.dart';
import 'my chat details.dart';

class users_home extends StatefulWidget {
  const users_home({Key? key}) : super(key: key);

  @override
  State<users_home> createState() => _users_homeState();
}

class _users_homeState extends State<users_home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: cubit.allusers.isNotEmpty,
            builder: (context) {
              return Column(
                children: [
                  Container(
                    height: 653,
                    child: ListView.separated(
                      // scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),

                      itemBuilder: (context, index) {
                        return buildItemModel(context, cubit.allusers[index], cubit);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                            thickness: 2, height: 5, color: Colors.grey);
                      },
                      itemCount: cubit.allusers.length,
                    ),
                  ),
                ],
              );
            },
            fallback: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }

  Widget buildItemModel(context, UserModel model, AppCubit cubit) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ChatDetailsScreen(
             userModel: model,
            ));
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      '${model.img}',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 190,
                    child: RichText(
                      overflow: TextOverflow.clip,

                      // Controls how the text should be aligned horizontally
                      textAlign: TextAlign.end,

                      // Control the text direction
                      textDirection: TextDirection.rtl,

                      // Whether the text should break at soft line breaks
                      softWrap: true,

                      // Maximum number of lines for the text to span
                      maxLines: 1,

                        text: TextSpan(

                            text: model.name,
                            style: TextStyle(color: Colors.black),),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
