String getSeconds(int seconds) {
  if (seconds == null) {
    return "";
  }
  int _minutes = seconds ~/ 60;
  return "${_minutes ~/ 60}h ${_minutes % 60}m";
}
