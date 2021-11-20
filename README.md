[![pub package](https://img.shields.io/pub/v/buffered_list_stream.svg)](https://pub.dev/packages/buffered_list_stream)
[![Build Status](https://github.com/mgenware/buffered_list_stream/workflows/Build/badge.svg)](https://github.com/mgenware/buffered_list_stream/actions)

Buffer a `Stream<List<T>>`. Useful for IO operations.

## Usage

Install and import this package:

```sh
import 'package:buffered_list_stream/src/buffered_list_stream.dart';
```

Example:

```dart
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
```
