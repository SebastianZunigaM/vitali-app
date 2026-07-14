import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Servicio singleton para comunicarse con la API de Gemini.
/// Lee GEMINI_API_KEY desde .env — nunca hardcodeada.
class GeminiService {
  GeminiService._();

  static GenerativeModel? _model;

  static void initialize() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty || apiKey == 'your_gemini_api_key_here') {
      debugPrint('[GeminiService] GEMINI_API_KEY no configurada — IA deshabilitada.');
      return;
    }
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.7,
        maxOutputTokens: 1024,
      ),
    );
    debugPrint('[GeminiService] Modelo inicializado correctamente.');
  }

  /// Envía [prompt] a Gemini y retorna el texto JSON de la respuesta.
  /// Lanza [GeminiServiceException] si el modelo no está listo o falla.
  static Future<String> generateText(String prompt) async {
    if (_model == null) {
      throw const GeminiServiceException(
        'GeminiService no inicializado. Verifica GEMINI_API_KEY en .env.',
      );
    }
    try {
      final response = await _model!.generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text == null || text.trim().isEmpty) {
        throw const GeminiServiceException('Gemini retornó una respuesta vacía.');
      }
      return text;
    } on GeminiServiceException {
      rethrow;
    } catch (e) {
      throw GeminiServiceException('Error al llamar a Gemini: $e');
    }
  }

  static bool get isAvailable => _model != null;
}

class GeminiServiceException implements Exception {
  final String message;
  const GeminiServiceException(this.message);

  @override
  String toString() => 'GeminiServiceException: $message';
}
