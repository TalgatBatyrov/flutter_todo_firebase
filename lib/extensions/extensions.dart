extension MapWithIndex<T> on List<T> {
  void forEachWithIndex(void Function(T element, int index) f) {
    var index = 0;
    for (final element in this) {
      f(element, index);
      index++;
    }
  }
}
