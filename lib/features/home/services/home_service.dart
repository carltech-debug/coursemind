import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/user_profile.dart';
import '../../../data/repositories/user_profile_repository.dart';

class HomeService {
  HomeService({
    UserProfileRepository? profileRepository,
    FirebaseAuth? auth,
  })  : _profileRepository =
            profileRepository ?? UserProfileRepository(),
        _auth = auth ?? FirebaseAuth.instance;

  final UserProfileRepository _profileRepository;
  final FirebaseAuth _auth;

  Future<UserProfile?> getCurrentUserProfile() async {
    final user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    return _profileRepository.getProfile(user.uid);
  }
}