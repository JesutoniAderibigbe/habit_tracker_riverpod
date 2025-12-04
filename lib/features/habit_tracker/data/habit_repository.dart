import 'package:test_gemini_cli/features/habit_tracker/domain/habit.dart';

class HabitRepository {
  final List<Habit> _habits = [
    Habit(id: '1', name: 'Read a book'),
    Habit(id: '2', name: 'Go for a run', isCompleted: true),
    Habit(id: '3', name: 'Meditate'),
  ];

  Future<List<Habit>> getHabits() async {
    await Future.delayed(const Duration(seconds: 1));
    return _habits;
  }

  Future<void> addHabit(Habit habit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _habits.add(habit);
  }

  Future<void> updateHabit(Habit habit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
    }
  }

  Future<void> deleteHabit(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _habits.removeWhere((h) => h.id == id);
  }
}
