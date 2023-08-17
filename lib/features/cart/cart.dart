// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app/core/cubit/cubit.dart';
// import 'package:social_app/core/cubit/state.dart';
// import 'package:social_app/core/model/item_model.dart';
//
// class Cart extends StatefulWidget {
//   const Cart({Key? key}) : super(key: key);
//
//   @override
//   State<Cart> createState() => _CartState();
// }
//
// class _CartState extends State<Cart> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = AppCubit.get(context);
//         return ConditionalBuilder(
//           condition: cubit.cart.isNotEmpty,
//           builder: (context) {
//             return ListView.separated(
//               // scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return buildItem(context, cubit.item[index]);
//               },
//               separatorBuilder: (context, index) {
//                 return const Divider(
//                     thickness: 2, height: 5, color: Colors.grey);
//               },
//               itemCount: cubit.cart.length ,
//             );
//           },
//           fallback: (context) {
//             return const Center(child: CircularProgressIndicator());
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildItem(
//     context,
//     ItemModel model,
//   ) {
//     return InkWell(
//       onTap: () {},
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Directionality(
//           textDirection: TextDirection.ltr,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image(
//                 image: NetworkImage(
//                   '${model.itemimg}',
//                 ),
//                 width: 180,
//                 height: 180,
//                 fit: BoxFit.fill,
//               ),
//               Container(
//                 height: 184,
//                 width: 184,
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text('Name : '),
//                         Text(
//                           '${model.itemname}',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       ],
//                     ),
//                     Text('Description : '),
//                     Row(
//                       children: [
//                         Container(
//                           width: 184,
//                           child: Text(
//                             model.itemdescribtion!,
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/components.dart';
import '../../core/cubit/cubit.dart';
import '../../core/cubit/state.dart';
import '../../core/model/item_model.dart';
import '../Home/item_detail.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListView.separated(
          // scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return buildItemModel(context, cubit.item[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(
                thickness: 2, height: 5, color: Colors.grey);
          },
          itemCount: cubit.item.length-1,
        );
      },
    );
  }

  Widget buildItemModel(context, ItemModel model) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ChatDetailsScreen(
              usermodel: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                  '${model.itemimg}',
                ),
                width: 180,
                height: 180,
                fit: BoxFit.fill,
              ),
              Container(
                height: 184,
                width: 184,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Name : '),
                        Text(
                          '${model.itemname}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Text('Description : '),
                    Row(
                      children: [
                        Container(
                          width: 184,
                          child: Text(
                            model.itemdescribtion!,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
