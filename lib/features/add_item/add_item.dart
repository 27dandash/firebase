import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/features/Home/Home.dart';
import 'package:social_app/layout/Home_Layout.dart';

import '../register/cubit/cubit.dart';

class Add_item extends StatefulWidget {
  Add_item({Key? key}) : super(key: key);

  @override
  State<Add_item> createState() => _Add_itemState();
}

class _Add_itemState extends State<Add_item> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _itemnamecontroller = TextEditingController();
  final TextEditingController _itemdescriptincontroller =
      TextEditingController();
  final TextEditingController _itemimgcontroller = TextEditingController();
  final TextEditingController _itemtypecontroller = TextEditingController();
  final TextEditingController _newphoto1controller = TextEditingController();
  final TextEditingController _newphoto2controller = TextEditingController();
  final TextEditingController _newphoto3controller = TextEditingController();
  final TextEditingController _itempricecontroller = TextEditingController();

  var SelectedItem;
  late num SelectedItemPrice;

  @override
  Widget build(BuildContext context) {
    List<String> locations = ['smart', 'clothes', 'Other']; // Option 2
    String? selectedLocation; // Option 2
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SocialUploadNewItemLoadState) {
          showToast(message: 'Uploading', toastStates: ToastStates.SUCCESS);
        }
        if (state is SocialUploadNewItemSuccessState) {
          showToast(message: 'Upload Done', toastStates: ToastStates.SUCCESS);
        }
        if (state is SocialUploadNewItemErrorState) {
          showToast(message: 'Upload Error', toastStates: ToastStates.ERROR);
        }
        // if (state is SocialUploadNewItemSuccessState) {
        //   navigateTo(context, const Home());
        // }
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey,
                          child: DropdownButton(
                            hint: const Text('Please Choose Type'),
                            // Not necessary for Option 1
                            value: SelectedItem,

                            onChanged: (newValue) {
                              setState(() {
                                // selectedLocation = newValue as String?;
                                // selectedLocation = SelectedItem;
                                SelectedItem = newValue;
                                debugPrint(SelectedItem);
                              });
                            },
                            items: locations.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      defaultFormField(
                          controller: _itemnamecontroller,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Item Name must not be empty';
                            }
                            return null;
                          },
                          label: 'Item Name',
                          suffixPressed: () {},
                          prefix: Icons.atm_rounded),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: _itemdescriptincontroller,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'item Description must not be empty';
                            }
                            return null;
                          },
                          label: 'Item Description',
                          suffixPressed: () {},
                          prefix: Icons.atm_rounded),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: _itemimgcontroller,
                          type: TextInputType.text,
                          validate: (String? value) {
                            return null;
                          },
                          label: 'Item img',
                          suffixPressed: () {
                            cubit.getitemImage();
                          },
                          suffix: Icons.camera_alt_outlined,
                          prefix: Icons.atm_rounded),
                      const SizedBox(
                        height: 10,
                      ),
                      AppCubit.get(context).x == false
                          ? Row(
                              children: [
                                Container(
                                  width: 317,
                                  child: defaultFormField(
                                      controller: _newphoto1controller,
                                      type: TextInputType.text,
                                      validate: (String? value) {},
                                      label: 'Item img',
                                      suffixPressed: () {
                                        cubit.getitemImage2();
                                      },
                                      suffix: Icons.camera_alt_outlined,
                                      prefix: Icons.atm_rounded),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changevisibility();
                                      if (kDebugMode) {
                                        print(AppCubit.get(context).x);
                                      }
                                    },
                                    icon: Icon(Icons.minimize_outlined))
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                    'Add Other Photo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    AppCubit.get(context).changevisibility();
                                    if (kDebugMode) {
                                      print(AppCubit.get(context).x);
                                    }
                                  },
                                ),
                              ],
                            ),
                      // const Spacer(),
                      defaultFormField(
                          controller: _itempricecontroller,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'item Pricce must not be empty';
                            }
                            return null;
                          },
                          label: 'Enter The price of your Item',
                          prefix: Icons.atm_rounded),
                      const SizedBox(
                        height: 10,
                      ),
                      if (cubit.itemImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Text('Item Image 1'),
                            Center(
                                child: SizedBox(
                              height: 230,
                              width: 230,
                              child: Image(
                                image: FileImage(
                                  File(
                                    cubit.itemImage!.path,
                                  ),
                                ),
                              ),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50, bottom: 10),
                              child: IconButton(
                                  onPressed: () {
                                    cubit.removeitemphoto();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20, child: Icon(Icons.remove))),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      SizedBox(
                        height: 15,
                      ),

                      if (cubit.itemImage2 != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Text('Item Image 2'),
                            Center(
                                child: SizedBox(
                              height: 230,
                              width: 230,
                              child: Image(
                                image: FileImage(
                                  File(
                                    cubit.itemImage2!.path,
                                  ),
                                ),
                              ),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50, bottom: 10),
                              child: IconButton(
                                  onPressed: () {
                                    cubit.removeitemphoto2();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20, child: Icon(Icons.remove))),
                            )
                          ],
                        ),
                      // const Spacer(),
                      const SizedBox(
                        height: 20,
                      ),

                      ConditionalBuilder(
                          condition: state is! SocialUploadNewItemLoadState,
                          builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.uploaditem(
                                      name: _itemnamecontroller.text,
                                      Description:
                                          _itemdescriptincontroller.text,
                                      type: SelectedItem,
                                      price: _itempricecontroller.text,
                                      photo1: _newphoto1controller.text,
                                    );
                                  }
                                },
                                text: appTranslation(context).uploaditem,
                                isUpperCase: true,
                              ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator())),
                      const SizedBox(
                        height: 65,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
