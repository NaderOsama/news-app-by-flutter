
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/search/search_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/changeCubit/changeCubit.dart';

class NewsLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppNewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: ()
                {
                  navigateTo(context, SearchScreen(),);
                },
              ),
              IconButton(
                icon:  const Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: () {
                 AppCubitt.get(context).changeAppMode();

                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isShow) {
                Navigator.pop(context);
                isShow = false;
              } else {
                scaffoldKey.currentState.showBottomSheet(
                  (context) => Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ).closed;
                isShow = true;
              }
            },
            child: const Icon(Icons.settings),
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
