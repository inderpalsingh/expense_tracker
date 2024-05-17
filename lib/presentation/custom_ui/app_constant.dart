import '../../data/model/category_model.dart';
import 'image_constants.dart';

class AppConstants{

  static final List<CategoryModel> mCategories = [
    CategoryModel(
      catId: 1,
      catTitle: "Fuel",
      catImgPath: ImageConstants.IMG_PATH_FUEL,
    ),
    CategoryModel(
      catId: 2,
      catTitle: "Fast Food",
      catImgPath: ImageConstants.IMG_PATH_FAST_FOOD,
    ),
    CategoryModel(
      catId: 3,
      catTitle: "Movie",
      catImgPath: ImageConstants.IMG_PATH_MOVIE,
    ),
    CategoryModel(
      catId: 4,
      catTitle: "Shopping",
      catImgPath: ImageConstants.IMG_PATH_SHOPPING,
    ),
    CategoryModel(
      catId: 5,
      catTitle: "Salon",
      catImgPath: ImageConstants.IMG_PATH_SALON,
    ),
  ];

}