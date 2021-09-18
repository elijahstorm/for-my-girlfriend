import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'article.dart';


class ArticleData extends ChangeNotifier {
  String type = '';

  ArticleData() {
    search('');
  }

  List<Article> list = [];

  Article getArticle(String cryptlink) => innocentAdd(Article(
    id: -1,
    cryptlink: cryptlink,
  ));

  Article innocentAdd(Article a) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].cryptlink == a.cryptlink) {
        return list[i];
      }
    }

    list.add(a);

    return a;
  }

  void search(String search) async {
    String url = 'https://api.edamam.com/search?q=${type}%20${search}&app_id=0f21d949&app_key=8bcdd93683d1186ba0555cb95e64ab26';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    jsonData['hits'].forEach((element) {
      innocentAdd(Article.json(element['recipe']));
    });

    notifyListeners();
  }
}

class KoreanFood extends ArticleData {
  @override
  String type = 'korean';
}
class AmericanFood extends ArticleData {
  @override
  String type = 'american';
}
class JapaneseFood extends ArticleData {
  @override
  String type = 'japanese';
}
class ChineseFood extends ArticleData {
  @override
  String type = 'chinese';
}
