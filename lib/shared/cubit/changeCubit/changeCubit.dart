import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../network/local/cache_helper.dart';
import 'changeStates.dart';

class AppCubitt extends Cubit<AppChangeStates>{
AppCubitt() : super(AppInitiallStates());
static AppCubitt get(context) =>BlocProvider.of(context);

bool isDark = false ;
void changeAppMode({bool fromShared})
{
  if(fromShared != null) {
    isDark = fromShared;
    emit(AppChaneModeState());
  } else {
    isDark = !isDark;

  CacheHelper.putData(key: 'isDark', value: isDark).then(
          (value) {
        emit(AppChaneModeState());

      });
  }

}
}