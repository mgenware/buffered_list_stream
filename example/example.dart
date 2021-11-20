import 'package:buffered_list_stream/src/buffered_list_stream.dart';

Stream<List<int>> getStream() async* {
  yield [1, 2];
  yield [3];
  yield [4, 5];
  yield [6, 7];
  yield [8, 9, 10];
}

void main() async {
  await for (var chunk in bufferedListStream(getStream(), 3)) {
    // ignore: avoid_print
    print(chunk);
  }
  /**
    [1, 2, 3]
    [4, 5, 6, 7]
    [8, 9, 10]
   */
}
