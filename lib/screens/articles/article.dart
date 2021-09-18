
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'page.dart';
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
    this.body = const [],
    this.images = const [],
  });

  String toString() => '${id},${cryptlink},${title}';


  NetworkImage headline_image() {
    return NetworkImage(images[0]);
  }
  String image_link(int index) {
    if (index>=images.length) return  images[0];
    return images[index];
  }


  static Article json(var data) {
    return Article(
      id: Article.index++,
      cryptlink: data['url'],
      title: data['label'],
      images: [data['image']],

      // topic: data['topic'],
      // author: data['author'],
      // date: data['date'],
      // body: data['body'],
      // extra_info: data['extra_info'],
      // short_intro: data['short_intro'],
    );
  }

  ArticleDisplayPage navigateTo() {
    return ArticleDisplayPage(this);
  }
}
