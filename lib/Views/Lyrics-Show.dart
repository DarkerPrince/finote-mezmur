import 'package:finotemezmur/Views/Listing-Page.dart';
import 'package:flutter/material.dart';

class LyricsPage extends StatefulWidget {
  const LyricsPage({super.key});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Color(0x04041B00),
      body: Container(
        child: Stack(
          children: [
            DraggableScrollableSheet(
              initialChildSize: 0.3,   // Starts small like a mini player
              minChildSize: 0.14,       // Minimum size when collapsed
              maxChildSize: 1,       // Maximum height when expanded
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Now Playing"),
                        subtitle: Text("Artist Name"),
                        trailing: Icon(Icons.pause),
                      ),
                      Divider(),
                      Container(
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Wrap(
                          children: [
                            Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24,),
                                '''
ምድርና ሰማይ ታሰምርሽን ይንገሩ
ፍጥረታት በሙሉ ስላንቺ ይመስክሩ
ተነግሮ የማልቅ ድንቅ ነው ስጋሽ
ድንግል ሆይ እናቴ አምሳያ የለሽ

ማርያም ድንግል እረዳቴ
የምትደርሺልኝ ነይ ስልሽ በጭንቀቴ
ታምርሽንም በዓኔ አይቻለሁ
ጽዮን ሆይ ስልሽ ድንግል ሆይ እጠግባለሁ

የእግዚአብሔር ጥበቡ ላንቺ ተገለጠ
የአዳም ዘር በሙሉ ከሞት አመለጠ
የመዳን ምክንያት አንቺ ማርያም አንቺ ነሽ
ለፍጥረቱ ሁሉ መሰላል የሆንሽ
ለፍጥረቱ ሁሉ መሰላል የሆንሽ

ነገን ባላውቅም እኔም ቢያስፈራኝ
አንቺ ካለሺኝ በፍፁም አልወድቅም
በፊትሽ እንድቆም በምስጋና
ማርያም ልበልሽ በትህትና

ትውልድ በሙሉ ለምስና ይቆማል
ባንቺ ስለሆነ የቀረለት መርገም
አዳም ከለ ልጁ በሰማይ በምድር
ማርያም /2/ ይበል ታምርሽን ይናገር

ጨለማውም ከፊቴ ተገፈፈ
ማርያም በምልጃሽ ለቤ አረፈ
ከጎኔ ነሽ ስልሽ እፅናናለሁ
እሳት ገድሉን ሁሉንም አልፋለሁ
            ''')
                          ],
                        ),
                      ),
                      // Add more content as needed
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
