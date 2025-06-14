
import 'package:news_api/Models/categoryTile.dart';

List<CategoryModel> getCategoryData (){
  List<CategoryModel> categories = [];
  CategoryModel category = new CategoryModel();
  category.name = 'Business';
  category.image = 'assets/images/business.jpg';
  categories.add(category);

  category = new CategoryModel();
  category.name = 'Sports';
  category.image = 'assets/images/sports.jpeg';
  categories.add(category);

  category = new CategoryModel();
  category.name = 'Health';
  category.image = 'assets/images/health.jpeg';
  categories.add(category);

  category = new CategoryModel();
  category.name = 'General';
  category.image = 'assets/images/general.jpg';
  categories.add(category);

  category = new CategoryModel();
  category.name = 'Science';
  category.image = 'assets/images/science.jpg';
  categories.add(category);

  category = new CategoryModel();
  category.name = 'Entertainment';
  category.image = 'assets/images/entertainment.jpeg';
  categories.add(category);

  return categories;
}