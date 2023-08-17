import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/item_model.dart';

import 'item_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.item.isNotEmpty,
          builder: (context) {
            return ListView.separated(
              // scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildItemModel(context, cubit.item[index],cubit);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                    thickness: 2, height: 5, color: Colors.grey);
              },
              itemCount: cubit.item.length - 1,
            );
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget buildItemModel(context, ItemModel model,AppCubit cubit) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ChatDetailsScreen(
              usermodel: model,
            ));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                  '${model.itemimg}',
                ),
                width: 180,
                height: 180,
                fit: BoxFit.fill,
              ),
              Container(
                height: 184,
                width: 184,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Name : '),
                        Text(
                          '${model.itemname}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Text('Description : '),
                    Row(
                      children: [
                        Container(
                          width: 184,
                          child: Text(
                            model.itemdescribtion!,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          // radius: 20,
                          child: IconButton(
                            onPressed: () {
                              cubit.addtocrt(model);
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
