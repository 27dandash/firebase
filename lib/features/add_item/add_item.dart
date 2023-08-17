import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/features/Home/Home.dart';
import 'package:social_app/layout/Home_Layout.dart';

class New extends StatefulWidget {
  New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _itemnamecontroller = TextEditingController();
  final TextEditingController _itemdescriptincontroller =
      TextEditingController();
  final TextEditingController _itemimgcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SocialUploadNewItemSuccessState) {
          showToast(message: 'Upload Done', toastStates: ToastStates.SUCCESS);
        }
        if (state is SocialUploadNewItemErrorState) {
          showToast(message: 'Upload Error', toastStates: ToastStates.ERROR);
        }
          // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Form(
          key: formKey,
          child: Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Center(
                  child: Text(
                    'Add New Item',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                defaultFormField(
                    controller: _itemnamecontroller,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Item Name must not be empty';
                      }
                    },
                    label: 'Item Name',
                    suffixPressed: () {},
                    prefix: Icons.atm_rounded),
                SizedBox(
                  height: 15,
                ),
                defaultFormField(
                    controller: _itemdescriptincontroller,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'item Description must not be empty';
                      }
                    },
                    label: 'Item Description',
                    suffixPressed: () {},
                    prefix: Icons.atm_rounded),
                SizedBox(
                  height: 15,
                ),
                defaultFormField(
                    controller: _itemimgcontroller,
                    type: TextInputType.text,
                    validate: (String? value) {

                    },
                    label: 'Item img',
                    suffixPressed: () {
                      cubit.getitemImage();
                    },
                    suffix: Icons.camera_alt_outlined,
                    prefix: Icons.atm_rounded),
                Spacer(),
                if(cubit.itemImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [

                      Center(
                          child: Container(
                            height: 230,
                            width: 230,
                            child: Image(image: FileImage(
                              File(
                                cubit.itemImage!.path,
                              ),
                            ),),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, bottom: 10),
                        child: IconButton(
                            onPressed: () {
                              cubit.removeitemphoto();
                            },
                            icon: const CircleAvatar(
                                radius: 20, child: Icon(Icons.remove))),
                      )
                    ],
                  ),
                Spacer(),
                ConditionalBuilder(
                    condition: state is ! SocialUploadNewItemLoadState,
                    builder: (context) => defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          cubit.uploaditem(
                            name: _itemnamecontroller.text,
                            Description: _itemdescriptincontroller.text,
                          );
                        }
                      },
                      text:  appTranslation(context).uploaditem,
                      isUpperCase: true,
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator())),

                SizedBox(
                  height: 65,
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
