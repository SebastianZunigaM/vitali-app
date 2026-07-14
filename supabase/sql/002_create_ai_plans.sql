-- ============================================================
-- 002_create_ai_plans.sql
-- Tabla para persistir planes IA por usuario.
-- Ejecutar en Supabase Dashboard > SQL Editor.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.ai_plans (
  id                uuid        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  nutrition_plan    jsonb,
  exercise_routine  jsonb,
  created_at        timestamptz DEFAULT now(),
  updated_at        timestamptz DEFAULT now()
);

-- ── Row Level Security ────────────────────────────────────────────────────────
ALTER TABLE public.ai_plans ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users can select own ai plans"
  ON public.ai_plans
  FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "users can insert own ai plans"
  ON public.ai_plans
  FOR INSERT
  WITH CHECK (auth.uid() = id);

CREATE POLICY "users can update own ai plans"
  ON public.ai_plans
  FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);
