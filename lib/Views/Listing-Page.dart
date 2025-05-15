import 'package:finotemezmur/Views/Lyrics-Show.dart';
import 'package:flutter/material.dart';


class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "List of Mezmur",

          style: TextStyle(color: Colors.white),

        ),
      ),
      backgroundColor: Color(0x04041B00),
      body:  Center(child:Column(

        children: [
          Image.asset("assets/Image/image1.png",
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            fit: BoxFit.cover,),
          Container
            (child:
           Column(
            children:  [
               ListTile(title: Text("Mezmur 1"),leading: Icon(Icons.music_note),subtitle: Text("Deacon Alemayehu"), trailing: Icon(Icons.church_outlined),
                 onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LyricsPage()));
                 },
               ),
               ListTile(title: Text("Mezmur 1"),leading: Icon(Icons.music_note),subtitle: Text("Deacon Alemayehu"), trailing: Icon(Icons.church_outlined),),
               ListTile(title: Text("Mezmur 1"),leading: Icon(Icons.music_note),subtitle: Text("Deacon Alemayehu"), trailing: Icon(Icons.church_outlined),),
               ListTile(title: Text("Mezmur 1"),leading: Icon(Icons.music_note),subtitle: Text("Deacon Alemayehu"), trailing: Icon(Icons.church_outlined),),
               ListTile(title: Text("Mezmur 1"),leading: Icon(Icons.music_note),subtitle: Text("Deacon Alemayehu"), trailing: Icon(Icons.church_outlined),),
               ListTile(title: Text("Mezmur 1"),leading: Icon(Icons.music_note),subtitle: Text("Deacon Alemayehu"), trailing: Icon(Icons.church_outlined),),
            ],
          ),)
        ],
      )),

    );
  }
}
