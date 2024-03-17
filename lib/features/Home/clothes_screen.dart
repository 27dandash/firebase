import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/item_model.dart';
import 'package:social_app/features/Home/smart_screen.dart';

import '../add_item/item_detail.dart';

class Clothes extends StatelessWidget {
  const Clothes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: cubit.clothesitem.isNotEmpty,
            builder: (context) {
              return Column(
                children: [
                  Container(
                    height: 766,
                    child: ListView.separated(
                      // scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),

                      itemBuilder: (context, index) {
                        return buildSmartItem(
                            context, cubit.clothesitem[index], cubit);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                            thickness: 2, height: 5, color: Colors.grey);
                      },
                      itemCount: cubit.clothesitem.length,
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

  Widget buildSmartItem(context, ItemModel model, AppCubit cubit) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ItemDetailsScreen(
              itemmodel: model,
            ));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            children: [
              Row(
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
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    height: 181,
                    width: 175,
                    child: Column(
                      children: [
                        // Text('Name : ${model.itemname}'),
                        // Text('Description : ${model.itemdescribtion}'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name : ${model.itemname}'),
                            Text('Description : ${model.itemdescribtion}'),
                            Text('Type : ${model.type}'),
                            // Text(
                            //   'Description:',
                            //   // style: Theme.of(context).textTheme.headline6,
                            // ),
                            Text(
                              model.itemdescribtion!,

                              // style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 4,
                            ),
                            Text('Price : ${model.price} '),
                            Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 15,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.addtocrt(model);
                                        showToast(
                                            message: 'Added Successful',
                                            toastStates: ToastStates.SUCCESS);
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Add To Cart')
                              ],
                            ),
                            defaultTextButton(
                                text: AppCubit.get(context).seeMore
                                    ? 'read more'
                                    : 'read less',
                                function: () {
                                  navigateTo(
                                      context,
                                      ItemDetailsScreen(
                                        itemmodel: model,
                                      ));
                                }),
                          ],
                        ),
                      ],
                    ),
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
