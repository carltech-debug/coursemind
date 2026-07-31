import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/institution_profile.dart';

class InstitutionProfileRepository {
  InstitutionProfileRepository({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>>
      get _institutions =>
          _firestore.collection('institutions');

  Future<String> createInstitution({
    required String name,
    required String shortName,
    required String email,
  }) async {
    final document = await _institutions.add({
      'name': name.trim(),
      'shortName': shortName.trim(),
      'email': email.trim(),
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'isTestInstitution': false,
    });

    return document.id;
  }

  Future<InstitutionProfile?> getInstitution(
    String institutionId,
  ) async {
    final document =
        await _institutions.doc(institutionId).get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return InstitutionProfile.fromMap(
      id: document.id,
      map: document.data()!,
    );
  }

  Future<void> updateInstitutionStatus({
    required String institutionId,
    required String status,
  }) async {
    await _institutions.doc(institutionId).update({
      'status': status,
    });
  }
}