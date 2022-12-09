import 'package:buffered_list_stream/src/buffered_list_stream.dart';
import 'package:test/test.dart';

Stream<List<int>> getStream() async* {
  yield [1, 2, 3];
  yield [4];
  yield [5, 6];
  yield [7, 8, 9];
}

Future<List<List<int>>> t(int size) async {
  List<List<int>> result = [];
  await for (var chunk in bufferedListStream(getStream(), size)) {
    result.add(chunk);
  }
  return result;
}

void main() {
  test('Tiny size', () async {
    expect(await t(1), [
      [1],
      [2],
      [3],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9]
    ]);
  });

  test('Small size', () async {
    expect(await t(2), [
      [1, 2],
      [3, 4],
      [5, 6],
      [7, 8],
      [9]
    ]);
  });

  test('Large size', () async {
    expect(await t(5), [
      [1, 2, 3, 4, 5],
      [6, 7, 8, 9]
    ]);
  });

  test('Extra large size', () async {
    expect(await t(10), [
      [1, 2, 3, 4, 5, 6, 7, 8, 9]
    ]);
  });
}
