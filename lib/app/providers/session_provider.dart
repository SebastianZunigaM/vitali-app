import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitali/features/onboarding/domain/models/imc_result_data.dart';
import 'package:vitali/features/onboarding/domain/models/lifestyle_option.dart';

class AppSessionData {
  final ImcResultData? imcResult;
  final LifestyleOption? lifestyle;

  const AppSessionData({this.imcResult, this.lifestyle});

  AppSessionData copyWith({ImcResultData? imcResult, LifestyleOption? lifestyle}) {
    return AppSessionData(
      imcResult: imcResult ?? this.imcResult,
      lifestyle: lifestyle ?? this.lifestyle,
    );
  }
}

final sessionProvider = StateProvider<AppSessionData>(
  (ref) => const AppSessionData(),
);
