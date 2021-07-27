import 'dart:convert';
import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tenaii_demo/models/categories.dart';
import 'package:tenaii_demo/models/post.dart';
import 'package:tenaii_demo/widgets/search_bar.dart';
import 'package:tenaii_demo/widgets/section_header.dart';
import 'package:http/http.dart' as http;

import 'models/news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.promptTextTheme(textTheme),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<News> futureNews;
  late Future<Categories> futureCategories;
  late Future<Post> futurePost;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
    futureCategories = fetchCategories();
    futurePost = fetchPost();
  }

  Future<News> fetchNews() async {
    final response = await http.get(
        Uri.parse('https://dev-api.teenaii.com/api/mobile/news-manager/news'));

    if (response.statusCode == 200) {
      return News.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load News');
    }
  }

  Future<Categories> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://dev-api.teenaii.com/api/mobile/post-manager/categories'));

    if (response.statusCode == 200) {
      return Categories.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  Future<Post> fetchPost() async {
    final response = await http.get(
        Uri.parse('https://dev-api.teenaii.com/api/mobile/post-manager/posts'));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/logo.png"),
        actions: [
          IconButton(
            icon: Badge(
              badgeContent:
                  const Text("2", style: TextStyle(color: Colors.white)),
              position: BadgePosition.topEnd(top: -12, end: -10),
              child: SvgPicture.asset("assets/noti-bell.svg"),
            ),
            onPressed: null,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: const EdgeInsets.all(16), child: SearchBar()),
                newsSection(),
                SectionHeader("หมวดหมู่ทั้งหมด"),
                categoriesSection(),
                SectionHeader("โพสต์ล่าสุด"),
                postSection(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          bottomNavBarItem("assets/home.svg", "หน้าหลัก", isActive: true),
          bottomNavBarItem("assets/hand.svg", "จ้างงาน"),
          bottomNavBarItem("assets/plus.svg", "โพสต์งาน"),
          bottomNavBarItem("assets/person.svg", "โปรไฟล์"),
        ],
      ),
    );
  }

  newsSection() => FutureBuilder<News>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: 109,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 600),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index, realIndex) => ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(snapshot.data!.data[index].imageUrl),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      );

  categoriesSection() => FutureBuilder<Categories>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.data;
            return SizedBox(
              height: 240,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 150,
                  mainAxisSpacing: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          data[index].imageUrl.imageUrlDefault,
                        ),
                      ),
                    ),
                    Text(
                      data[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      );

  postSection() => FutureBuilder<Post>(
        future: futurePost,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.data;
            var headerTextStyle = Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold);
            var priceTextStyle =
                Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    );
            return SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) => Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: cardPost(data[index], headerTextStyle, priceTextStyle),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      );

  cardPost(
    PostData data,
    TextStyle headerTextStyle,
    TextStyle priceTextStyle,
  ) =>
      Container(
        width: 180,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    data.imageUrl,
                    width: 180,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      "assets/favorite.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title, style: headerTextStyle),
                  Row(children: [
                    cardPostRating(data.rating),
                    SizedBox(width: 36),
                    Text("เริ่มต้นที่")
                  ]),
                  Row(children: [
                    SizedBox(
                      width: 15,
                      height: 15,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(data.userImage),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(data.userName),
                    Spacer(),
                    Text(
                      data.price.toString(),
                      style: priceTextStyle,
                    )
                  ]),
                  Row(children: [
                    Text(
                      "${data.address.province} | ${data.address.district}",
                      style: TextStyle(fontSize: 10),
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/pin.svg"),
                    SizedBox(width: 2),
                    Text(
                      "${data.distance} กม.",
                      style: TextStyle(fontSize: 10),
                    ),
                  ])
                ],
              ),
            )
          ],
        ),
      );

  cardPostRating(int rating) => Row(
        children: [
          SvgPicture.asset(
            rating >= 1 ? "assets/star1.svg" : "assets/star0.svg",
            width: 12,
            height: 12,
          ),
          SvgPicture.asset(
            rating >= 2 ? "assets/star1.svg" : "assets/star0.svg",
            width: 12,
            height: 12,
          ),
          SvgPicture.asset(
            rating >= 3 ? "assets/star1.svg" : "assets/star0.svg",
            width: 12,
            height: 12,
          ),
          SvgPicture.asset(
            rating >= 4 ? "assets/star1.svg" : "assets/star0.svg",
            width: 12,
            height: 12,
          ),
          SvgPicture.asset(
            rating >= 5 ? "assets/star1.svg" : "assets/star0.svg",
            width: 12,
            height: 12,
          ),
        ],
      );

  bottomNavBarItem(String iconAssets, String label, {bool isActive = false}) =>
      BottomNavigationBarItem(
        icon: Container(
          child: SvgPicture.asset(
            iconAssets,
            color: isActive ? Colors.white : null,
          ),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: label,
      );
}
