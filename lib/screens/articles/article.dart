
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

// import 'page.dart';
import 'data.dart';


class Article {
  static int index = 0;

  final int id;
  final String cryptlink, title, date, topic,
          short_intro, extra_info, author;
  final List<dynamic> body, images;

  Article({
    required this.id,
    required this.cryptlink,
    this.title = 'No Title',
    this.author = 'No Author',
    this.date = 'No Date',
    this.topic = 'No Topic',
    this.extra_info = 'No info',
    this.short_intro = 'No Intro',
    this.body = const ['l','l'],
    this.images = const [],
  });


  static Article json(var data) {
    String shortIntro = '', author = '';

    for (int i = 0; i < data['ingredientLines'].length; i++) {
      if (data['ingredientLines'][i].length > 30)
        shortIntro += '${data['ingredientLines'][i].substring(0, 25)}...\n';
      else shortIntro += '${data['ingredientLines'][i]}\n';
    }

    int start_loc = data['url'].indexOf('//') + 2;

    var _body = [];
    for (int i = 0; i < data['ingredientLines'].length; i++) {
      _body.add({
        'type': 0,
        'content': data['ingredientLines'][i],
      });
    }

    return Article(
      id: Article.index++,
      cryptlink: data['url'],
      title: data['label'],
      images: [data['image']],
      short_intro: shortIntro,
      author: data['url'].substring(start_loc, data['url'].indexOf('/', start_loc)),
      topic: data['healthLabels'][0],
      extra_info: data['ingredientLines'],
      body: _body,

      // date: data['date'],
    );
  }
}
