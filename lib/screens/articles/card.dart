
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:eunbeyol/online/views/recipe_view.dart';

import 'data.dart';
import 'article.dart';


class ArticleCard extends StatelessWidget {
  ArticleCard(this.article);

  final Article article;

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${article.topic} food by ${article.author}',
        ),
        SizedBox(height: 16),
        Text(
          article.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: Text(
            article.short_intro,
          ),
        ),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onPressed: () {
        if (kIsWeb) {
          _launchURL(article.cryptlink);
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeView(
              postUrl: article.cryptlink,
            ),
          ),
        );
      },
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      upElevation: 7,
      downElevation: 3,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 140,
              height: 160,
              padding: EdgeInsets.only(right: 10),
              child: _buildDetails(context),
            ),
            Semantics(
              label: 'Logo for ${article.title}',
              child: Hero(
                tag: article.images[0],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Image.network(
                      article.images[0],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorCard extends StatelessWidget {
  final String err;

  ErrorCard(this.err);

  @override
  Widget build(BuildContext context) => Container(
    height: 200,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Center(
          child: Text(
            err,
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

class RowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PressableCard(
    onPressed: () {},
    child: Semantics(
      label: 'loading card',
      child: Container(
        child: Center(
          child: SpinKitDancingSquare(
            size: 50.0,
          ),
        ),
      ),
    ),
  );
}


class BigBox extends StatefulWidget {

  String image;
  final VoidCallback? onTap;

  BigBox({
    required this.image,
    this.onTap,
  });

  @override
  _BigBoxState createState() => _BigBoxState();
}

class _BigBoxState extends State<BigBox> {
  @override
  Widget build(BuildContext context) => Container(
    child: PressableCard(
      upElevation: 4,
      downElevation: 2,
      child: Image.asset(
        (widget.image == null)
          ? 'assets/loading/explore_card.jpg'
          : widget.image,
        fit: BoxFit.cover,
      ),
      onPressed: widget.onTap,
    ),
  );
}



class PressableCard extends StatefulWidget {
  const PressableCard({
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.upElevation = 2,
    this.downElevation = 0,
    this.shadowColor = Colors.grey,
    this.duration = const Duration(milliseconds: 100),
    this.color = Colors.white,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;

  final Widget child;

  final Color color;

  final BorderRadius borderRadius;

  final double upElevation;

  final double downElevation;

  final Color shadowColor;

  final Duration duration;

  @override
  _PressableCardState createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  bool cardIsDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => cardIsDown = false);
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapDown: (details) => setState(() => cardIsDown = true),
      onTapCancel: () => setState(() => cardIsDown = false),
      child: AnimatedPhysicalModel(
    elevation: cardIsDown ? widget.downElevation : widget.upElevation,
    borderRadius: widget.borderRadius,
    shape: BoxShape.rectangle,
    shadowColor: widget.shadowColor,
    duration: widget.duration,
    color: widget.color,
    child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.child,
        ),
      ),
    );
  }
}
