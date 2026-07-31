import 'package:cloud_firestore/cloud_firestore.dart';

class CourseMaterial {
  const CourseMaterial({
    required this.id,
    required this.title,
    required this.description,
    required this.fileName,
    required this.storagePath,
    required this.contentType,
    required this.sizeBytes,
    required this.accessType,
    required this.published,
    required this.institutionId,
    required this.programmeId,
    required this.courseId,
    required this.uploadedBy,
    this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String fileName;
  final String storagePath;
  final String contentType;
  final int sizeBytes;
  final String accessType;
  final bool published;
  final String institutionId;
  final String programmeId;
  final String courseId;
  final String uploadedBy;
  final DateTime? createdAt;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'fileName': fileName,
      'storagePath': storagePath,
      'contentType': contentType,
      'sizeBytes': sizeBytes,
      'accessType': accessType,
      'published': published,
      'institutionId': institutionId,
      'programmeId': programmeId,
      'courseId': courseId,
      'uploadedBy': uploadedBy,
      'createdAt': createdAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(createdAt!),
    };
  }

  factory CourseMaterial.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    final createdAtValue = map['createdAt'];

    return CourseMaterial(
      id: id,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      fileName: map['fileName'] as String? ?? '',
      storagePath: map['storagePath'] as String? ?? '',
      contentType: map['contentType'] as String? ?? '',
      sizeBytes: (map['sizeBytes'] as num?)?.toInt() ?? 0,
      accessType: map['accessType'] as String? ?? 'free',
      published: map['published'] as bool? ?? false,
      institutionId: map['institutionId'] as String? ?? '',
      programmeId: map['programmeId'] as String? ?? '',
      courseId: map['courseId'] as String? ?? '',
      uploadedBy: map['uploadedBy'] as String? ?? '',
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : null,
    );
  }
}