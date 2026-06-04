class TranslationDto {
  final String id;
  final String sourceText;
  final String translatedText;
  final String sourceLang;
  final String targetLang;
  final int durationMs;
  final DateTime createdAt;

  const TranslationDto({
    required this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLang,
    required this.targetLang,
    required this.durationMs,
    required this.createdAt,
  });

  factory TranslationDto.fromJson(Map<String, dynamic> json) => TranslationDto(
        id: json['id'] as String,
        sourceText: json['sourceText'] as String? ?? '',
        translatedText: json['translatedText'] as String? ?? '',
        sourceLang: json['sourceLang'] as String? ?? 'auto',
        targetLang: json['targetLang'] as String? ?? 'en',
        durationMs: (json['durationMs'] as num?)?.toInt() ?? 0,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sourceText': sourceText,
        'translatedText': translatedText,
        'sourceLang': sourceLang,
        'targetLang': targetLang,
        'durationMs': durationMs,
        'createdAt': createdAt.toIso8601String(),
      };
}
