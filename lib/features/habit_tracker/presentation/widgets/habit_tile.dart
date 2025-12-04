import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_gemini_cli/features/habit_tracker/domain/habit.dart';
import 'package:test_gemini_cli/features/habit_tracker/presentation/providers/habit_providers.dart';

class HabitTile extends ConsumerWidget {
  const HabitTile({
    super.key,
    required this.habit,
  });

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          habit.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            decoration: habit.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            ref.read(habitListProvider.notifier).toggleCompletion(habit.id);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: habit.isCompleted ? Colors.green : Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: habit.isCompleted
                  ? const Icon(Icons.check, color: Colors.white)
                  : const Icon(Icons.check_box_outline_blank,
                      color: Colors.white),
            ),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            ref.read(habitListProvider.notifier).deleteHabit(habit.id);
          },
        ),
      ),
    );
  }
}
