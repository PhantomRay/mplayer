class Utils {
  static String formatTimeStyle(int seconds) {
    if (seconds == null) return '';

    int h = 0, m = 0, s = 0;
    if (seconds <= 59) {
      return "00:" + _formatTimeNumber(seconds);
    } else {
      m = seconds ~/ 60;
      s = seconds % 60;
      if (m <= 59) {
        return _formatTimeNumber(m) + ":" + _formatTimeNumber(s);
      } else {
        h = m ~/ 60;
        m = m % 60;
        return _formatTimeNumber(h) + ":" + _formatTimeNumber(m) + ":" + _formatTimeNumber(s);
      }
    }
  }

  static String _formatTimeNumber(int num) {
    return num.toString().padLeft(2, '0');
  }
}
