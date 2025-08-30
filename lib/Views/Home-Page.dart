import 'package:finotemezmur/Views/Listing-Page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:finotemezmur/Model/category.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  const HomePage({super.key, required this.isDarkMode});

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
    final Map<String, dynamic> jsonData = json.decode(response);
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
    return Scaffold(
      // backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            collapsedHeight: 10,
            toolbarHeight: 10,
            forceElevated: true,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF212121)
                : Colors.white,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              expandedTitleScale: 1.2,
              centerTitle: true,
              title: Text(
                "ፍኖተ ጽድቅ መዝሙር",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    // fontFamily: 'NokiaPureHeadline',
                    color: Theme.of(context).colorScheme.primary),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/Image/image1.png",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: widget.isDarkMode
                            ? [
                                Colors.transparent,
                                Color(0x80121212),
                                Color(0xFF121212),
                              ]
                            : [
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
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              children: List.generate(_data.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ListPage(category: _data[index])));
                  },
                  child: Card(
                    color: widget.isDarkMode
                        ? const Color(0xFF1E1E1E) // dark mode card background
                        : Colors.white,
                    clipBehavior: Clip.hardEdge,
                    elevation: 12,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _data[index].title.toString() ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              Text(
                                  "${_data[index].subCategories.length} ${_data[index].subCategories.length == 1 ? 'ምድብ' : 'ምድቦች'}"),
                            ],
                          ),
                        )),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Background Image
                            Container(
                              width: 200,
                              height: 160,
                              child: Image.asset(
                                height: 160,
                                width: 190,
                                _data[index].image,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),

                            // Gradient Overlay
                            Container(
                              width: 200,
                              height: 160,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: widget.isDarkMode
                                      ? [
                                          Colors.transparent,
                                          Color(0x801E1E1E),
                                          Color(0xFF1E1E1E),
                                        ]
                                      : [
                                          Colors.transparent,
                                          Colors.white12,
                                          Colors.white,
                                        ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: 80), // or 100 depending on your bottom nav height
          ),
        ],
      ),
    );
  }
}
