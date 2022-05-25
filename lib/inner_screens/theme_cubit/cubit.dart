import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/inner_screens/theme_cubit/state.dart';

import '../../shared/local/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

//creatobject from bloc =>
  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemChangeModeState());
    } else
      isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(ThemChangeModeState());
    });
  }
}