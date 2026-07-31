import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/institution.dart';
import '../models/programme.dart';

class InstitutionRepository {
  InstitutionRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<List<Institution>> getActiveInstitutions() async {
    final snapshot = await _firestore
        .collection('institutions')
        .where('status', isEqualTo: 'active')
        .get();

    return snapshot.docs
        .map(
          (doc) => Institution.fromMap(
            id: doc.id,
            map: doc.data(),
          ),
        )
        .toList();
  }

  Future<List<Programme>> getActiveProgrammes(
    String institutionId,
  ) async {
    final snapshot = await _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('programmes')
        .where('active', isEqualTo: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => Programme.fromMap(
            id: doc.id,
            map: doc.data(),
          ),
        )
        .toList();
  }
}