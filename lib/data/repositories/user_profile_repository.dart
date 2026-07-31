import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<UserProfile?> getCurrentUserProfile() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return null;
  }

  return getProfile(user.uid);
}
}