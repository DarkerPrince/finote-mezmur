import 'package:finotemezmur/Views/Listing-Page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x04041B00),
      body: Center(
          child: Column(
        children: [
          Image.asset(
            "assets/Image/image1.png",
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // 2 columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListPage()));
                  },
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Kides Kidanmhret"),
                        Text("32 Songs"),
                        Container(
                          child: Image.asset(
                            "assets/Image/image1.png",
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kides Kidanmhret"),
                      Text("32 Songs"),
                      Container(
                        child: Image.asset(
                          "assets/Image/image1.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kides Kidanmhret"),
                      Text("32 Songs"),
                      Container(
                        child: Image.asset(
                          "assets/Image/image1.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kides Kidanmhret"),
                      Text("32 Songs"),
                      Container(
                        child: Image.asset(
                          "assets/Image/image1.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kides Kidanmhret"),
                      Text("32 Songs"),
                      Container(
                        child: Image.asset(
                          "assets/Image/image1.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kides Kidanmhret"),
                      Text("32 Songs"),
                      Container(
                        child: Image.asset(
                          "assets/Image/image1.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kides Kidanmhret"),
                      Text("32 Songs"),
                      Container(
                        child: Image.asset(
                          "assets/Image/image1.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
