extension DateTimeExtension on DateTime {
  String displayDate() {
    return "${this.getDay()} ${this.shortMonth()} ${this.year}";
  }

  String getMonth() {
    if (this.month > 9) {
      return "${this.month}";
    }
    return "0${this.month}";
  }

  String getDay() {
    if (this.day > 9) {
      return "${this.day}";
    }
    return "0${this.day}";
  }

  String shortMonth() {
    switch (this.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      default:
        return 'Dec';
    }
  }
}
