class CounterRepository {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
  }

  void decrement() {
    _counter--;
  }

  void reset() {
    _counter = 0;
  }
}