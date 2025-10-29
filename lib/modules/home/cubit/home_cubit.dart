import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/category_data.dart';

class HomeState {
  final CategoryData? selectedCategory;
  final bool isSearching;

  HomeState({this.selectedCategory, this.isSearching = false});

  HomeState copyWith({
    CategoryData? selectedCategory,
    bool? isSearching,
  }) {
    return HomeState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void selectCategory(CategoryData category) {
    emit(state.copyWith(selectedCategory: category, isSearching: false));
  }

  void goHome() {
    emit(HomeState(selectedCategory: null, isSearching: false));
  }

  void toggleSearch() {
    emit(state.copyWith(isSearching: !state.isSearching));
  }

  void setSearch(bool value) {
    emit(state.copyWith(isSearching: value));
  }
}
