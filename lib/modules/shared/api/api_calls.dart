import 'dart:io';

import 'package:ai_interview/modules/shared/widgets/snackbars.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiCalls {
  final _supabase = Supabase.instance.client;

  Future<void> uploadResume(context, String path) async {
    final file = File(path);
    final bucketName = 'resumes/${_supabase.auth.currentUser!.id}';
    final fileName = file.path.split('/').last;

    await _supabase.storage
        .from(bucketName)
        .upload(fileName, file)
        .then((path) {})
        .onError((StorageException error, _) {
      errorSnackBar(context, error.message);
      print("-----------------Error uploading resume: $error");
    });
  }

  Future<List<FileObject>> getResume() async {
    final bucketName = 'resumes';
    List<FileObject> files = [];
    await _supabase.storage
        .from(bucketName)
        .list(path: _supabase.auth.currentUser!.id)
        .then((res) {
      files = res;
    });
    return files;
  }
}
