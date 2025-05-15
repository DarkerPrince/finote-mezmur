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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Mezmur Title here",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Color(0x04041B00),
      body: Container(
        child: Wrap(
          children: [
            Text(
                style: TextStyle(fontSize: 16,fontStyle: FontStyle.normal,color: Colors.white),
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
    );
  }
}
