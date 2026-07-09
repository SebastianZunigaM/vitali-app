import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? '',
        // ignore: deprecated_member_use
        anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
      );
    } catch (e) {
      debugPrint('[SupabaseService] Initialization failed: $e');
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
}
