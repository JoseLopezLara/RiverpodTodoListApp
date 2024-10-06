class Task {
  final String title;
  final bool isCompleted;

  Task({
    required this.title,
    this.isCompleted = false,
  });

  Task copyWith({String? title, bool? isCompleted}) {
    return Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
