import 'dart:convert';

import 'material_file_storage.dart';

class MockMaterialFileStorage
    implements MaterialFileStorage {
  final Map<String, List<int>> _files = {};

  @override
  Future<String> uploadPdf({
    required String fileName,
    required List<int> bytes,
  }) async {
    final storagePath =
        'mock/course_materials/$fileName';

    _files[storagePath] = List<int>.from(bytes);

    return storagePath;
  }

  @override
  Future<List<int>> downloadPdf(
    String storagePath,
  ) async {
    final file = _files[storagePath];

    if (file != null) {
      return List<int>.from(file);
    }

    // Simulated PDF content for development.
    return utf8.encode(
      '''
CourseMind Mock PDF

This is a development-only material.

Firebase Storage will replace this mock storage
before production deployment.
''',
    );
  }

  @override
  Future<void> deleteFile(
    String storagePath,
  ) async {
    _files.remove(storagePath);
  }
}