import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchC = TextEditingController();

  SearchScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppNewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list =AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchC,
                    type: TextInputType.text,
                    onChange: (value)
                    {
                      AppCubit.get(context).getSearch(value);
                    },
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'search must not be empty' ;
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),

            ],
          ),
        );
      },


    );
  }
}
