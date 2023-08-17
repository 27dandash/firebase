import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var Usermodel = AppCubit
            .get(context)
            .userDataModel!
            .img;
        namecontroller.text = cubit.userDataModel!.name!;
        phonecontroller.text = cubit.userDataModel!.phone!;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(appTranslation(context).updatedata),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    SizedBox(
                  height: 5,
              ),
                  if (state is SocialUpdateDataLoadState)
                LinearProgressIndicator(),
              if (state is SocialUploadprofileImageLoadingState)
        LinearProgressIndicator(),
                    SizedBox(
                      height: 5,
                    ),
              Container(
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    cubit.profileImage == null
                        ? Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(Usermodel!),
                        // backgroundImage: NetworkImage('${Usermodel?.img}'),
                        radius: 90,
                      ),
                    )
                        : Center(
                      child: CircleAvatar(
                        backgroundImage: FileImage(
                          File(
                            cubit.profileImage!.path,
                          ),
                        ),
                        // backgroundImage: NetworkImage('${Usermodel?.img}'),
                        radius: 90,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 60, top: 5),
                      child: IconButton(
                          onPressed: () {
                            cubit.getprofilemage();
                          },
                          icon: const CircleAvatar(
                              radius: 20, child: Icon(Icons.edit))),
                    )
                  ],
                ),
              ),
              defaultFormField(
                  controller: namecontroller,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name can\'t be Empty';
                    }
                    return null;
                  },
                  label: 'Name',
                  prefix: Icons.person),
              SizedBox(
                height: 15,
              ),
              defaultFormField(
                  controller: phonecontroller,
                  type: TextInputType.number,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'phone can\'t be Empty';
                    }
                    return null;
                  },
                  label: 'Phone Number',
                  prefix: Icons.person),
              SizedBox(
                height: 15,
              ),
              defaultFormField(
                  controller: passwordcontroller,
                       // hinttxt: 'Enter our New Password',
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password can\'t be Empty';
                    }
                    return null;
                  },
                  label: 'New Password',
                  prefix: Icons.person),
              SizedBox(
                height: 30,
              ),
              defaultButton(function: () {
                if (formKey.currentState!.validate()) {
                  cubit.updateUser(
                    name: namecontroller.text,
                    phone: phonecontroller.text,
                    password: passwordcontroller.text,
                  );
                }
              }, text: 'Update Data'),
              SizedBox(
                height: 20,
              ),
              defaultButton(function: () {
                if (formKey.currentState!.validate()) {
                  cubit.uploadprofileImage(
                    name: namecontroller.text,
                    phone: phonecontroller.text,
                    password: passwordcontroller.text,
                  );
                }
              }, text: 'Update Photo'),
              ],
          ),
            ),
        ),);
      },
    );
  }
}
