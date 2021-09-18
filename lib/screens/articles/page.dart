
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:drop_cap_text/drop_cap_text.dart';

import 'data.dart';
import 'article.dart';


class ArticleDisplayPage extends StatefulWidget {
  final Article article;

  ArticleDisplayPage(this.article);

  @override
  _ArticleDisplayPageState createState() => _ArticleDisplayPageState();
}

class _ArticleDisplayPageState extends State<ArticleDisplayPage> {
  int _selectedViewIndex = 0;
  int _articleTitleBestSize = 30;
  double _safeareaPadding = 0;
  double _maxHeaderHeight = 186.0, _minHeaderHeight = 66.0;
  double _headerHeight = 186.0;
  double _articlePadding = 24.0;
  double _articleProgress = 0.0;
  double _lastScrollExtent = 0;
  double _progressBarHeight = 10.0;
  double _lastRatio = 0.0;
  Duration _animationDuration = Duration(seconds: 1);
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    _headerHeight = _maxHeaderHeight;

    if (SchedulerBinding.instance == null) return;

    SchedulerBinding.instance!.addPostFrameCallback((_) =>
      _lastScrollExtent = _scrollController.position.maxScrollExtent
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double thisScrollExtent = _scrollController.position.maxScrollExtent;
    double ratio = _scrollController.offset
      / (((thisScrollExtent + _lastScrollExtent) / 2) * 0.95);
    ratio = (ratio * 10.0).floor().toDouble() / 10.0;
    ratio += 0.05 - (ratio * 0.05);
    if (ratio!=_lastRatio) {
      _lastRatio = ratio;
      if (ratio>0.2) {
        _headerHeight = _minHeaderHeight;
        _progressBarHeight = 5.0;
      } else {
        _headerHeight = _maxHeaderHeight;
        _progressBarHeight = 10.0;
      }
      setState(() => _articleProgress = ratio);
    }
    _lastScrollExtent = thisScrollExtent;
  }

  Widget _buildHeader(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      curve: Curves.easeOutBack,
      height: _headerHeight + _safeareaPadding,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Hero(
              tag: widget.article.images[0],
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                child: Image.network(
                  widget.article.images[0],
                  fit: BoxFit.cover,
                  semanticLabel: 'A background image of ',
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: CloseButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width * _articleProgress,
      height: _progressBarHeight,
      duration: _animationDuration,
      curve: Curves.ease,
      decoration: BoxDecoration(
      ),
    );
  }

  Widget _buildStarterText(var content) {
    return Container(
      padding: EdgeInsets.all(_articlePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.article.title,
          ),

          SizedBox(height: 25),

          // Text(
          //   _makeDateReadable(widget.article.date),
          // ),
          SizedBox(height: 60),
          DropCapText(
            content,
            dropCapPadding: EdgeInsets.all(4),
            forceNoDescent: true,
            textAlign: TextAlign.justify,
            dropCapChars: 1,
          ),
        ],
      ),
    );
  }
  Widget _buildText(var content) {
    return Padding(
      padding: EdgeInsets.all(_articlePadding),
      child: Text(
        content,
        textAlign: TextAlign.justify,
      ),
    );
  }
  Widget _buildImage(var content) {
    return Image.network(
      widget.article.images[content],
    );
  }
  Widget _buildImageTextWrap(var content, var textWrap, bool leftWrap) {
    return Padding(
      padding: EdgeInsets.all(_articlePadding),
      child: DropCapText(
        textWrap,
        textAlign: TextAlign.justify,
        dropCapPosition: leftWrap ? DropCapPosition.start : DropCapPosition.end,
        dropCap: DropCap(
          width: 200.0,
          height: 200.0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              leftWrap ? 0 : _articlePadding, 0,
              leftWrap ? _articlePadding : 0, 0
            ),
            child: Image.network(
              widget.article.images[content],
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildQuote(var content) {
    return Padding(
      padding: EdgeInsets.all(_articlePadding*2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(_articlePadding),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: content[0],
                ),
                TextSpan(
                  text: content.substring(1, content.length),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildArticle() {
    bool skipNext = false;
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      controller: _scrollController,
      itemCount: widget.article.body.length + 1,
      itemBuilder: (context, index) {
        if (index==0) {
          return _buildStarterText(widget.article.body[index]['content']);
        }
        if (index==widget.article.body.length) {
          return Padding(
            padding: EdgeInsets.all(_articlePadding),
            child: Column(
              children: <Widget>[
                SizedBox(height: _articlePadding),
                widget.article.extra_info!='' && widget.article.extra_info!=null
                  ? Text(
                    widget.article.extra_info,
                  )
                  : Container(),
                SizedBox(height: _articlePadding*2),

                // Text(
                //   _makeDateReadable(widget.article.date),
                // ),
                SizedBox(height: _articlePadding*2),
              ],
            ),
          );
        }
        if (skipNext) {
          skipNext = false;
          return Container();
        }

        return Text(widget.article.body[index]['content']);


        if (widget.article.body[index]['type']==0) {
          return _buildText(widget.article.body[index]['content']);
        }
        else if (widget.article.body[index]['type']==1) {
          if (index+1<widget.article.body.length) {
            if (widget.article.body[index+1]['type']==0) {
              skipNext = true;
              return _buildImageTextWrap(
                widget.article.body[index]['content'],
                widget.article.body[index+1]['content'],
                index%2==0,
              );
            }
          }
          return _buildImage(widget.article.body[index]['content']);
        }
        else if (widget.article.body[index]['type']==2) {
          return _buildQuote(widget.article.body[index]['content']);
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _safeareaPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                _buildHeader(context),

                _buildProgressBar(context),

                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height - _headerHeight,
                    child: _buildArticle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
