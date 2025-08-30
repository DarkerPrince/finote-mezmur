import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/Image/onboarding1.png",
      "title": "መዝሙሮችን በቀላሉ ይፈልጉ",
      "desc": "ለእግዚአብሔር አዲስ ምስጋናን አመስግኑ፤ ምድር ሁሉ፥ እግዚአብሔርን አመስግኑ። መዝ 96",
    },
    {
      "image": "assets/Image/onboarding2.png",
      "title": "በየበዓላት ዘመን ዘምሩ",
      "desc": "ለበዓላት ልደት፣ ትንሳኤ እና ሌሎችንም ይቃኙ።",
    },
    {
      "image": "assets/Image/onboarding3.png",
      "title": "እስትንፋስ ያለው ሁሉ እግዚአብሔርን ያመስግን።",
      "desc": "ምድር ሁሉ፥ በመዝሙር ይዘምሩ፣ ያመስግኑት፣ ለእግዚአብሔር እልል በሉ።",
    },
    {
      "image": "assets/Image/onboarding4.png",
      "title": "ዘማሪዎችን በስማቸው ይፈልጉ",
      "desc": "የተወደዱ ዘማሪዎች ያግኙ፣ አብረው ይዘምሩ።",
    },
    {
      "image": "assets/Image/onboarding5.png",
      "title": "ኤፌ 5:19",
      "desc": "በመዝሙርና በዝማሬ በመንፈሳዊም ቅኔ እርስ በርሳችሁ ተነጋገሩ፤ ለጌታ በልባችሁ ተቀኙና ዘምሩ፤",
    },
    {
      "image": "assets/Image/onboarding7.png",
      "title": "ከ፲፱፻፹፬ ጀምሮ",
      "desc": "የአየርጤና አንቀጸ ብርሃን ቅድስት ኪዳነምሕረት ፍኖተ ጽድቅ ሰንበት ትምህርት ቤት",
    }
  ];


  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      widget.onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Colors.amber;
    final textColor = isDark ? Colors.white : Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    data['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5), // dark overlay
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title']!,
                          style: TextStyle(
                            color: primary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data['desc']!,
                          style: TextStyle(
                            color: textColor.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Dots and Button
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(onboardingData.length, (index) {
                      final selected = _currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: selected ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: selected ? primary : Colors.grey[600],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPage == onboardingData.length - 1 ?primary: Colors.transparent,
                    foregroundColor: isDark ? _currentPage == onboardingData.length - 1 ?Colors.black: primary : Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _nextPage,
                  child: Text(_currentPage == onboardingData.length - 1 ? 'ጀምር' : 'ቀጣይ'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
