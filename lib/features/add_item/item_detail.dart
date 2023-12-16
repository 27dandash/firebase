import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/item_model.dart';
import 'package:social_app/core/model/user_model.dart';

class ItemDetailsScreen extends StatelessWidget {
  ItemDetailsScreen({Key? key, required this.itemmodel}) : super(key: key);

  ItemModel itemmodel;

  var MessageControler = TextEditingController();

  // ChatDetailsScreen(this.usermodel);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      print(itemmodel.photo1);
      print('usermodel.photo1');
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage(
                          itemmodel.itemimg!,
                        ),
                        width: double.infinity,
                        height: 480,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text('${itemmodel.itemname}'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Item Name:',
                                style: TextStyle(color: Colors.orange),

                              ),
                              Text(
                                itemmodel.itemname!,
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: AppCubit.get(context).maxLines,
                              ),
                              Text(
                                itemmodel.itemname!,
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: AppCubit.get(context).maxLines,
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Text(
                              'Item Description:',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              itemmodel.itemdescribtion!,
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: AppCubit.get(context).maxLines,
                            ),
                          ],
                        ),
                          // if(AppCubit.get(context).maxLines!>=10)
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: defaultTextButton(
                                text: AppCubit.get(context).seeMore
                                    ? 'read more'
                                    : 'read less',
                                function: () {
                                  AppCubit.get(context).descriptionView();
                                }),
                          ),
                          itemmodel.photo1 != null
                              ? CircleAvatar(
                                  radius: 120,
                                  backgroundImage:
                                      NetworkImage('${itemmodel.photo1}'),
                                )
                              : SizedBox(
                                  height: 15,
                                ),
                          itemmodel.photo2 != null
                              ? CircleAvatar(
                                  radius: 120,
                                  backgroundImage:
                                      NetworkImage('${itemmodel.photo2}'),
                                )
                              : SizedBox(
                                  height: 15,
                                ),
                          itemmodel.photo3 != null
                              ? CircleAvatar(
                                  radius: 120,
                                  backgroundImage:
                                      NetworkImage('${itemmodel.photo3}'),
                                )
                              : SizedBox(
                                  height: 15,
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
