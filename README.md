[![pub package](https://img.shields.io/pub/v/buffered_list_stream.svg)](https://pub.dev/packages/buffered_list_stream)
[![Build Status](https://github.com/mgenware/buffered_list_stream/workflows/Build/badge.svg)](https://github.com/mgenware/buffered_list_stream/actions)

Creates a buffered stream from `Stream<T>` or `Stream<List<T>>`.

## API

```dart
/// Adds a buffer to [Stream<T>] and returns a [Stream<List<T>>].
/// [bufferSize] cannot be 0.
Stream<List<T>> bufferedStream<T>(Stream<T> stream, int bufferSize)

/// Adds a buffer to [Stream<List<T>>] and returns a [Stream<List<T>>].
/// [bufferSize] cannot be 0.
Stream<List<T>> bufferedListStream<T>(Stream<List<T>> stream, int bufferSize);
```

## Example

```dart
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
  /**
    [1, 2, 3]
    [4, 5, 6]
    [7, 8, 9]
    [10]
   */

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

```
