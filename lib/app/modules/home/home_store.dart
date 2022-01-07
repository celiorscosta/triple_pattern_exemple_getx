import 'package:flutter_triple/flutter_triple.dart';
import 'package:mobx_triple/mobx_triple.dart';
import 'package:triple_pattern_exemple_getx/app/getx_store.dart';

class HomeStore extends GetXStore<Exception, int> {
  HomeStore() : super(0);

  Future<void> increment() async {
    setLoading(true);

    await Future.delayed(Duration(seconds: 1));

    int value = state + 1;
    if (value < 5) {
      update(value);
    } else {
      setError(Exception('Error: state not can be > 4'));
    }

    setLoading(false);
  }
}
