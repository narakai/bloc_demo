import 'package:bloc_demo/rxdart/blocs/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CountBLoC implements BlocBase{
  int _count = 0;
  var _subject = BehaviorSubject<int>();

  Stream<int> get stream => _subject.stream;
  int get value => _count;

  void increment() => _subject.add(++_count);

  void dispose() {
    _subject.close();
  }
}
