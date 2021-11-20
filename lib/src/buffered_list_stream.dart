/// Holds the given stream with a buffer of specified size.
Stream<List<T>> bufferedListStream<T>(
    Stream<List<T>> stream, int bufferSize) async* {
  List<T> buffer = [];
  await for (var data in stream) {
    buffer.addAll(data);
    if (buffer.length >= bufferSize) {
      yield buffer;
      buffer = [];
    }
  }
  if (buffer.isNotEmpty) {
    yield buffer;
  }
}
