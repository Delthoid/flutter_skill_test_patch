import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/enums.dart';

final appStateNotifier = StateNotifierProvider<AppStateData, AppState>((ref) {
  return AppStateData(AppState());
});

class AppStateData extends StateNotifier<AppState> {
  AppStateData(super.state);

  int get selectedIndex => state.selectedIndex;

  void setSelectedIndex(int index) {
    state.selectedIndex = index;
    state = state.copyWith(selectedIndex: index);
  }
}

class AppState {
  int selectedIndex = 0;
  PriceSort priceSort = PriceSort.lowToHigh;

  AppState({
    int? selectedIndex,
    PriceSort? priceSort
  }) : selectedIndex = selectedIndex ?? 0,
      priceSort = priceSort ?? PriceSort.lowToHigh;

  AppState copyWith({
    int? selectedIndex,
    PriceSort? priceSort
  }) => AppState(
    selectedIndex: selectedIndex ?? this.selectedIndex,
    priceSort: priceSort ?? this.priceSort,
  );
}