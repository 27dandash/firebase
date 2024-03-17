import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/components/components.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/core/model/id_model.dart';
import 'package:social_app/core/model/item_model.dart';
import 'package:social_app/core/model/message_model.dart';
import 'package:social_app/core/model/user_model.dart';
import 'package:social_app/features/add_item/add_item.dart';
import 'package:social_app/features/cart/cart.dart';
import 'package:social_app/features/chat/all_users_acconts.dart';
import 'package:social_app/features/setting/setting%20screen.dart';
import '../../features/Home/Home.dart';
import '../../translation.dart';
import '../components/constants.dart';
import '../network/local/SharedPreferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

/////////////////////////////////////////////////////////////////Start of Cubit

/*
فاضل زرار ال + علشان اودي ال item  لل cart
و ارفع ال picked Item Image  مع ال  Item  اللي بيترفع
واظبط صفحه ال Cart
حل مشكله الصوره اللي مش بتظهر علظول لما بخرها من الجاليري لازم اغير الصفحه وارجعلها علشان تظهر
 اعمل pagination  للداتا افللي بتيجي ال Home

*/
  // UserModel? userDataModel;
  ItemModel? itemModel;
  ItemModel? cartModel;

  IconData suffix = Icons.visibility_rounded;
  bool isPasswordShow = true;
  int currentIndex = 0;
  int? maxLines;
  bool seeMore = true;
  bool x = true;

  void changevisibility() {
    x = !x;

    emit(ShowMoreState());
  }

  List<Widget> bottomScreen = [
    // const HomeScreen(),
    const HomeScreen(),
    users_home(),
    Add_item(),
    CartScreen(),
    const Setting()
  ];
  List<String> Titels = [
    'Items',
    'Users',
    'Add',
    'Cart',
    'Setting',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(SocialChangeBottemNavigationState());
  }

  // ----------------------------------------- AppTheme
  bool appTheme = false;

  void onchangeappmode({bool? formShared}) {
    emit(ChangeThemeloadState());
    if (formShared != null) {
      appTheme = formShared;
      emit(ChangeThemeSuccessState());
    } else {
      appTheme = !appTheme;
      CacheHelper.saveData(key: 'Isdark', value: appTheme).then((value) {
        emit(ChangeThemeSuccessState());
      });
    }
  }

// ---------------------------------------- language
  void changeLanguage() async {
    isRtl = !isRtl;
    CacheHelper.saveData(key: 'isRtl', value: isRtl);
    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguageState());
  }

// ---------------------------------------- Translation

  late TranslationModel translationModel;

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));
    emit(LanguageLoaded());
  }

  // ------------------------------------ no internet

  bool noInternetConnection = false;

  void checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint('Internet Connection ------------------------');
      debugPrint(noInternetConnection.toString());
      debugPrint('${result.index}');
      debugPrint(result.toString());
      if (result.index == 0 || result.index == 1) {
        noInternetConnection = false;
      } else if (result.index == 2) {
        noInternetConnection = true;
      }

      emit(InternetState());
    });
  }

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      noInternetConnection = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      noInternetConnection = false;
    } else {
      noInternetConnection = true;
    }
    emit(InternetState());
  }

//////////////////////////////////////////////descriptionView                                      (Done)

  void descriptionView() {
    if (seeMore) {
      maxLines = null;
      seeMore = false;
      emit(ShowMoreState());
    } else {
      maxLines = 6;
      seeMore = true;
      emit(ShowMoreState());
    }
  }

//////////////////////////////////////////////How to  Get one image from Firebase                  (Done)

  void GetOneImage() {
    FirebaseFirestore.instance.collection('item').doc('aa').get().then((value) {
      itemModel = ItemModel.fromJson(value.data()!);
    }).catchError((error) {});
  }

