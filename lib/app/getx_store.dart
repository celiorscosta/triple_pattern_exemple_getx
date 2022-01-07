import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

abstract class GetXStore<Error extends Object, State extends Object>
    extends Store<Error, State> {
  late final _selectState = Rx<State>(triple.state);
  late final _selectError = Rx<Error?>(null);
  late final selectLoading = Rx<bool>(triple.isLoading);

  @override
  State get state => _selectState.value;

  @override
  Error? get error => _selectError.value;

  @override
  bool get isLoading => selectLoading.value;

  @override
  void propagate(Triple<Error, State> triple) {
    super.propagate(triple);
    if (triple.event == TripleEvent.state) {
      _selectState.value = triple.state;
    } else if (triple.event == TripleEvent.loading) {
      selectLoading.value = triple.isLoading;
    } else if (triple.event == TripleEvent.error) {
      _selectError.value = triple.error;
    }
  }

  @override
  Disposer observer(
      {void Function(State state)? onState,
      void Function(bool loading)? onLoading,
      void Function(Error error)? onError}) {
    final list = <StreamSubscription>[];

    if (onState != null) {
      list.add(_selectState.stream.listen(onState));
    } else if (onLoading != null) {
      list.add(selectLoading.stream.listen(onLoading));
    } else if (onError != null) {
      list.add(_selectError.stream.listen((e) => onError));
    }

    return () async {
      for (var sub in list) {
        await sub.cancel();
      }
    };
  }

  @override
  Future destroy() async {
    _selectState.close();
    selectLoading.close();
    _selectError.close();
  }

  GetXStore(State initialState) : super(initialState);
}
