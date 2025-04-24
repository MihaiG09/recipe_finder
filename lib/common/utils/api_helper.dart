class ApiHelper {
  static Future<T> callWithMinimumDuration<T>(
      Future<T> Function() apiCall, Duration minDuration) async {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    T result = await apiCall.call();
    stopwatch.stop();

    if (stopwatch.elapsedMilliseconds < minDuration.inMilliseconds) {
      await Future.delayed(Duration(
          milliseconds:
          minDuration.inMilliseconds - stopwatch.elapsedMilliseconds));
    }
    return result;
  }
}