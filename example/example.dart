import 'package:buffered_list_stream/buffered_list_stream.dart';

Stream<List<int>> getStream() async* {
  yield [1, 2];
  yield [3];
  yield [4, 5];
  yield [6, 7];
  yield [8, 9, 10];
}

void main() async {
  var bufferedString = bufferedListStream(getStream(), 3);
  await for (var chunk in bufferedString) {
    // ignore: avoid_print
    print(chunk);
  }
  /**
    [1, 2, 3]
    [4, 5, 6, 7]
    [8, 9, 10]
   */
}
