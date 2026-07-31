class Programme {
  const Programme({
    required this.id,
    required this.name,
    required this.active,
    required this.isTestProgramme,
  });

  final String id;
  final String name;
  final bool active;
  final bool isTestProgramme;

  factory Programme.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return Programme(
      id: id,
      name: map['name'] as String? ?? '',
      active: map['active'] as bool? ?? false,
      isTestProgramme: map['isTestProgramme'] as bool? ?? false,
    );
  }
}