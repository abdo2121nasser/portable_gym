import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/l10n.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  static SettingCubit get(context) => BlocProvider.of(context);
  getSettingOptions({
    required context,
  }) {
    return [
      S.of(context).myProfile,
      S.of(context).settings,
      S.of(context).logout,
    ];
  }

}
