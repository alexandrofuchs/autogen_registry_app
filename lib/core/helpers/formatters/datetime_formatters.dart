extension DateTimeFormatters on DateTime {
  String toDateString([String separator = '/']) {
    return '${day > 9 ? day : '0$day'}$separator${month > 9 ? month : '0$month'}$separator$year';
  }

  String toHourString([String separator = ':', bool showSeconds = false]) =>
    showSeconds ?
      '${hour > 9 ? hour : '0$hour'}$separator${minute > 9 ? minute : '0$minute'}$separator${second > 9 ? second : '0$second'}'
    : '${hour > 9 ? hour : '0$hour'}$separator${minute > 9 ? minute : '0$minute'}';
  
  String toDaysNumberPast() {
    final dateTime = this;

    final days = DateTime.now().difference(dateTime).inDays;
    final hours = DateTime.now().difference(dateTime).inHours;
    

    final now = DateTime.now();
    final y = now.year;
    final m = now.month;
    final d =now.day;

    final todayDuration = DateTime(y, m, d, 23, 59).difference(now);

    
    if(days == 1) return 'ontem às ${dateTime.toHourString()}';
    if(days > 1) return '$days dias atrás às ${dateTime.toHourString()}';

    if(hours > todayDuration.inHours) return 'ontem às ${dateTime.toHourString()}';

    return  'hoje às ${dateTime.toHourString()}';
   
  }
}
