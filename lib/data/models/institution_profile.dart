import 'package:cloud_firestore/cloud_firestore.dart';

class InstitutionProfile {
  const InstitutionProfile({
    required this.id,
    required this.name,
    required this.shortName,
    required this.email,
    required this.status,
    required this.createdAt,
    this.isTestInstitution = false,
  });

  final String id;
  final String name;
  final String shortName;
  final String email;
  final String status;
  final DateTime createdAt;
  final bool isTestInstitution;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortName': shortName,
      'email': email,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'isTestInstitution': isTestInstitution,
    };
  }

  factory InstitutionProfile.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    final createdAtValue = map['createdAt'];

    return InstitutionProfile(
      id: id,
      name: map['name'] as String? ?? '',
      shortName: map['shortName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      status: map['status'] as String? ?? 'pending',
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : DateTime.now(),
      isTestInstitution:
          map['isTestInstitution'] as bool? ?? false,
    );
  }
}