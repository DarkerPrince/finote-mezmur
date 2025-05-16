import 'package:flutter/material.dart';

class MusicBottomSheetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content behind the sheet
          Center(
            child: Text(
              'Main Content Here',
              style: TextStyle(fontSize: 24),
            ),
          ),

          // Sticky Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.1,   // Starts small like a mini player
            minChildSize: 0.1,       // Minimum size when collapsed
            maxChildSize: 1,       // Maximum height when expanded
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      child: Wrap(
                        children: [
                          Text(
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
    );
  }
}
