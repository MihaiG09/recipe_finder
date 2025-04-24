class ApiHelper {
  static Future<T> callWithMinimumDuration<T>(
    Future<T> Function() apiCall,
    Duration minDuration,
  ) async {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    T result = await apiCall.call();
    stopwatch.stop();

    if (stopwatch.elapsedMilliseconds < minDuration.inMilliseconds) {
      await Future.delayed(
        Duration(
          milliseconds:
              minDuration.inMilliseconds - stopwatch.elapsedMilliseconds,
        ),
      );
    }
    return result;
  }

  static String extractJson(String input) {
    final start = input.indexOf('{');
    final end = input.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      return input.substring(start, end + 1);
    }
    return '';
  }
}
