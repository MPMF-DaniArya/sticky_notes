import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sticky_notes/models/api/note_response.dart';
import 'package:sticky_notes/screens/login/widgets/reaction_chip.dart';

class StickyNote extends StatelessWidget {
  final NotesData note;

  const StickyNote({super.key, required this.note});

  Color _parseColor(String colorString) {
    try {
      String hex = colorString.replaceAll('#', '');

      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      return Color(int.parse('0x$hex'));
    } catch (e) {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final noteColor = _parseColor(note.color!);

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: noteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    note.title!,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                          size: 25,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ))
                  ],
                )
              ],
            ),
            const SizedBox(height: 18),
            if (note.image != null)
              CachedNetworkImage(
                imageUrl: note.image!,
                width: double.infinity,
                height: 100,
              ),
            const SizedBox(height: 18),
            Text(
              note.description!,
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReactionChip(
                  emoji: '❤️',
                  countEmoji: note.reactions!.heart!,
                ),
                ReactionChip(
                  emoji: '👍',
                  countEmoji: note.reactions!.like!,
                ),
                ReactionChip(emoji: '😂', countEmoji: note.reactions!.laugh!),
                ReactionChip(
                  emoji: '😮',
                  countEmoji: note.reactions!.surprised!,
                ),
                ReactionChip(
                  emoji: '🔥',
                  countEmoji: note.reactions!.fire!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
