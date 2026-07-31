import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/institution_account.dart';

class InstitutionAccountRepository {
  InstitutionAccountRepository({
    FirebaseFirestore? firestore,
  }) : _firestore =
            firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<void> createAccount(
    InstitutionAccount account,
  ) async {
    await _firestore
        .collection('institutionAccounts')
        .doc(account.uid)
        .set(account.toMap());
  }

  Future<InstitutionAccount?> getAccount(
    String uid,
  ) async {
    final document = await _firestore
        .collection('institutionAccounts')
        .doc(uid)
        .get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return InstitutionAccount.fromMap(
      document.data()!,
    );
  }
}