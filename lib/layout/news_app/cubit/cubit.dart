
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/business/business_screen.dart';
import 'package:udemy_flutter/modules/science/science_screen.dart';
import 'package:udemy_flutter/modules/sports/sports_screen.dart';
import 'package:udemy_flutter/shared/network/remote/dio/dio_helper.dart';

class AppCubit extends Cubit<AppNewsStates>{
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) =>BlocProvider.of(context);
  List<Widget> Screens =
  [
     const BusinessScreen(),
     const ScienceScreen(),
     const SportsScreen(),

  ];
  int currentIndex = 0;
  List<BottomNavigationBarItem> items=
  [
    const BottomNavigationBarItem(icon: Icon(Icons.business_center,), label: 'Business'),
    const BottomNavigationBarItem(icon:  Icon(Icons.science_outlined,),label: 'Science'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports_baseball,),label: 'Sports'),
  ];
  List<String> titles =
  [
  'Business News ','Science News ','Sports News '
  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    if(index==0)
    {
      getBusiness();
    }

    if(index==1)
    {
      getScience();
    }
    if(index==2)
    {
      getSports();
    }
    emit(NewsBottomNavState());
}

bool isShow = false;

  void ButtomSheet({@required bool isShoww})
  {
    isShow = isShoww;
    emit(AppBottomChangeStats());
  }


  List<dynamic> business =[];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    if(business.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apikey':'c64ccdef1385443a9818d9f1952ee8b4',
        },
      ).then((value)
      {
        business =value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((onError){
      });
      emit(NewsGetBusinessErrorState(onError.toString()));

    }
    else{
      NewsGetBusinessSuccessState();
    }
    }

  List<dynamic> science =[];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey':'c64ccdef1385443a9818d9f1952ee8b4',
        },
      ).then((value)
      {
        science =value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((onError){
        print(onError.toString());});
      emit(NewsGetScienceErrorState(onError.toString()));

    }
    else{
      NewsGetScienceSuccessState();
    }

  }

  List<dynamic> sports =[];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apikey':'c64ccdef1385443a9818d9f1952ee8b4',
        },
      ).then((value)
      {
        sports =value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((onError){
        print(onError.toString());});
      emit(NewsGetSportsErrorState(
          onError.toString()));
    }
    else{
      NewsGetSportsSuccessState();
    }



  }



  List<dynamic> search =[];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':value,
        'apikey':'c64ccdef1385443a9818d9f1952ee8b4',
      },
    ).then((value)
    {
      search =value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((onError){

      emit(NewsGetSearchErrorState(onError.toString()));
    });

  }
}