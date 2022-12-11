// ignore_for_file: avoid_print

import 'package:buffered_list_stream/buffered_list_stream.dart';

Stream<int> getStream() =>
    Stream<int>.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

Stream<List<int>> getChuckedStream() async* {
  yield [1, 2];
  yield [3];
  yield [4, 5];
  yield [6, 7];
  yield [8, 9, 10];
}

const bufferSize = 3;

void main() async {
  // Create a buffered stream from a stream.
  var bs1 = bufferedStream(getStream(), bufferSize);
  await for (var chunk in bs1) {
    print(chunk);
  }

  print('------');

  // Create a buffered stream from a chucked stream.
  var bs2 = bufferedListStream(getChuckedStream(), bufferSize);
  await for (var chunk in bs2) {
    print(chunk);
  }
  /**
    [1, 2, 3]
    [4, 5, 6]
    [7, 8, 9]
    [10]
   */
}
