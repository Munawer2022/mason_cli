import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_initial_params.dart';
import 'bottom_nav_navigator.dart';
import 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  final BottomNavNavigator navigator;
  final BottomNavInitialParams initialParams;
  BottomNavCubit(this.initialParams, this.navigator)
    : super(BottomNavState.initial(initialParams: initialParams)) {
    setSelectedIndex(initialParams.selectedIndex);
  }

  void setSelectedIndex(int index) =>
      emit(state.copyWith(selectedIndex: index));

  // List<Widget> get pages => [
  //   {{class_name}}Page(cubit: getIt(param1: const {{class_name}}InitialParams()))
  // ];
}
