import 'package:intl/intl.dart';
import 'package:placement_app/data/api/api.dart';

String getImageUrl(String path) => API().getImageUrl(path);

String getFormatedDate(DateTime time) {
  var format = DateFormat("MMMM dd, yyyy");
  return format.format(time);
}
