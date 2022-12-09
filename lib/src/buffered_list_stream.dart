/// Holds the given stream with a buffer of specified size.
Stream<List<T>> bufferedListStream<T>(
    Stream<List<T>> stream, int bufferSize) async* {
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
