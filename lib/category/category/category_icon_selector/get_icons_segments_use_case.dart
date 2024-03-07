import 'package:hermes_app/category/category/category_icon_selector/models/icon_segment.dart';
import 'package:hermes_app/shared/theme/app_icons.dart';

class GetIconsSegmentsUseCase {
  Future<List<IconSegment>> call() async {
    List<IconSegment> segments = [];

    AppIcons.iconsSegmentsDictionary.forEach(
      (key, value) {
        segments.add(
          IconSegment(
            title: _getSegmentTitleByNickname(key),
            icons: value,
          ),
        );
      },
    );

    return segments;
  }

  String _getSegmentTitleByNickname(String segmentNickname) {
    switch (segmentNickname) {
      case 'bill':
        return 'Casa';
      case 'food':
        return 'Alimentação';
      case 'tech':
        return 'Tecnologia';
      case 'health':
        return 'Saúde e Cuidados';
      case 'transport':
        return 'Transportes';
      case 'investmentAndIncome':
        return 'Receita e Investimentos';
      default:
        return '';
    }
  }
}
