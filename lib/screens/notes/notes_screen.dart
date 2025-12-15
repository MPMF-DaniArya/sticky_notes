import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_notes/screens/login/widgets/sticky_notes.dart';
import 'package:sticky_notes/screens/notes/notes_logic.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotesLogic());
    final state = Get.find<NotesLogic>().state;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Obx(
          () {
            if (logic.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.dataNote == null ||
                state.dataNote!.listNotes == null ||
                state.dataNote!.listNotes!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.not_interested_outlined,
                      size: 60,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Belum ada Notes",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return GetBuilder<NotesLogic>(
              builder: (logic) {
                return ListView.builder(
                  itemCount: state.dataNote!.listNotes!.length,
                  itemBuilder: (context, index) {
                    final note = state.dataNote!.listNotes![index];

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: StickyNote(note: note),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
