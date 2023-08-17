import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/core/network/local/SharedPreferences.dart';
import 'package:social_app/features/login/cubit/cubit.dart';
import 'package:social_app/features/register/signup.dart';
import 'package:social_app/layout/Home_Layout.dart';
import '../../core/components/components.dart';
import '../../core/components/constants.dart';
import '../../core/cubit/cubit.dart';
import '../../core/cubit/state.dart';
import '../InternetConnectionPage.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SocialLoginCubit(),
  child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
      listener: (context, state) {

        if(state is SocialLoginSuccessState){
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            navigateFinish(context, const Home());
            showToast(toastStates: ToastStates.SUCCESS, message:appTranslation(context).logindone);
          });
        }
        if(state is SocialLoginErrorState){
          showToast(toastStates: ToastStates.ERROR, message:appTranslation(context).loginerror);
        }
        if(state is SocialLoginLoadState){
          showToast(toastStates: ToastStates.WARNING, message:appTranslation(context).loginload);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,

          child: Scaffold(

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appTranslation(context).login,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label:appTranslation(context).email,
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          validate: (String ?  value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          onSubmit: (value){
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userlogin(
                                  email:  emailController.text,
                                  password: passwordController.text);
                            }},
                          label: appTranslation(context).pass,
                          prefix: Icons.lock,

                          suffix:AppCubit.get(context).suffix,

                          isPassword: isPassword,
                          suffixPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          type: TextInputType.visiblePassword,
                          validate: (String ?value) {
                            if (value!.isEmpty) {
                              return 'You have enter Password';
                            }

                            return null;
                            //'You Password is wrong';
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                            condition: state is !SocialLoginLoadState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userlogin(
                                      email:  emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: appTranslation(context).login,
                              isUpperCase: true,
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 20.0,
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              appTranslation(context).no_account,
                            ),
                            TextButton(
                              onPressed: () {
                               navigateTo(context, Signup());
                              },
                              child: Text(
                                appTranslation(context).register,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
);
  }
}
