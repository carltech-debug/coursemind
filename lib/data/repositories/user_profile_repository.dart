import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createProfile(UserProfile profile) async {
    await _firestore
        .collection('users')
        .doc(profile.uid)
        .set(profile.toMap());
  }

  Future<UserProfile?> getProfile(String uid) async {
    final document = await _firestore.collection('users').doc(uid).get();
    if (!document.exists || document.data() == null) {
      return null;
    }
    return UserProfile.fromMap(document.data()!);
  }
}