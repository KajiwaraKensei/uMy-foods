import 'package:flutter/material.dart';
import 'package:umy_foods/footer.dart';
import 'package:umy_foods/header.dart';
import 'package:umy_foods/HexColor.dart';

class WhatuMyFoods extends StatefulWidget {
  @override
  _WhatuMyFoodsState createState() => _WhatuMyFoodsState();
}

class _WhatuMyFoodsState extends State<WhatuMyFoods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Column(children: [
                Text('uMyFoodsとは..',
                    style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
                    Container(
                  color: HexColor('F5F3EF'),
                  child: Text('aaaaa',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                )
              ]),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class TermsOfService extends StatefulWidget {
  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('ご利用規約',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('プライバシーポリシー',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('よくあるご質問',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('サポート',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class ProductRanking extends StatefulWidget {
  @override
  _ProductRankingState createState() => _ProductRankingState();
}

class _ProductRankingState extends State<ProductRanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('商品ランキングページ',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class ReviewRanking extends StatefulWidget {
  @override
  _ReviewRankingState createState() => _ReviewRankingState();
}

class _ReviewRankingState extends State<ReviewRanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('レビューランキングページ',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class UserRanking extends StatefulWidget {
  @override
  _UserRankingState createState() => _UserRankingState();
}

class _UserRankingState extends State<UserRanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('ユーザーランキングページ',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class UserQuestion extends StatefulWidget {
  @override
  _UserQuestionState createState() => _UserQuestionState();
}

class _UserQuestionState extends State<UserQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('ユーザーアンケートページ',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class SearchByCategory extends StatefulWidget {
  @override
  _SearchByCategoryState createState() => _SearchByCategoryState();
}

class _SearchByCategoryState extends State<SearchByCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('カテゴリーから探す',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class SearchByMaker extends StatefulWidget {
  @override
  _SearchByMakerState createState() => _SearchByMakerState();
}

class _SearchByMakerState extends State<SearchByMaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('メーカーから探す',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class SearchByNewProduct extends StatefulWidget {
  @override
  _SearchByNewProductState createState() => _SearchByNewProductState();
}

class _SearchByNewProductState extends State<SearchByNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('新商品から探す',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class ViewPopularReviews extends StatefulWidget {
  @override
  _ViewPopularReviewsState createState() => _ViewPopularReviewsState();
}

class _ViewPopularReviewsState extends State<ViewPopularReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('人気のレビューを見る',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

class ViewNewReviews extends StatefulWidget {
  @override
  _ViewNewReviewsState createState() => _ViewNewReviewsState();
}

class _ViewNewReviewsState extends State<ViewNewReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              child: Text('新着のレビューを見る',
                  style: TextStyle(fontSize: 25, color: HexColor('8C6E63'))),
            ),
            FooterCreate(),
          ],
        ),
      ),
    );
  }
}

//ViewPopularReviews