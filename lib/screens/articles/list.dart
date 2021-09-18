
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'data.dart';
import 'card.dart';


class KoreanFoodScreenState extends State<KoreanFoodScreen> {

  ScrollController _scrollController = ScrollController();
  final REQUEST_AMOUNT = 10;
  final _scrollTargetDistanceFromBottom = 400.0;
  final String title = '한국 맛집';

  @override
  void initState() {
    super.initState();
    _scrollController;
    _scrollController.addListener(_scrollListener);

    _pullNext(REQUEST_AMOUNT);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  bool forceFailCurrentState = false;
  void _pullNext(int amount) {

  }
  void forceFail() {
    forceFailCurrentState = true;
  }

  void _scrollListener() {
    if (_scrollController.offset + _scrollTargetDistanceFromBottom
        >= _scrollController.position.maxScrollExtent) {
      _pullNext(REQUEST_AMOUNT);
    }
  }
  void _onEndScroll(ScrollMetrics metrics) {
  }
  void _onStartScroll(ScrollMetrics metrics) {
  }

  void openSnackBar(Map<String, dynamic> input) {
    try {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(input['text']),
        elevation: 15.0,
        behavior: SnackBarBehavior.floating,
        duration: input['duration']==null ? Duration(seconds: 3) : Duration(seconds: input['duration']),
        action: input['action']==null ? null : SnackBarAction(
          label: input['action-label'],
          onPressed: input['action'],
        ),
      ));
    } catch (e) {
      print(e);
    }
  }

  Widget listViewer(context, recipes, child) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: recipes.list.length + 1,
      itemBuilder: (context, index) {

        if (index < recipes.list.length) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: ArticleCard(recipes.list[index]),
          );
        }

        if (forceFailCurrentState) {
          return ErrorCard('Make sure you are connected to the internet.');
        }

        return RowLoading();
      },
    );
  }

  Widget typeFilter(BuildContext context) => ChangeNotifierProvider<KoreanFood>(
    create: (_) => KoreanFood(),
    child: Consumer<KoreanFood>(
      builder: listViewer,
    ),
  );


  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            _onStartScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollEndNotification) {
            _onEndScroll(scrollNotification.metrics);
          }
          return true;
        },
        child: Column(
          children: [

            Container(
              // color: Color(0xFF90AF17),
              height: 66,
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                      ),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10,
                    child: CloseButton(
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height - 64,
              child: typeFilter(context),
            ),
          ],
        ),
      ),
    ),
  );
}

class JapaneseFoodScreenState extends KoreanFoodScreenState {
  @override final String title = '일본 맛집';
  @override
  Widget typeFilter(BuildContext context) => Provider<JapaneseFood>(
    create: (_) => JapaneseFood(),
    child: Consumer<JapaneseFood>(
      builder: listViewer,
    ),
  );
}
class ChineseFoodScreenState extends KoreanFoodScreenState {
  @override final String title = '중국 맛집';
  @override
  Widget typeFilter(BuildContext context) => Provider<ChineseFood>(
    create: (_) => ChineseFood(),
    child: Consumer<ChineseFood>(
      builder: listViewer,
    ),
  );
}
class AmericanFoodScreenState extends KoreanFoodScreenState {
  @override final String title = '미국 맛집';
  @override
  Widget typeFilter(BuildContext context) => Provider<AmericanFood>(
    create: (_) => AmericanFood(),
    child: Consumer<AmericanFood>(
      builder: listViewer,
    ),
  );
}
