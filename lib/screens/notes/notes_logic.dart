import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_notes/core/exceptions/app_exception.dart';
import 'package:sticky_notes/models/api/note_response.dart';
import 'package:sticky_notes/screens/notes/notes_state.dart';
import 'package:sticky_notes/service/note_service.dart';
import 'package:sticky_notes/service/service.dart';

class NotesLogic extends GetxController {
  NotesState state = NotesState();
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNotes();
  }

  void fetchNotes() async {
    try {
      isLoading.value = true;

      NoteResponse? result = await getService<NoteService>()?.fetchNotes();

      if (result != null && result.listNotes != null) {
        state.dataNote = result;
      }
    } on AppException catch (e) {
      await Future.delayed(Duration.zero);
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      await Future.delayed(Duration.zero);
      print(e);
      Get.snackbar('Error', 'Terjadi kesalahan aplikasi');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteNote({required int id}) async {
    try {
      bool isSuccess =
          await getService<NoteService>()?.deleteNote(id: id) ?? false;

      if (isSuccess) {
        state.dataNote?.listNotes?.removeWhere(
          (note) => note.id == id,
        );

        update();
        await Future.delayed(Duration.zero);
        Get.snackbar('Sukses', 'Berhasil menghapus note');
      }
    } on AppException catch (e) {
      await Future.delayed(Duration.zero);
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      await Future.delayed(Duration.zero);
      print(e);
      Get.snackbar('Error', 'Terjadi kesalahan aplikasi');
    } finally {
      isLoading.value = false;
    }
  }
}
