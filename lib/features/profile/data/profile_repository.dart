import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitali/core/services/supabase_service.dart';
import 'package:vitali/features/profile/domain/models/profile_data.dart';

class ProfileRepository {
  final SupabaseClient _client;

  const ProfileRepository(this._client);

  /// Inserta o actualiza el perfil del usuario autenticado.
  Future<void> upsertProfile(ProfileData profile) async {
    await _client.from('profiles').upsert(profile.toJson());
  }

  /// Retorna el perfil del usuario actual, o null si no existe / no hay sesión.
  Future<ProfileData?> getCurrentProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final response = await _client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;
    return ProfileData.fromJson(response);
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(SupabaseService.client),
);
