// // import 'package:social_app/core/model/item_model.dart';
// //
//
// /*
// The Method
// List<IdModel> datalist = [];
// void GetAllItems() {
//   datalist = [];
//   emit(SocialGetImageLoadState());
//   FirebaseFirestore.instance
//       .collection('item')
// // .doc()
//       .get()
//       .then((value) {
//     value.docs.forEach((value) {
//       // if (value.data()['uId'] != userModel!.uId) {
//
//       itemModel = ItemModel.fromJson(value.data());
//       datalist.add(IdModel(id: value.reference.id, itemModel: itemModel!));
//       print('=================data================== ${itemModel!.itemname!}');
//       print('=================datalist================== ${datalist[1].id}');
//       print(datalist[0].itemModel?.itemname!);
//       // print(itemModel!.itemname!);
//       // print(itemModel!.itemname!);
//       // }
//     });
//     emit(SocialGetImageSuccessState());
//   }).catchError((error) {
//     emit(SocialGetImageErrorState(error.toString()));
//   });
// }
//
// *\
// // class IdModel {
// //   String? id;
// //   ItemModel? itemModel;
// //
// //   IdModel({
// //     this.id, ItemModel ? itemModel,
// //   });
// //
// //   IdModel.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     itemModel = json['itemModel'];
// //   }
// //
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'itemModel': itemModel,
// //     };
// //   }
// // }
