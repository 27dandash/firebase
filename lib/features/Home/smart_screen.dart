import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/item_model.dart';
import '../add_item/item_detail.dart';

class Smart extends StatelessWidget {
  const Smart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Smart',),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: cubit.smartitem.isNotEmpty,
            builder: (context) {
              return ListView.separated(
                // scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),

                itemBuilder: (context, index) {
                  return buildSmartItem(context, cubit.smartitem[index], cubit);
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                      thickness: 2, height: 5, color: Colors.grey);
                },
                itemCount: cubit.smartitem.length,
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
                            Text('Name : ${model.itemname}',maxLines: 1,),
                            // Text(
                            //   'Description:',
                            //   // style: Theme.of(context).textTheme.headline6,
                            // ),
                            Text('Description : ${model.itemdescribtion}'),
                            Text('Type : ${model.type}'),
                            // Text(
                            //   model.itemdescribtion!,
                            //
                            //   // style: Theme.of(context).textTheme.bodyText1,
                            //   maxLines: 4,
                            // ),
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
