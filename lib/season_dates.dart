import 'dart:math';

class SeasonDates {
  static final DateTime julianEpoch = DateTime.utc(-4713, 11, 24, 12, 0, 0);
  int baseYear = 0;
  DateTime _springEquinox = DateTime.now();
  DateTime _summerSolstice = DateTime.now();
  DateTime _autumnEquinox = DateTime.now();
  DateTime _winterSolstice = DateTime.now();

  SeasonDates({int year = 0}) {
    baseYear = (year == 0) ? DateTime.now().year : year;

    num Y = (baseYear - 2000) / 1000;
    num jdSpringEquinox = 2451623.80984 +
        365242.37404 * Y +
        0.05169 * pow(Y, 2) -
        0.00411 * pow(Y, 3) -
        0.00057 * pow(Y, 4);
    _springEquinox = dateFromJulianDay(jdSpringEquinox);

    num jdSummerSolstice = 2451716.56767 +
        365241.62603 * Y +
        0.00325 * pow(Y, 2) +
        0.00888 * pow(Y, 3) -
        0.00030 * pow(Y, 4);
    _summerSolstice = dateFromJulianDay(jdSummerSolstice);

    num jdAutumnEquinox = 2451810.21715 +
        365242.01767 * Y -
        0.11575 * pow(Y, 2) +
        0.00337 * pow(Y, 3) +
        0.00078 * pow(Y, 4);
    _autumnEquinox = dateFromJulianDay(jdAutumnEquinox);

    num jdWinterSolstice = 2451900.05952 +
        365242.74049 * Y -
        0.06223 * pow(Y, 2) -
        0.00823 * pow(Y, 3) +
        0.00032 * pow(Y, 4);
    _winterSolstice = dateFromJulianDay(jdWinterSolstice);
  }

  static int julianDayNumber(DateTime date) =>
      date.difference(SeasonDates.julianEpoch).inDays;

  static num julianDay(DateTime date) =>
      date.difference(julianEpoch).inSeconds / Duration.secondsPerDay;

  static DateTime dateFromJulianDay(num julianDay) => julianEpoch.add(Duration(
      milliseconds: (julianDay * Duration.millisecondsPerDay).floor()));

  static num modifiedJulianDay(DateTime date) => julianDay(date) - 2400000.5;

  DateTime get newYear {
    return DateTime(this.baseYear, 1, 1);
  }

  DateTime get springEquinox {
    return _springEquinox;
  }

  DateTime get summerSolstice {
    return _summerSolstice;
  }

  DateTime get autumnEquinox {
    return _autumnEquinox;
  }

  DateTime get winterSolstice {
    return _winterSolstice;
  }
}
