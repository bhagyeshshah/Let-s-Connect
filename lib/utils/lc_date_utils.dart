class LcDateDbUtils{
  static num getLastUpdatedNegativeTimeStamp(){
    return DateTime.now().toUtc().millisecondsSinceEpoch * -1;
  }
  static String feedTime(int timestamp) {
    // Current timestamp
    int now = DateTime.now().millisecondsSinceEpoch;

    // Difference in milliseconds
    int difference = now - timestamp;

    // Calculate difference in seconds, minutes, hours, and days
    int seconds = (difference / 1000).round();
    int minutes = (seconds / 60).round();
    int hours = (minutes / 60).round();
    int days = (hours / 24).round();

    if (days >= 30) {
      // If more than 30 days, return the date
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return '${date.day}/${date.month}/${date.year}';
    } else if (days > 0) {
      // If days are greater than 0, return days
      return '$days days ago';
    } else if (hours > 0) {
      // If hours are greater than 0, return hours
      return '$hours hours ago';
    } else if (minutes > 0) {
      // If minutes are greater than 0, return minutes
      return '$minutes minutes ago';
    } else {
      // Otherwise, return seconds
      return '$seconds seconds ago';
    }
  }
}