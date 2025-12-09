import 'package:flutter/material.dart';
import 'package:habitroot/core/extension/color_extension.dart';
import 'package:habitroot/core/extension/textstyle_extension.dart';
import 'package:habitroot/core/theme/app_color_scheme.dart';

class PremiumPlanListview extends StatefulWidget {
  const PremiumPlanListview({super.key});

  @override
  State<PremiumPlanListview> createState() => _PremiumPlanListviewState();
}

class _PremiumPlanListviewState extends State<PremiumPlanListview> {
  // State to hold the index of the currently selected plan.
  int _selectedIndex = 0;

  // Dummy plan data
  final List<Map<String, String>> _plans = const [
    {
      "title": "Weekly Plan",
      "subTitle": "Then ₹80/week",
      "offerTitle": "Popular",
    },
    {
      "title": "Monthly Plan",
      "subTitle": "Then ₹300/month",
      "offerTitle": "", // No offer banner for this plan
    },
    {
      "title": "Yearly Plan",
      "subTitle": "Then ₹2000/year (Save 50%)",
      "offerTitle": "Best Value",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Use ListView.builder if you expect a long list, but Column is fine for 3 items.
        // I'll use a List.generate inside the Column for the dummy data.
        ...List.generate(_plans.length, (index) {
          final plan = _plans[index];
          final bool isSelected = _selectedIndex == index;

          return _PremiumPlanTile(
            title: plan["title"]!,
            subTitle: plan["subTitle"]!,
            offerTitle: plan["offerTitle"]!,
            isSelected: isSelected,
            // isGreen is set to true for "Best Value" plan
            isGreen: plan["offerTitle"] == "Best Value",
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        }),
      ],
    );
  }
}

// ---

class _PremiumPlanTile extends StatelessWidget {
  const _PremiumPlanTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.offerTitle,
    required this.isSelected,
    this.isGreen = false,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final String offerTitle;
  final bool isGreen;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // Determine the border color based on selection status
    final Color borderColor = isSelected
        ? AppColorScheme.premiumPrimary // Highlight color when selected
        : Colors.grey.shade300
            .withValues(alpha: 0.5); // Muted color when unselected

    // Determine the color of the checkmark icon
    final Color checkIconColor =
        isSelected ? AppColorScheme.premiumPrimary : Colors.grey.shade300;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10, // Increased vertical padding for better spacing
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width:
                isSelected ? 2.0 : 1.5, // Slightly thicker border when selected
            color: borderColor,
          ),
          // Optional: Add a subtle shadow when selected
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColorScheme.premiumPrimary.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Distribute children horizontally
          children: [
            // Left Column: Title, Offer Banner, and Subtitle
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                SizedBox(
                  height: 22,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: context.bodyLarge?.copyWith(
                          color: isSelected
                              ? AppColorScheme.premiumPrimary
                              : Colors.grey.shade600,
                          fontSize: 14,
                        ),
                        // style: context.bodyLarge?.copyWith(
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                      const SizedBox(
                          width: 8), // Spacing between title and offer
                      // Offer Banner
                      if (offerTitle.isNotEmpty)
                        Container(
                          height: 22,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // Use green for 'Best Value' and red for others/default
                            color: isGreen ? Colors.green.shade600 : Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              offerTitle,
                              style: context.labelLarge?.copyWith(
                                  color: context.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                // const SizedBox(height: 4), // Spacing between rows
                // Subtitle/Price Details
                Text(
                  subTitle,
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  // style: context.bodyLarge?.copyWith(
                  //   color: Colors.grey.shade600,
                  //   fontSize: 14,
                  // ),
                ),
              ],
            ),
            // Right Icon: Selection Indicator
            Icon(
              // Change icon based on selection status
              isSelected
                  ? Icons.check_circle_rounded // Filled icon when selected
                  : Icons.radio_button_off, // Outline/unselected icon
              size: 24,
              color: !isSelected
                  ? checkIconColor.withValues(alpha: 0.5)
                  : checkIconColor,
            ),
          ],
        ),
      ),
    );
  }
}
