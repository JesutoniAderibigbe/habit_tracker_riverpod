class Habit {
  Habit({
    required this.id,
    required this.name,
    this.isCompleted = false,
  });

  final String id;
  final String name;
  final bool isCompleted;

  Habit copyWith({
    String? id,
    String? name,
    bool? isCompleted,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
