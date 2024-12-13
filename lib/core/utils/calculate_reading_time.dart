int calculateReadingTime({
  required String content,
}) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  const averageHumanReadingTime = 225;

  final readingTime = wordCount / averageHumanReadingTime;

  return readingTime.ceil();
}

String calculateReadingTimeChatGPT({
  required String content,
}) {
  // Average reading speed in words per minute
  const int wordsPerMinute = 150;

  // Split the content into words
  final List<String> words = content.split(RegExp(r'\s+'));
  final int wordCount = words.length;

  // Calculate reading time in minutes
  final double readingTimeInMinutes = wordCount / wordsPerMinute;

  // Convert reading time to minutes and seconds
  final int minutes = readingTimeInMinutes.ceil();
  final int seconds = ((readingTimeInMinutes - minutes) * 60).round();

  // Return the result as a formatted string
  if (minutes > 0) {
    return '$minutes minute${minutes > 1 ? 's' : ''} ${seconds > 0 ? 'and $seconds second${seconds > 1 ? 's' : ''}' : ''}';
  } else {
    return '$seconds second${seconds > 1 ? 's' : ''}';
  }
}
