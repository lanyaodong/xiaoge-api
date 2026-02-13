-- ===============================
-- Xiaoge v0 Schema Snapshot (CI-minimal, NO FK)
-- Purpose: make CI e2e tests runnable (create required types/tables only)
-- ===============================

BEGIN;

-- Needed for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- -------------------------
-- Enums (must match app casts)
-- -------------------------
DO $$ BEGIN
  CREATE TYPE observation_medium_enum AS ENUM ('bio_sample', 'device', 'manual');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TYPE sample_type_enum AS ENUM ('blood', 'urine', 'stool', 'saliva', 'other');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TYPE sample_method_enum AS ENUM ('venous', 'capillary', 'wearable', 'lab', 'other');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TYPE freshness_state_enum AS ENUM ('fresh', 'stale', 'unknown');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TYPE accuracy_tier_enum AS ENUM ('standard', 'high', 'unknown');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Systems
DO $$ BEGIN
  CREATE TYPE system_code_enum AS ENUM ('metabolic', 'energy', 'cardio', 'musculoskeletal', 'neuro', 'repair_immune');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TYPE system_state_enum AS ENUM ('ideal', 'normal', 'borderline', 'high_risk', 'unknown');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- -------------------------
-- Tables
-- -------------------------

-- Minimal data_sources (optional, but useful)
CREATE TABLE IF NOT EXISTS data_sources (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- biomarker_observations: must match INSERT in app/main.py
CREATE TABLE IF NOT EXISTS biomarker_observations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  biomarker_code text NOT NULL,
  data_source_id uuid NULL,

  observation_medium observation_medium_enum NOT NULL,
  sample_type sample_type_enum NULL,
  sample_method sample_method_enum NULL,
  sampling_context jsonb NOT NULL DEFAULT '{}'::jsonb,

  value_num numeric NULL,
  value_text text NULL,
  value_json jsonb NOT NULL DEFAULT '{}'::jsonb,
  unit text NULL,

  measured_at timestamptz NOT NULL,
  freshness_state freshness_state_enum NOT NULL DEFAULT 'unknown',
  accuracy_tier accuracy_tier_enum NOT NULL DEFAULT 'unknown'
);

-- Make latest lookup fast in CI
CREATE INDEX IF NOT EXISTS idx_obs_user_biomarker_measured
  ON biomarker_observations (user_id, biomarker_code, measured_at DESC);

-- system assessments
CREATE TABLE IF NOT EXISTS system_assessments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  system_code system_code_enum NOT NULL,
  system_state system_state_enum NOT NULL DEFAULT 'unknown',
  confidence_note text NULL,
  evidence jsonb NOT NULL DEFAULT '{}'::jsonb,
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, system_code)
);

-- recommendations (kept flexible with jsonb)
CREATE TABLE IF NOT EXISTS recommendations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  system_code system_code_enum NOT NULL,
  title text NOT NULL,
  items jsonb NOT NULL DEFAULT '[]'::jsonb,
  products jsonb NOT NULL DEFAULT '[]'::jsonb,
  updated_at timestamptz NOT NULL DEFAULT now()
);

COMMIT;