///////////////////////////////////////////////////////////////Get All User Data from Firebase         (Done)

  List<UserModel> users = [];

  void getUserData() {
    emit(SocialGetUserDataLoadState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .get()
        .then((value) {
      debugPrint('============data=============${value.data()!}');
      userModel = UserModel.fromJson(value.data()!);

      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

/////////////////////////////////////////////////////////////////Get All Images from Firebase         (Done)

  List<ItemModel> itemlist = [];

  void GetAllItems() {
    itemlist = [];
    emit(SocialGetImageLoadState());
    FirebaseFirestore.instance
        .collection('item')
// .doc()
        .get()
        .then((value) {
      value.docs.forEach((value) {
        // if (value.data()['uId'] != userModel!.uId) {
        itemModel = ItemModel.fromJson(value.data());
        itemlist.add(itemModel!);
        // print('=================data================== ${itemModel!.itemname!}');
      });
      emit(SocialGetImageSuccessState());
    }).catchError((error) {
      emit(SocialGetImageErrorState(error.toString()));
    });
  }

///////////////////////////////////////////////////////////// Update User Data

  void updateUser({
    required String name,
    required String phone,
    required String password,
    String? img,
  }) {
    emit(SocialUpdateDataLoadState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: userModel!.email,
      img: img ?? userModel!.img,
      password: password,
      uId: userModel!.uId,
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(SocialUpdateDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateDataErrorState(error.toString()));
    });
  }

/////////////////////////////////////////////////////////////// Pick Profile Image  (Done)
  final profilepicker = ImagePicker();
  File? profileImage;

  Future<void> getprofilemage() async {
    final pickedFile =
        await profilepicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile!.path);
      print('#################################3');
      print(profileImage!.path);
      // emit(SocialCoverImagePickedSuccessState());
    } else {
      showToast(message: 'No Image Selected', toastStates: ToastStates.ERROR);
      print('No Image Selected');

      // emit(SocialCoverImagePickedErrorState());
    }
  }

// ----------------------------------------- Upload Profile Image                         (Done)
  void uploadprofileImage({
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialUploadprofileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, img: value, password: password);
        emit(SocialUploadprofileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadprofileImageErrorState(error.toString()));

        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadprofileImageErrorState(error.toString()));

      print(error.toString());
    });
  }

/////////////////////////////////////////////////////////////// Pick Item Image 1             (Done)
  final itempicker = ImagePicker();
  File? itemImage;

  Future<void> getitemImage() async {
    final pickedFile = await itempicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      itemImage = File(pickedFile.path);
      print('#################################3');
      print(itemImage!.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      showToast(message: 'No Image Selected', toastStates: ToastStates.ERROR);
      print('No Image Selected');

      emit(SocialCoverImagePickedErrorState('error'));
    }
  }

  /////////////////////////////////////////////////////////////// Pick Item Image 2            (Done)
  File? itemImage2;

  Future<void> getitemImage2() async {
    final pickedFile = await itempicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      itemImage2 = File(pickedFile.path);
      print('#################################3');
      print(itemImage2!.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      showToast(message: 'No Image Selected', toastStates: ToastStates.ERROR);
      print('No Image Selected');

      emit(SocialCoverImagePickedErrorState('error'));
    }
  }

//////////////////////////////////////////////////////////Remove Picked Item Image 1        (Done)
  void removeitemphoto() {
    itemImage = null;
    emit(RemoveImageState());
  }

  //////////////////////////////////////////////////////////Remove Picked Item Image 2       (Done)
  void removeitemphoto2() {
    itemImage2 = null;
    emit(RemoveImageState());
  }

  // IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

////////////////////////////////////////////////////////////// Upload Item Image         (Done)

  Future<String> uploaditemimage() async {
    var snapshot = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('item/${Uri.file(itemImage!.path).pathSegments.last}')
        .putFile(itemImage!);
    return await snapshot.ref.getDownloadURL();
  }

