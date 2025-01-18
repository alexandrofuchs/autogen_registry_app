extension DateTimeFormatters on DateTime {
  String toDateString([String separator = '/']) {
    return '${day > 9 ? day : '0$day'}$separator${month > 9 ? month : '0$month'}$separator$year';
  }

  String toHourString([String separator = ':', bool showSeconds = false]) =>
    showSeconds ?
      '${hour > 9 ? hour : '0$hour'}$separator${minute > 9 ? minute : '0$minute'}$separator${second > 9 ? second : '0$second'}'
    : '${hour > 9 ? hour : '0$hour'}$separator${minute > 9 ? minute : '0$minute'}';
  
  String toDaysNumberPast() {
    final days = difference(DateTime.now()).inDays;
    final hours = difference(DateTime.now()).inHours;

    final now = DateTime.now();
    final y = now.year;
    final m = now.month;
    final d =now.day;

    final todayDuration = now.difference(DateTime(y, m, d, 23, 59));

    if(days > 1){
      return '$days dias atrás';
    }
    if(days == 1) return 'ontem';

    if(todayDuration.inHours < hours){
      return 'ontem';
    }

    return 'hoje';
  }
}
