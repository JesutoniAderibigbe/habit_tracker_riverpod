import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_gemini_cli/features/habit_tracker/data/habit_repository.dart';
import 'package:test_gemini_cli/features/habit_tracker/domain/habit.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository();
});

final habitListProvider = StateNotifierProvider<HabitListNotifier, AsyncValue<List<Habit>>>((ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return HabitListNotifier(repository);
});

class HabitListNotifier extends StateNotifier<AsyncValue<List<Habit>>> {
  HabitListNotifier(this._repository) : super(const AsyncValue.loading()) {
    _fetchHabits();
  }

  final HabitRepository _repository;

  Future<void> _fetchHabits() async {
    state = const AsyncValue.loading();
    try {
      final habits = await _repository.getHabits();
      state = AsyncValue.data(habits);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addHabit(String name) async {
    final newHabit = Habit(id: DateTime.now().toString(), name: name);
    await _repository.addHabit(newHabit);
    _fetchHabits();
  }

  Future<void> toggleCompletion(String id) async {
    final habits = state.valueOrNull ?? [];
    final habit = habits.firstWhere((h) => h.id == id);
    final updatedHabit = habit.copyWith(isCompleted: !habit.isCompleted);
    await _repository.updateHabit(updatedHabit);
    _fetchHabits();
  }

  Future<void> deleteHabit(String id) async {
    await _repository.deleteHabit(id);
    _fetchHabits();
  }
}
