-- ============================================================
-- 001_create_profiles.sql
-- Tabla de perfiles de usuario + RLS.
-- Ejecutar en Supabase Dashboard > SQL Editor.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.profiles (
  id                   uuid        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email                text,
  full_name            text,
  age                  integer,
  weight_kg            numeric,
  height_m             numeric,
  imc_value            numeric,
  imc_classification   text,
  recommended_goal     text,
  daily_recommendation text,
  lifestyle_id         text,
  lifestyle_title      text,
  lifestyle_emoji      text,
  created_at           timestamptz DEFAULT now(),
  updated_at           timestamptz DEFAULT now()
);

-- ── Row Level Security ────────────────────────────────────────────────────────
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Cada usuario solo puede leer su propio perfil
CREATE POLICY "users can select own profile"
  ON public.profiles
  FOR SELECT
  USING (auth.uid() = id);

-- Cada usuario solo puede insertar su propio perfil
CREATE POLICY "users can insert own profile"
  ON public.profiles
  FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Cada usuario solo puede actualizar su propio perfil
CREATE POLICY "users can update own profile"
  ON public.profiles
  FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);
