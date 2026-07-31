abstract class MaterialFileStorage {
  Future<String> uploadPdf({
    required String fileName,
    required List<int> bytes,
  });

  Future<List<int>> downloadPdf(String storagePath);

  Future<void> deleteFile(String storagePath);
}