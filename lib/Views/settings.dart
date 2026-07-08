import 'dart:convert';
import 'dart:io';

import 'dart:convert';
import 'package:finotemezmur/Views/fetchedMezmurs.dart';
import 'package:finotemezmur/function/GraphqlClient.dart';
import 'package:finotemezmur/function/query_mutation.dart';
import 'package:finotemezmur/function/update_Fetch_files.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path_provider/path_provider.dart';


import 'package:flutter/material.dart';
import 'package:finotemezmur/Views/webView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';



class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;

  const SettingsPage({required this.onThemeToggle,required this.isDarkMode, super.key});

  @override
  State<SettingsPage> createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsPage> {
  String _version = 'Loading...';
  List<dynamic> fetchedMezmurs = [];


  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  final Map<String, String> queriesToFiles = {
    'K_Gebriel_Song': fetchMezmursQuery,
    'St_Mary_Song': fetchMezmursQuery,
    'Trinity_Song': fetchMezmursQuery,
    'Angel': fetchMezmursQuery,
    'Holidays': fetchMezmursQuery,
  };

  Future<void> fetchAndStoreAllCategories() async {
    final client = getClient();
    final directory = await getApplicationDocumentsDirectory();
    print('The Files are starting to Be created fetched and Stored updated');
    for (var entry in queriesToFiles.entries) {
      final fileName = entry.key;
      final query = entry.value;
      print('The File $fileName is starting to Be created and updated');
      final result = await client.query(
        QueryOptions(document: gql(query)),
      );

      if (result.hasException) {
        print('GraphQL Error for $fileName: ${result.exception.toString()}');
        continue; // skip this file and go to next
      }

      final data = result.data?['finote_mezmur']; // adjust key if query returns differently
      if (data == null || data.isEmpty) {
        print('No data for $fileName');
        continue;
      }

      final file = File('${directory.path}/$fileName.json');
      await file.writeAsString(jsonEncode(data));

      print('$fileName saved at ${file.path}');
    }
  }



  void launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }


  final socialLinks = {
    'Facebook': 'https://web.facebook.com/FinoteTsidkeSundaySchool?_rdc=1&_rdr#',
    'Telegram': 'https://t.me/Finote1619',
    'Tiktok': 'https://www.tiktok.com/@finote1619_?_t=8oiZzAgbsXu&_r=1',
    'Youtube': 'https://www.youtube.com/@finote1619',
    'Instagram': 'https://www.instagram.com/finote16_19?utm_source=qr&igsh=MW90eHZvOGlnZndwOA=',
  };

  void _launchURL(String url , BuildContext context,String pageTitle) async {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewExample(url: url ,pageTitle:pageTitle),
      ),
    );
    // if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    //   throw 'Could not launch $url';
    // }
  }

  Future<void> _getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
      print("Version is ${_version}");// You can also include build number: '${info.version}+${info.buildNumber}'
    });
  }

  Widget _buildSocialIcon(String name, IconData icon, String url,BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => _launchURL(url,context,"ፍኖት ሚዲያ"),
      tooltip: name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ቅንብሮች')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ፍኖተ ጽድቅ',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Wrap(
              children: [
                Text(
                  'ይህ የአየር ጤና አንቀጸ ብርሃን ቅድስት ኪዳነ ምሕረት ካቴድራል ፍኖተ ጽድቅ ሰንበት ት/ቤት የመዝሙር መተግበሪያ ሲሆን ማንኛውም አይነት ሐሳብ፣ አስተያየትና ማስተካከያ ካሎት ከዚህ በታች ያለውን የሐሳብ መስጫ በመጫን ያስቀምጡልን:: እናመሰግናለን 🙏',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
,
            SizedBox(height: 12),
            ListTile(
              tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              title: Text("አስተያየት ይስጡ"),
              leading: Icon(Icons.comment_bank,),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: ()=>launchInBrowser("https://docs.google.com/forms/d/e/1FAIpQLSd6ClEc2EIUxTvx6S5gIObbfUUrk__muA9jSXEWWsagYwE65Q/viewform")
            ),
            SizedBox(height: 24),
            Text('የእኛን ማህበራዊ ይከተሉ', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 1,
              children: [
                _buildSocialIcon('Facebook', FontAwesomeIcons.facebook, socialLinks['Facebook']!,context),
                _buildSocialIcon('Telegram', FontAwesomeIcons.telegram, socialLinks['Telegram']!,context),
                _buildSocialIcon('Tiktok', FontAwesomeIcons.tiktok, socialLinks['Tiktok']!,context),
                _buildSocialIcon('Youtube', FontAwesomeIcons.youtube, socialLinks['Youtube']!,context),
                _buildSocialIcon('Instagram', FontAwesomeIcons.instagram, socialLinks['Instagram']!,context),
              ],
            ),
            SizedBox(height: 24),


            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: widget.isDarkMode,
                onChanged:  (value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.onThemeToggle(value);
                  });
                },
              ),),
              Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                ),
                child: ListTile(
                  title: Text("Version"),
                  leading: Icon(Icons.touch_app_outlined,),
                  subtitle: Text("$_version"),
                  trailing:  ElevatedButton(
                    onPressed: () async {
                      await fetchAndStoreAllCategories();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mezmurs fetched and stored!')),
                      );
                    },
                    child: Text('Fetch Mezmurs'),
                  ),

                  // trailing: Icon(Icons.download),
                  // onTap: (){
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //       title: Text('ያረጋግጡ'),
                  //       content: Text('እርግጠኛ? የመዝሙርን ፋይል ማዘመን ትፈልጋለህ?'),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () => Navigator.pop(context), // Cancel
                  //           child: Text('አልፈልግም'),
                  //         ),
                  //         ElevatedButton(
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //             // TODO: Add your update logic here
                  //           },
                  //           child: Text('አዎ'),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // },
                ),
              ),
            ElevatedButton(onPressed: () async {
              _showMezmursBottomSheet();
            }, child: Text("View Mezmur")),

            SizedBox(height: 80),

          ],
        ),
      ),
    );
  }

  void _showMezmursBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // to make it taller
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FetchFilesPage();

        // return Container(
        //   padding: EdgeInsets.all(16),
        //   height: MediaQuery.of(context).size.height * 0.7, // 70% of screen
        //   child: fetchedMezmurs.isEmpty
        //       ? Center(child: Text('No mezmurs fetched yet'))
        //       : ListView.builder(
        //     itemCount: fetchedMezmurs.length,
        //     itemBuilder: (context, index) {
        //       final mezmur = fetchedMezmurs[index];
        //       return ListTile(
        //         title: Text(mezmur['title'] ?? 'No title'),
        //         subtitle: Text('ID: ${mezmur['id'] ?? 'N/A'}'),
        //       );
        //     },
        //   ),
        // );
      },
    );
  }



}
