import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quotie/models/quote.dart';
import 'package:quotie/api/quote_api.dart';
import 'package:quotie/colors.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => new _QuotePageState();
}

class _QuotePageState extends State<QuotePage>
    with SingleTickerProviderStateMixin {
  QuoteList quoteList = QuoteList();

  Future<void> getQuoteData() async {
    var quoteJson = await QuoteAPI().getAllQuotes();
    var quoteMap = json.decode(quoteJson);
    setState(() {
      quoteList = QuoteList.fromJson(quoteMap);
    });
  }

  static Random randomizer = Random();
  int quoteCounter = randomizer.nextInt(1000);
  int colorcounter = 0;

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    getQuoteData();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void showQuote() {
    setState(() {
      dispcolor = bgcolors[colorcounter];
      quoteCounter =
          quoteCounter < quoteList.quotes.length - 1 ? quoteCounter + 1 : 0;
      colorcounter = colorcounter < bgcolors.length - 1 ? colorcounter + 1 : 0;
      animationController.reset();
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: dispcolor,
      body: new Stack(
        children: <Widget>[_buildAppBar(), _buildQuote(), _buildBottomBar()],
      ),
    );
  }

  Widget getQuote() {
    if (quoteList == null ||
        quoteList.quotes == null ||
        quoteList.quotes.length == 0) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Text(
            quoteList.quotes[quoteCounter].text[0].toString(),
            style: new TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w300),
          ),
          Text(
            quoteList.quotes[quoteCounter].author.toString(),
            style: new TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w300),
          ),
        ],
      );
    }
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 40.0,
      left: 20.0,
      right: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildQuote() {
    return Positioned(
      top: 350.0,
      left: 20.0,
      right: 20.0,
      child: Opacity(
        opacity: animation.value * 1,
        child: new Transform(
          transform:
              new Matrix4.translationValues(0.0, animation.value * -50.0, 0.0),
          child: getQuote(),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 40.0,
      left: 20.0,
      right: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: showQuote,
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
