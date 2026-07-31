import '../models/course_material.dart';

class MockCourseMaterialRepository {
  final List<CourseMaterial> _materials = [
    CourseMaterial(
      id: 'mock_eee101_001',
      title: 'Circuit Theory I — Introduction',
      description: 'Development sample material for EEE 101.',
      fileName: 'eee101_introduction.pdf',
      storagePath: 'mock/course_materials/eee101_introduction.pdf',
      contentType: 'application/pdf',
      sizeBytes: 1024,
      accessType: 'free',
      published: true,
      institutionId: 'atu_test',
      programmeId: 'eee_test',
      courseId: 'eee101',
      uploadedBy: 'mock_institution',
      createdAt: DateTime.now(),
    ),
  ];

  Future<List<CourseMaterial>> getPublishedMaterials({
    required String institutionId,
    required String programmeId,
    required String courseId,
  }) async {
    return _materials
        .where(
          (material) =>
              material.institutionId == institutionId &&
              material.programmeId == programmeId &&
              material.courseId == courseId &&
              material.published,
        )
        .toList();
  }

  Future<String> createMaterial(
    CourseMaterial material,
  ) async {
    _materials.add(material);
    return material.id;
  }

  Future<void> deleteMaterial(
    CourseMaterial material,
  ) async {
    _materials.removeWhere(
      (item) => item.id == material.id,
    );
  }
}