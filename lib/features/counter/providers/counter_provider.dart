import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/counter_repository.dart';

final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  return CounterRepository();
});

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  final repository = ref.read(counterRepositoryProvider);
  return CounterNotifier(repository);
});

class CounterNotifier extends StateNotifier<int> {
  final CounterRepository _repository;

  CounterNotifier(this._repository) : super(_repository.counter);

  void increment() {
    _repository.increment();
    state = _repository.counter;
  }

  void decrement() {
    _repository.decrement();
    state = _repository.counter;
  }

  void reset() {
    _repository.reset();
    state = _repository.counter;
  }
}