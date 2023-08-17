class ItemModel {
  String? itemname;
  String? itemimg;
  String? itemdescribtion;

  ItemModel({
    this.itemname,
    this.itemimg,
    this.itemdescribtion,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemname = json['itemname'];
    itemimg = json['itemimg'];
    itemdescribtion = json['itemdescribtion'];
  }

  Map<String, dynamic> toMap() {
    return {
      'itemname': itemname,
      'itemimg': itemimg,
      'itemdescribtion': itemdescribtion,
    };
  }
}


// ///////////////////////////////////////////////////////////// A Model To Get 1 Image
// class ItemModel {
//   // String? itemname;
//   String? itemimg;
//   // String? itemdescribtion;
//
//   ItemModel({
//     // this.itemname,
//     this.itemimg,
//     // this.itemdescribtion,
//   });
//
//   ItemModel.fromJson(Map<String, dynamic> json) {
//     // itemname = json['name'];
//     itemimg = json['img'];
//     // itemdescribtion = json['bio'];
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       // 'name': itemname,
//       'img': itemimg,
//       // 'bio': itemdescribtion,
//     };
//   }
// }
