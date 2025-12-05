import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';
import 'package:habitroot/features/splash/presentation/onboarding/widgets/onboarding_button.dart';
import 'package:habitroot/features/splash/presentation/onboarding/widgets/onboarding_feature_tile.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  final List<Map<String, dynamic>> features = const [
    {
      'emoji': '🧱',
      'title':
          'Check your habits with one tap so you stay aware and keep going every day.',
      'highlights': ['one tap', 'keep going'],
    },
    {
      'emoji': '🌱',
      'title':
          'Watch your progress grow, turning small steps into habits that feel good.',
      'highlights': ['progress grow', 'feel good'],
    },
    {
      'emoji': '🔔',
      'title':
          'Get calm nudges at the right time, so even on busy days you don’t lose track.',
      'highlights': ['calm nudges', 'don’t lose track'],
    },
    {
      'emoji': '📊',
      'title':
          'See clean charts and easy stats that show how far you’ve come with every small win.',
      'highlights': ['clean charts', 'easy stats', 'small win'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark/Black background for modern feel
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // 2. Visual Hook (Placeholder for your graphic/image)
              // Center(
              //   child: Padding(
              //       padding: EdgeInsets.symmetric(vertical: 40.0),
              //       child: Image.asset(
              //         "assets/icons/Group_1.png",
              //       )
              //       // SvgPicture.asset(
              //       //   "assets/Group 1.png",
              //       // )

              //       //  Icon(
              //       //   Icons
              //       //       .park_rounded, // Use a placeholder icon for the "tree/growth" graphic
              //       //   color: AppColorScheme.primary,
              //       //   size: 150,
              //       // ),
              //       ),
              // ),
              const Spacer(),
              Text(
                "🌱",
                style: TextStyle(fontSize: 92),
              ),
              const SizedBox(height: 22),
              // 3. Headline
              const Text(
                'Build small habits.\nGrow every day.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 54),
              // 4. Feature List
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: features
                    .map((feature) => OnboardingFeatureTile(
                          icon: feature['emoji']!,
                          title: feature['title']!,
                          highlights: feature['highlights'],
                        ))
                    .toList(),
              ),
              const SizedBox(height: 34),
            ],
          ),
        ),
      ),
      bottomNavigationBar: OnboardingButton(
        label: "Start Growing",
        onPressed: () {
          context.goNamed('dashboard-screen');
        },
      ),
    );
  }
}

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 15,
//             children: [
//              OnboardingFeatureTile(icon: "", title: title)
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