//////////////////////////////////////////////////////////////// Upload New Item Data
  Future<void> uploaditem({
    required String name,
    required String Description,
    required String type,
    required String price,
    String? photo1,
  }) async {
    emit(SocialUploadNewItemLoadState());
    String imgurl = await uploaditemimage();
    print(imgurl);
    ItemModel model = ItemModel(
      itemname: name,
      itemdescribtion: Description,
      itemimg: imgurl,
      type: type,
      price: price,
      photo1:
          'https://th.bing.com/th/id/OIP.QEFNA8eb-0yFAtnQRBhnywHaLG?pid=ImgDet&rs=1',
      photo2:
          'https://th.bing.com/th/id/R.2702e38c6e4f9f442ac78672f04a9f2b?rik=lHZy2W3RyQ0bvA&pid=ImgRaw&r=0',
      photo3:
          'https://th.bing.com/th/id/R.d6f6421e5db0a10e369a6646517e1c6b?rik=K8tN5lszqey7zQ&pid=ImgRaw&r=0',
    );
    FirebaseFirestore.instance
        .collection('item')
        // اي لاومه ال doc
        .doc()
        .collection('more')
        .doc(token)
        .set(
            {
          'photo':
              'https://th.bing.com/th/id/OIP.2QQF_qIerhVaDfIef6G7fwHaFj?pid=ImgDet&rs=1'
        },
            await FirebaseFirestore.instance
                .collection('item')
                .doc()
                .set(model.toMap())
                .then((value) {
              emit(SocialUploadNewItemSuccessState());
            }).catchError((error) {
              print(error.toString());
              emit(SocialUploadNewItemErrorState(error.toString()));
            }));
  }

  void addtocrt(ItemModel model) {
    FirebaseFirestore.instance.collection('cart').doc().set(model.toMap());
    emit(SocialAddtocartSuccessState());
  }

  List<ItemModel> cart = [];

  void GetCrt() {
    cart = [];
    emit(SocialGetcartLoadState());
    FirebaseFirestore.instance
        .collection('cart')
// .doc()
        .get()
        .then((value) {
      value.docs.forEach((value) {
        // if (value.data()['uId'] != userModel!.uId) {
        cart.add(ItemModel.fromJson(value.data()));
        cartModel = ItemModel.fromJson(value.data());
        // print(
        //     '===============cartModel==================== ${cartModel?.itemname}');
        // }
      });
      emit(SocialGetcartSuccessState());
    }).catchError((error) {
      emit(SocialGetcartErrorState(error.toString()));
    });
  }

  List<UserModel> allusers = [];

  void getAllUsers() {
    // if(users.length==0)   //users بردو بنفي ليسته
    allusers = [];
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != token) {
          // if (element.data()['uId'] != userModel!.uId) {
          allusers.add(UserModel.fromJson(element.data()));
          //
          // print("allusershere");
          // print(userModel?.uId);
          // print(allusers);
        }
      });
      emit(SocialGetUserDataSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserDataErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  //----------------------------------GetSmartImages------------------------------Done
  List<ItemModel> smartitem = [];

  void GetSmartImages() {
    smartitem = [];
    emit(SocialGetImageLoadState());
    FirebaseFirestore.instance
        .collection('item')
// .doc()
        .where('type', isEqualTo: 'smart')
        .get()
        .then((value) {
      value.docs.forEach((value) {
        // if (value.data()['uId'] != userModel!.uId) {
        smartitem.add(ItemModel.fromJson(value.data()));
        itemModel = ItemModel.fromJson(value.data());
        print('=================================== smartitem');
        print('=================================== ${itemModel?.itemname}');
        print('=================================== ${itemModel?.itemimg}');
        // print('=================================== ${itemModel![value][1]}');

        // }
      });
      emit(SocialGetImageSuccessState());
    }).catchError((error) {
      emit(SocialGetImageErrorState(error.toString()));
    });
  }

  //----------------------------------GetclothesImages------------------------------Done
  List<ItemModel> clothesitem = [];

  void GetClothesImages() {
    clothesitem = [];
    emit(SocialGetImageLoadState());
    FirebaseFirestore.instance
        .collection('item')
// .doc()
        .where('type', isEqualTo: 'clothes')
        .get()
        .then((value) {
      value.docs.forEach((value) {
        // if (value.data()['uId'] != userModel!.uId) {
        clothesitem.add(ItemModel.fromJson(value.data()));
        itemModel = ItemModel.fromJson(value.data());
        print('=================================== clothesitem');
        print('=================================== ${itemModel?.itemname}');
        print('=================================== ${itemModel?.itemimg}');
        // print('=================================== ${itemModel![value][1]}');

        // }
      });
      emit(SocialGetImageSuccessState());
    }).catchError((error) {
      emit(SocialGetImageErrorState(error.toString()));
    });
  }

  //----------------------------------Delet Item------------------------------

  // void DeletItem({required String itemid}) {
  //   FirebaseFirestore.instance
  //       .collection('item')
  //       .doc(itemid)
  //       .delete()
  //       .then((value) => {
  //             emit(SocialDeleteItemSuccessState()),
  //             showToast(
  //                 message: 'Delete Done', toastStates: ToastStates.SUCCESS),
  //           })
  //       .catchError((onError) {
  //     emit(SocialDeleteItemErrorState(onError.toString()));
  //     showToast(
  //         message: 'Error Happened While Delete',
  //         toastStates: ToastStates.SUCCESS);
  //   });
  // }

  //----------------------------------Delet Message------------------------------

  // void DeletMessage({required String userid}) {
  //   FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(token)
  //
  //
  //       .delete()
  //       .then((value) => {
  //             emit(SocialDeleteItemSuccessState()),
  //             showToast(
  //                 message: 'Delete Done', toastStates: ToastStates.SUCCESS),
  //           })
  //       .catchError((onError) {
  //     emit(SocialDeleteItemErrorState(onError.toString()));
  //     showToast(
  //         message: 'Error Happened While Delete',
  //         toastStates: ToastStates.SUCCESS);
  //   });
  // }

  // -------------------- send Message  -------------------------------------Done
  UserModel? userModel;

  void sendMessage({
    required String recivreId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      recivreId: recivreId,
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recivreId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState(onError.toString()));
    });
    FirebaseFirestore.instance
        .collection('user')
        .doc(recivreId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState(onError.toString()));
    });
  }

  // -------------------- Get Message  --------
  List<MessageModel> messages = [];

//جرب ترفع صوره ف صقحه الشات وتبعتها
  void getMessages({
    required String recivreId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .collection('chats')
        .doc(recivreId)
        .collection('message')
        //بترتب  حسب ال Date Time
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      print("event.docs[0]");
      print(event.docs[0]);
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit((SocialgetMessageSuccessState()));
    });
  }
}
