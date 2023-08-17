import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/constants.dart';
import 'package:social_app/core/cubit/cubit.dart';
import 'package:social_app/core/cubit/state.dart';
import 'package:social_app/features/InternetConnectionPage.dart';

import '../core/components/components.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: BuildCondition(
              condition: !AppCubit.get(context).noInternetConnection,
              builder: (context) => Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  // backgroundColor: Colors.orange,
                  title: Text(cubit.Titels[cubit.currentIndex]),

                ),
                body: cubit.bottomScreen[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottom(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_max_rounded), label: "Items"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.drag_indicator), label: "Add "),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart), label: "Cart "),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "settings"),
                  ],
                ),
              ),
              fallback: (context) => const InternetConnectionPage(),
            ));
      },
    );
  }
}
