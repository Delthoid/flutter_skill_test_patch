import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/enums.dart';
import 'package:flutter_skill_test_patch/model/catergory.dart';

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

  void setCategory({Category? category}) {
    state.selectedCategory = category;
    state = state.copyWith(selectedCategory: category);
  }

  void setPriceSort({PriceSort? priceSort}) {
    state.priceSort = priceSort;
    state = state.copyWith(priceSort: priceSort);
  }
}

class AppState {
  int selectedIndex = 0;
  Category? selectedCategory;
  PriceSort? priceSort;

  AppState({
    int? selectedIndex,
    this.selectedCategory,
    this.priceSort
  }) : selectedIndex = selectedIndex ?? 0;

  AppState copyWith({
    int? selectedIndex,
    Category? selectedCategory,
    PriceSort? priceSort
  }) => AppState(
    selectedIndex: selectedIndex ?? this.selectedIndex,
    selectedCategory: selectedCategory ?? this.selectedCategory,
    priceSort: priceSort ?? this.priceSort,
  );
}