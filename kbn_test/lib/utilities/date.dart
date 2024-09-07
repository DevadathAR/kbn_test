String calculateDaysAgo(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateTime now = DateTime.now();
  Duration difference = now.difference(date);

  int days = difference.inDays;
  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;

  if (days > 0) {
    return 'posted $days days ago';
  } else if (hours > 0) {
    return 'posted $hours hours ago';
  } else if (minutes > 0) {
    return 'posted $minutes minutes ago';
  } else {
    return 'posted just now';
  }
}