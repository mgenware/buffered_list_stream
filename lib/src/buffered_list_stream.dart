/// Adds a buffer to [Stream<T>] and returns a [Stream<List<T>>].
/// [bufferSize] cannot be 0.
Stream<List<T>> bufferedStream<T>(Stream<T> stream, int bufferSize) async* {
  if (bufferSize <= 0) {
    throw ArgumentError(
        '$bufferSize is an invalid value for the `bufferSize` argument');
  }
  List<T> buffer = [];
  await for (var data in stream) {
    buffer.add(data);

    while (buffer.length > bufferSize) {
      var part1 = buffer.sublist(0, bufferSize);
      var part2 = buffer.sublist(bufferSize);

      yield part1;
      buffer = part2;
    }
  }
  if (buffer.isNotEmpty) {
    yield buffer;
  }
}

/// Adds a buffer to [Stream<List<T>>] and returns a [Stream<List<T>>].
/// [bufferSize] cannot be 0.
Stream<List<T>> bufferedListStream<T>(
    Stream<List<T>> stream, int bufferSize) async* {
  if (bufferSize <= 0) {
    throw ArgumentError(
        '$bufferSize is an invalid value for the `bufferSize` argument');
  }
  List<T> buffer = [];
  await for (var data in stream) {
    buffer.addAll(data);

    while (buffer.length > bufferSize) {
      var part1 = buffer.sublist(0, bufferSize);
      var part2 = buffer.sublist(bufferSize);

      yield part1;
      buffer = part2;
    }
  }
  if (buffer.isNotEmpty) {
    yield buffer;
  }
}
