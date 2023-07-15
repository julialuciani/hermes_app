
class SqlUtils {
  static List<String> getMigrationQueries(String file) {
    return file.split('--SPLIT--');
  }
}
