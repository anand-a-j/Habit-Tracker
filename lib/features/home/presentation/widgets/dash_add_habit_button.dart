import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:habitroot/core/constants/app_constants.dart';
import 'package:habitroot/core/extension/common.dart';

class DashAddHabitButton extends StatelessWidget {
  const DashAddHabitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.onPrimary,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          context.pushNamed("habit-add-screen");
        },
        borderRadius: BorderRadius.circular(
          AppConsts.rCircle,
        ),
        child: Container(
          height: 48,
          width: 68,
          decoration: BoxDecoration(
            color: context.onPrimary,
            borderRadius: BorderRadius.circular(
              50,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: 24,
              color: context.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

// length button
//  return InkWell(
//       borderRadius: BorderRadius.circular(50),
//       onTap: () {
//         context.pushNamed("habit-add-screen");
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(50),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(
//             height: 50,
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             decoration: BoxDecoration(
//               color: context.primary.withOpacity(0.25),
//               borderRadius: BorderRadius.circular(50),
//               border: Border.all(color: context.primary, width: 0.85),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               spacing: 6,
//               children: [
//                 Icon(
//                   Icons.add,
//                   color: context.primary.withOpacity(0.9),
//                   grade: -25.0,
//                   weight: 100,
//                 ),
//                 Text(
//                   "Add a Habit",
//                   style: context.bodyLarge?.copyWith(
//                     color: context.primary.withOpacity(0.9),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

class GlassFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final Color tintColor;

  const GlassFloatingActionButton({
    Key? key,
    required this.onPressed,
    this.size = 48.0,
    this.tintColor = const Color(0xFF5E5CE6), // you can pick your accent colour
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            splashColor: tintColor.withOpacity(0.2),
            // highlightColor: transparent if you like
            child: Container(
              decoration: BoxDecoration(
                // glass effect: translucent + blur + border
                color: tintColor.withOpacity(0.15),
                border: Border.all(
                  color: tintColor.withOpacity(0.4),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(size / 2),
              ),
              child: Stack(
                children: [
                  // optional inner shadow / highlight to enhance glassy feel
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size / 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.25),
                            offset: const Offset(-2, -2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: const Offset(2, 2),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.add,
                      size: size * 0.5,
                      color: tintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
