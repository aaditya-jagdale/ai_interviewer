import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final resumesProvider =
    StateNotifierProvider<ResumesNotifier, List<FileObject>>((ref) {
  return ResumesNotifier();
});

class ResumesNotifier extends StateNotifier<List<FileObject>> {
  ResumesNotifier() : super([]);

  void setResumes(List<FileObject> resumes) {
    state = resumes;
  }

  void clear() {
    state = [];
  }

  void addResume(FileObject resume) {
    state = [...state, resume];
  }

  void removeResume(FileObject resume) {
    state = state.where((element) => element.id != resume.id).toList();
  }
}
