import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_gemini_cli/features/habit_tracker/presentation/providers/habit_providers.dart';
import 'package:test_gemini_cli/features/habit_tracker/presentation/widgets/add_habit_dialog.dart';
import 'package:test_gemini_cli/features/habit_tracker/presentation/widgets/habit_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitList = ref.watch(habitListProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('My Habits'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: habitList.when(
        data: (habits) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            return HabitTile(habit: habit);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddHabitDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
