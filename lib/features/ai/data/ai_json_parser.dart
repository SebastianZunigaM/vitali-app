import 'dart:convert';

/// Extrae un objeto JSON de la respuesta cruda de Gemini.
/// Tolera texto extra, bloques markdown (```json ... ```) y espacios.
class AiJsonParser {
  AiJsonParser._();

  static Map<String, dynamic>? extractJsonObject(String text) {
    // Intento 1: parseo directo
    try {
      final decoded = jsonDecode(text.trim());
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}

    // Intento 2: extraer primer bloque {...} de texto con contenido extra
    final match = RegExp(r'\{[\s\S]*\}').firstMatch(text);
    if (match != null) {
      try {
        final decoded = jsonDecode(match.group(0)!);
        if (decoded is Map<String, dynamic>) return decoded;
      } catch (_) {}
    }

    return null;
  }
}
