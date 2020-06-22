String mapDayNumToName(int dayNum) {
  String day = '';
  switch (dayNum) {
    case 1:
      day = 'السبت';
      break;
    case 2:
      day = 'الأحد';
      break;
    case 3:
      day = 'الإثنين';
      break;
    case 4:
      day = 'الثلاثاء';
      break;
    case 5:
      day = 'الأربعاء';
      break;
    case 6:
      day = 'الخميس';
      break;
    case 7:
      day = 'الجمعة';
      break;
  }
  return day;
}

String mapMonthNumToName(int monthNum) {
  String month = '';
  switch (monthNum) {
    case 1:
      month = 'يناير';
      break;
    case 2:
      month = 'فبراير';
      break;
    case 3:
      month = 'مارس';
      break;
    case 4:
      month = 'ابريل';
      break;
    case 5:
      month = 'مايو';
      break;
    case 6:
      month = 'يونيو';
      break;
    case 7:
      month = 'يوليو';
      break;
    case 8:
      month = 'أغسطس';
      break;
    case 9:
      month = 'سبتمبر';
      break;
    case 10:
      month = 'أكتوبر';
      break;
    case 11:
      month = 'نوفمبر';
      break;
    case 12:
      month = 'ديسمبر';
      break;
  }
  return month;
}

String determineTime(int hour, int minutes) {
  String min = (minutes.toString().length == 1) ? '0' : '';
  if (hour < 12) {
    return hour.toString() + ':' + min + minutes.toString() + ' صباحاً';
  } else if (hour > 12 && hour < 24) {
    hour = hour - 12;
    return hour.toString() + ':' + min + minutes.toString() + ' مساءاً ';
  } else if (hour == 12) {
    return hour.toString() + ':' + min + minutes.toString() + ' مساءاً ';
  } else if (hour == 24) {
    return '00:00 صباحاً ';
  } else {
    return '';
  }
}
