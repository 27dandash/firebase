class ItemModel {
  String? itemname;
  String? itemimg;
  String? itemdescribtion;
  String? price;
  String? discount;
  String? type;
  String? photo1;
  String? photo2;
  String? photo3;

  ItemModel({
    this.itemname,
    this.itemimg,
    this.itemdescribtion,
    this.type,
    this.price,
    this.discount,
    this.photo1,
    this.photo2,
    this.photo3,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemname = json['itemname'];
    itemimg = json['itemimg'];
    itemdescribtion = json['itemdescribtion'];
    type = json['type'];
    price = json['price'];
    discount = json['discount'];
    photo1 = json['photo1'];
    photo2 = json['photo2'];
    photo3 = json['photo3'];
  }

  Map<String, dynamic> toMap() {
    return {
      'itemname': itemname,
      'itemimg': itemimg,
      'itemdescribtion': itemdescribtion,
      'type': type,
      'price': price,
      'discount': discount,
      'photo1': photo1,
      'photo2': photo2,
      'photo3': photo3,
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
