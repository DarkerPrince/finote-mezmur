import 'package:finotemezmur/Views/Listing-Page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:finotemezmur/Model/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  // List of pages to switch between
  List<Category> _data = [];

  Future<void> loadJson() async {
    final String response =
    await rootBundle.loadString('assets/Mezmur/categories.json');
    final Map<String,dynamic> jsonData = json.decode(response);
    List<Category> categoryList = (jsonData['categories'] as List<dynamic>)
        .map((category) => Category.fromJson(category))
        .toList();
    // print(jsonData);
    setState(() {
      _data = categoryList;
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              forceElevated: true,
              floating: true,
              snap: true,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/Image/image1.png",
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.white12,
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(_data.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListPage(category: _data[index])));
                    },
                    child: Card(
                      elevation: 16,
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                            child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( _data[index].title.toString()??"" ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              const Text("32 Songs"),
                            ],
                          ),

                          ),
                          Expanded(
                            child: Image.asset(
                              _data[index].image,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }
  }
