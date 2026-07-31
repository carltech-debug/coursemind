import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.university,
    required this.programme,
    required this.level,
    required this.role,
    this.institutionId,
    this.programmeId,
    this.createdAt,
  });

  final String uid;
  final String name;
  final String email;
  final String university;
  final String programme;
  final String level;
  final String role;
  final String? institutionId;
  final String? programmeId;
  final DateTime? createdAt;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'university': university,
      'programme': programme,
      'level': level,
      'role': role,
      'institutionId': institutionId,
      'programmeId': programmeId,
      'createdAt': createdAt,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    final createdAtValue = map['createdAt'];

    return UserProfile(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      university: map['university'] as String,
      programme: map['programme'] as String,
      level: map['level'] as String,
      role: map['role'] as String,
      institutionId: map['institutionId'] as String?,
      programmeId: map['programmeId'] as String?,
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : null,
    );
  }
}