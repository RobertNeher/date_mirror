import 'package:intl/intl.dart';
import 'season_dates.dart';

Map<String, Object> loadSolarData(int year) {
  SeasonDates seasonDates = SeasonDates(year: year);

  return {
    'New Year': DateTime(year, 1, 1),
    'Spring Equinox': seasonDates.springEquinox,
    'Summer Solstice': seasonDates.summerSolstice,
    'Autumn Equinox': seasonDates.autumnEquinox,
    'Winter Solstice': seasonDates.winterSolstice,
    'End of Year': DateTime(year, 12, 31)
  };
}
