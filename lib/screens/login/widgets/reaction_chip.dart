import 'package:flutter/material.dart';

class ReactionChip extends StatelessWidget {
  const ReactionChip({
    super.key,
    required this.emoji,
    required this.countEmoji,
  });

  final String emoji;
  final int countEmoji;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border.all(color: Colors.black54, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text(countEmoji.toString(), style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
