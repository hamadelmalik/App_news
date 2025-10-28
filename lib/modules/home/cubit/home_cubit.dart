import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/category_data.dart';

class HomeCubit extends Cubit<CategoryData?> {
  HomeCubit() : super(null);

  void selectCategory(CategoryData category) => emit(category);
  void goHome() => emit(null);
}