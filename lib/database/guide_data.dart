import 'package:login_withpet/database/db_helper.dart';

Future<void> initInsertGuideData() async {
  final guides = [
    {'Code': 101, 'Title': '이별 준비 가이드', 'Tag': '임종'},
    {'Code': 102, 'Title': '장묘업체 선정 가이드', 'Tag': '임종'},
    {'Code': 201, 'Title': '예방접종 가이드', 'Tag': '건강'},
    {'Code': 202, 'Title': '산책 준비 가이드', 'Tag': '건강'},
    {'Code': 301, 'Title': '사료 선택 가이드', 'Tag': '음식'},
  ];

  final Map<int, List<Map<String, dynamic>>> contents = {
    101: [
      {'Num': 1, 'Content': '반려동물의 건강 상태 확인하기'},
      {'Num': 2, 'Content': '반려동물의 주치의와 상의하기'},
      {'Num': 3, 'Content': '반려동물의 추모사진 정리하기'},
      {'Num': 4, 'Content': '사망을 확인하는 방법 알기'},
      {'Num': 5, 'Content': '사후기초수습에 대해 알기'},
      {'Num': 6, 'Content': '사후경직에 대비하기'},
      {'Num': 7, 'Content': '장묘업체 알아보기'},
      {'Num': 8, 'Content': '장례식 전 충분히 애도하기'},
      {'Num': 9, 'Content': '추모물품 제작하기'},
      {'Num': 10, 'Content': '펫로스에 대비하기'},
    ],
    102: [
      {'Num': 1, 'Content': '동물장묘업 등록 여부 확인하기'},
      {'Num': 2, 'Content': '개별 화장 여부 확인하기'},
      {'Num': 3, 'Content': '연락처 및 위치 확인하기'},
      {'Num': 4, 'Content': '비용과 영업시간 확인하기'},
      {'Num': 5, 'Content': '업체에 사전 문의하기'},
    ],
    201: [
      {'Num': 1, 'Content': '예방접종 전 목욕 시키기'},
      {'Num': 2, 'Content': '필요한 예방접종명 파악하기'},
      {'Num': 3, 'Content': '접종일자 및 횟수 기록하기'},
      {'Num': 4, 'Content': '종합건강검진 실시하기'},
      {'Num': 5, 'Content': '예방접종 후 스트레스 요인 예방하기'},
      {'Num': 6, 'Content': '추가 접종 고려하기'},
    ],
    202: [
      {'Num': 1, 'Content': '물 준비하기'},
      {'Num': 2, 'Content': '리드줄 및 하네스 준비하기'},
      {'Num': 3, 'Content': '입마개 고려하기'},
      {'Num': 4, 'Content': '배변봉투 준비하기'},
      {'Num': 5, 'Content': '날씨 및 미세먼지 확인하기'},
      {'Num': 6, 'Content': '진드기 등 벌레 유의하기'},
      {'Num': 7, 'Content': '상태에 따라 산책 시간 조절하기'},
      {'Num': 8, 'Content': '장소 고려하기'},
      {'Num': 9, 'Content': '땅에 떨어진 것을 먹거나 핥지 않도록 주의하기'},
      {'Num': 10, 'Content': '빗질 또는 목욕하기'},
    ],
    301: [
      {'Num': 1, 'Content': '반려동물의 건강 상태 파악하기'},
      {'Num': 2, 'Content': '사료의 종류 확인하기'},
      {'Num': 3, 'Content': '기호성 확인하기'},
      {'Num': 4, 'Content': '원료의 안정성 확인하기'},
      {'Num': 5, 'Content': '성분의 비율 확인하기'},
      {'Num': 6, 'Content': '영양정보 확인하기'},
      {'Num': 7, 'Content': '브랜드 파악하기'},
    ],
  };

  for (final guide in guides) {
    await DatabaseHelper().insertGuide({
      'Code': guide['Code'],
      'Title': guide['Title'],
      'Tag': guide['Tag'],
      'Percent': 0,
      'IsSaved': 0,
    });

    if (contents.containsKey(guide['Code'])) {
      for (final content in contents[guide['Code']]!) {
        await DatabaseHelper().insertContent({
          'G_code': guide['Code'],
          'Number': content['Num'],
          'Content': content['Content'],
        });
      }
    }
  }
}
