import 'package:flutter/material.dart';

import 'package:eunbeyol/screens/articles/routes.dart';


class RecipeBundle {
  final int id, chefs, recipes;
  final String title, description, imageSrc;
  final Color color;
  final String destination;

  RecipeBundle(
      {this.id = 0,
      this.chefs = 0,
      this.recipes = 0,
      this.title = '',
      this.description = '',
      this.imageSrc = '',
      this.color = Colors.red,
      this.destination = '/',
    });
}

// Demo list
List<RecipeBundle> recipeBundles = [
  RecipeBundle(
    id: 1,
    chefs: 1,
    recipes: 95,
    title: '한국 맛집',
    description: '고전적인 맛있는 한국 음식',
    imageSrc: 'assets/images/cook_new@2x.png',
    color: Color(0xFFD82D40),
    destination: KoreanFoodScreen.routeName,
  ),
  RecipeBundle(
    id: 2,
    chefs: 8,
    recipes: 26,
    title: '미국 맛집',
    description: '미국이 버거의 근본이 되는 나라가 아니던가',
    imageSrc: 'assets/images/best_2020@2x.png',
    color: Color(0xFF90AF17),
    destination: AmericanFoodScreen.routeName,
  ),
  RecipeBundle(
    id: 3,
    chefs: 10,
    recipes: 43,
    title: '일본 맛집',
    description: '일본 최대 도시인 도쿄는 일본 요리 문화의 중심입니다',
    imageSrc: 'assets/images/food_court@2x.png',
    color: Color(0xFF2DBBD8),
    destination: JapaneseFoodScreen.routeName,
  ),
  RecipeBundle(
    id: 3,
    chefs: 10,
    recipes: 43,
    title: '중국 맛집',
    description: '중국에서 유명한 음식 체인점을 돌아다녔습니다',
    imageSrc: 'assets/images/food_court@2x.png',
    color: Color(0xFF5B28C0),
    destination: ChineseFoodScreen.routeName,
  ),
];
