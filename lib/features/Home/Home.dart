import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/item_model.dart';
import 'package:social_app/features/Home/smart_screen.dart';

import 'NotificationPage.dart';
import '../add_item/item_detail.dart';
import 'clothes_screen.dart';

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

        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 4.5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        navigateTo(context, const Smart());
                      },
                      child: Container(
                        width: 80,
                        height: 48,
                        decoration: ShapeDecoration.fromBoxDecoration(
                            BoxDecoration(
                                color: Colors.teal,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(15))),
                        child: const Center(
                          child: Text('Smart',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () {
                        // navigate to clothes screen
                        navigateTo(context, const Clothes());
                      },
                      child: Container(
                        width: 80,
                        height: 48,
                        decoration: ShapeDecoration.fromBoxDecoration(
                            BoxDecoration(
                                color: Colors.teal,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(15))),
                        child: const Center(
                          child: Text('Clothes',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () {
                        //Navigate to other screen
                      },
                      child: Container(
                        width: 80,
                        height: 48,
                        decoration: ShapeDecoration.fromBoxDecoration(
                            BoxDecoration(
                                color: Colors.teal,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(15))),
                        child: const Center(
                          child: Text('Other',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 4.5,),
              Expanded(
                child: ConditionalBuilder(
                  condition: cubit.itemlist.isNotEmpty,
                  builder: (context) {
                    return ListView.separated(
                      // scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),

                      itemBuilder: (context, index) {
                        return buildItemModel(context, cubit.itemlist[index], cubit);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                            thickness: 2, height: 5, color: Colors.grey);
                      },
                      itemCount: cubit.itemlist.length,
                    );
                  },
                  fallback: (context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildItemModel(context, ItemModel model, AppCubit cubit) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ItemDetailsScreen(
              itemmodel: model,
            ));
      },

      child: GestureDetector(

        onTap: () {

          FirebaseFirestore.instance
              .collection('item')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .delete();
          // String  wefc=snapshot.data.docs[index].reference.id;
          // AppCubit.get(context).
          // DeletItem(itemid:'');
        },
        onLongPress: () {
          navigateTo(
              context,
              ItemDetailsScreen(
                itemmodel: model,
              ));
        },
        child: Card(
// borderOnForeground: ,
          color: Colors.white,
          shadowColor: Colors.amberAccent,
          elevation: 50,
          // borderOnForeground: false,
          semanticContainer: true,
          // surfaceTintColor: Colors.black,
          // clipBehavior: Cli,
          child: Container(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 83,
                      child: Image(
                        image: NetworkImage(
                          '${model.itemimg}',
                        ),
                        width: 180,
                        height: 180,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    SizedBox(
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
                              Text(
                                'Description:',
                                // style: Theme.of(context).textTheme.headline6,
                              ),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
