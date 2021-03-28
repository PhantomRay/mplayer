import '../lib/services/api_service.dart';
import 'package:test/test.dart';

void main() {
  group('Api Service', () {
    test(':Not Found', () async {
      var models = await ApiService.search(keyword: 'test api service');
      expect(models.length, 0);
    });

    test(':Found', () async {
      var models = await ApiService.search(keyword: 'lana');
      expect(models.length, 25);
    });
  });
}
