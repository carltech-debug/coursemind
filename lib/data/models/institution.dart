class Institution {
  const Institution({
    required this.id,
    required this.name,
    required this.shortName,
    required this.status,
    required this.isTestInstitution,
  });

  final String id;
  final String name;
  final String shortName;
  final String status;
  final bool isTestInstitution;

  factory Institution.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return Institution(
      id: id,
      name: map['name'] as String? ?? '',
      shortName: map['shortName'] as String? ?? '',
      status: map['status'] as String? ?? 'inactive',
      isTestInstitution: map['isTestInstitution'] as bool? ?? false,
    );
  }
}