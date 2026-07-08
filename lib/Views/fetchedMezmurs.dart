import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:finotemezmur/Model/Mezmur.dart';
import 'package:finotemezmur/function/GraphqlClient.dart';
import 'package:finotemezmur/function/query_mutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FetchFilesPage extends StatefulWidget {
  @override
  _FetchFilesPageState createState() => _FetchFilesPageState();
}

class _FetchFilesPageState extends State<FetchFilesPage> {
  bool isLoading = true;
  List<Mezmur> songs = [];

  final Map<String, String> queriesToFiles = {
    'Trinity_Song': trinityHamleQuery,
  };

  @override
  void initState() {
    super.initState();
    fetchAndStoreAllCategories().then((_) => loadSongsFromFile());
  }

  Future<void> fetchAndStoreAllCategories() async {
    final client = getClient();
    final directory = await getApplicationDocumentsDirectory();

    for (var entry in queriesToFiles.entries) {
      final fileName = entry.key;
      final query = entry.value;

      final result = await client.query(
        QueryOptions(document: gql(query)),
      );

      if (result.hasException) continue;

      final data = result.data?['finote_mezmur'];
      if (data == null || data.isEmpty) continue;

      final file = File('${directory.path}/$fileName.json');
      await file.writeAsString(jsonEncode(data));
    }
  }

  Future<void> loadSongsFromFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/Trinity_Song.json');

    if (await file.exists()) {
      final content = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(content);
      songs = jsonData.map((e) => Mezmur.fromJson(e)).toList();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trinity Songs')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(song.title),
              subtitle: Text('Singer: ${song.singer}'),
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!song.songLyrics.verse.isEmpty)
                        Text('Verse: ${song.songLyrics.verse}'),
                      if (song.songLyrics.chorus!.isNotEmpty)
                        Text('Chorus: ${song.songLyrics.chorus}'),
                      if (song.songLyrics.translation!.isNotEmpty)
                        Text('Translation: ${song.songLyrics.translation}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
