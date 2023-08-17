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
import 'package:social_app/core/model/item_model.dart';
import 'package:social_app/core/model/user_model.dart';
import 'package:social_app/features/add_item/add_item.dart';
import 'package:social_app/features/cart/cart.dart';
import 'package:social_app/features/register/signup.dart';
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
  UserModel? userDataModel;
  ItemModel? itemModel;
  ItemModel? cartModel;

  IconData suffix = Icons.visibility_rounded;
  bool isPasswordShow = true;
  int currentIndex = 0;
  int? maxLines;
  bool seeMore = true;

  List<Widget> bottomScreen = [
    // const HomeScreen(),
    const HomeScreen(),
    New(),
    CartScreen(),
    const Setting()
  ];
  List<String> Titels = [
    'Items',
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

//////////////////////////////////////////////How to  Get one image from Firebase                  (Done)

///////////////////////////////////////////////////////////////Get All User Data from Firebase         (Done)

  List<UserModel> users = [];

  void getUserData() {
    emit(SocialGetUserDataLoadState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(token)
        .get()
        .then((value) {
      print('============data=============${value.data()!}');
      userDataModel = UserModel.fromJson(value.data()!);
      print('============img=============');
      print(userDataModel!.img);
      print(userDataModel!.uId);
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

/////////////////////////////////////////////////////////////////Get All Images from Firebase         (Done)

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
      email: userDataModel!.email,
      img: img ?? userDataModel!.img,
      password: password,
      uId: userDataModel!.uId,
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

/////////////////////////////////////////////////////////////// Pick Item Image              (Done)
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

//////////////////////////////////////////////////////////Remove Picked Item Image         (Done)
  void removeitemphoto() {
    itemImage = null;
    emit(RemoveImageState());
  }

////////////////////////////////////////////////////////////// Upload Item Image         (Done)

  Future<String> uploadimage() async {
    var snapshot = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('item/${Uri.file(itemImage!.path).pathSegments.last}')
        .putFile(itemImage!);
    return await snapshot.ref.getDownloadURL();
  }

  void uploaditemImage({
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialUploadItemImageLoadingState());

    //     // emit(SocialUploadCoverImageSuccessState());
    //     print(value);
    //     updateUser(name: name, phone: phone, img: value, password: password);
    //     emit(SocialUploadItemImageSuccessState());
    //   }).catchError((error) {
    //     emit(SocialUploadItemImageErrorState(error.toString()));
    //
    //     print(error.toString());
    //   });
    // }).catchError((error) {
    //   emit(SocialUploadItemImageErrorState(error.toString()));
    //
    //   print(error.toString());
    // });
  }

//////////////////////////////////////////////////////////////// Upload New Item Data
  Future<void> uploaditem({
    required String name,
    required String Description,
    String? img,
  }) async {
    emit(SocialUploadNewItemLoadState());
    String imgurl = await uploadimage();
    print(imgurl);
    print('@@@@@@@@@@@@@@@@@@@@@@');
    ItemModel model = ItemModel(
      itemname: name,
      itemdescribtion: Description,
      itemimg: imgurl,
    );
    await FirebaseFirestore.instance
        .collection('item')
        .doc(token)
        .set(model.toMap())
        .then((value) {
      emit(SocialUploadNewItemSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadNewItemErrorState(error.toString()));
    });
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
        print('===============cartModel==================== ${cartModel?.itemname}');
        // }
      });
      emit(SocialGetcartSuccessState());
    }).catchError((error) {
      emit(SocialGetcartErrorState(error.toString()));
    });
  }

  void GetOneImage() {
    FirebaseFirestore.instance.collection('item').doc('aa').get().then((value) {
      itemModel = ItemModel.fromJson(value.data()!);
    }).catchError((error) {});
  }

  List<ItemModel> item = [];

  void GetImages() {
    item = [];
    emit(SocialGetImageLoadState());
    FirebaseFirestore.instance
        .collection('item')
// .doc()
        .get()
        .then((value) {
      value.docs.forEach((value) {
        // if (value.data()['uId'] != userModel!.uId) {
        item.add(ItemModel.fromJson(value.data()));
        itemModel = ItemModel.fromJson(value.data());
        // print('=================================== ${itemModel?.itemname}');
        // }
      });
      emit(SocialGetImageSuccessState());
    }).catchError((error) {
      emit(SocialGetImageErrorState(error.toString()));
    });
  }
}
