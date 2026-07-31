class InstitutionAccount {
  const InstitutionAccount({
    required this.uid,
    required this.institutionId,
    required this.role,
  });

  final String uid;
  final String institutionId;
  final String role;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'institutionId': institutionId,
      'role': role,
    };
  }

  factory InstitutionAccount.fromMap(
    Map<String, dynamic> map,
  ) {
    return InstitutionAccount(
      uid: map['uid'] as String,
      institutionId: map['institutionId'] as String,
      role: map['role'] as String,
    );
  }
}