import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  const Course({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.level,
    required this.semester,
    required this.active,
    required this.published,
    required this.institutionId,
    required this.programmeId,
    this.createdAt,
  });

  final String id;
  final String code;
  final String name;
  final String description;
  final String level;
  final String semester;
  final bool active;
  final bool published;
  final String institutionId;
  final String programmeId;
  final DateTime? createdAt;

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'description': description,
      'level': level,
      'semester': semester,
      'active': active,
      'published': published,
      'institutionId': institutionId,
      'programmeId': programmeId,
      'createdAt': createdAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(createdAt!),
    };
  }

  factory Course.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    final createdAtValue = map['createdAt'];

    return Course(
      id: id,
      code: map['code'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      level: map['level'] as String? ?? '',
      semester: map['semester'] as String? ?? '',
      active: map['active'] as bool? ?? false,
      published: map['published'] as bool? ?? false,
      institutionId:
          map['institutionId'] as String? ?? '',
      programmeId:
          map['programmeId'] as String? ?? '',
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : null,
    );
  }
}