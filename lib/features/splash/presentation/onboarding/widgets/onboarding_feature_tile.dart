import 'package:flutter/material.dart';
import 'package:habitroot/core/extension/common.dart';

class OnboardingFeatureTile extends StatelessWidget {
  const OnboardingFeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.highlights,
  });

  final String icon;
  final String title;
  final List<String> highlights;

  List<InlineSpan> _buildHighlightedText(BuildContext context) {
    final textColor = Colors.white;
    String remaining = title;
    final spans = <InlineSpan>[];

    while (remaining.isNotEmpty) {
      // Find which highlight appears first
      String? match;
      int matchIndex = remaining.length;

      for (final h in highlights) {
        final idx = remaining.toLowerCase().indexOf(h.toLowerCase());
        if (idx != -1 && idx < matchIndex) {
          match = remaining.substring(idx, idx + h.length);
          matchIndex = idx;
        }
      }

      if (match == null) {
        spans.add(TextSpan(
          text: remaining,
          style: DefaultTextStyle.of(context).style.copyWith(
                color: textColor.withOpacity(0.55),
                height: 1.4,
              ),
        ));
        break;
      }

      // Before match
      if (matchIndex > 0) {
        spans.add(TextSpan(
          text: remaining.substring(0, matchIndex),
          style: DefaultTextStyle.of(context).style.copyWith(
                color: textColor.withOpacity(0.55),
                height: 1.4,
              ),
        ));
      }

      // Match highlighted
      spans.add(TextSpan(
        text: match,
        style: DefaultTextStyle.of(context).style.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
      ));

      // Remove that part and continue
      remaining = remaining.substring(matchIndex + match.length);
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        Expanded(
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(children: _buildHighlightedText(context)),
          ),
        ),
      ],
    );
  }
}
