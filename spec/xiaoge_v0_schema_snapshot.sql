-- ===============================
-- Xiaoge v0 Schema Snapshot
-- Generated at: 2026-02-07
-- ===============================

-- ========== A2. ENUM / TYPES ==========

CREATE TYPE
 public.accuracy_tier_enum 
AS
 ENUM ('gold', 'standard', 'low', 'unknown');

CREATE TYPE
 public.biomarker_role_enum 
AS
 ENUM ('core', 'auxiliary', 'derived');

CREATE TYPE
 public.chat_role_enum 
AS
 ENUM ('user', 'assistant', 'system', 'tool');

CREATE TYPE
 public.data_source_type_enum 
AS
 ENUM ('manual_input', 'upload', 'device_sync', 'lab_report', 'provider_service', 'questionnaire', 'derived');

CREATE TYPE
 public.editorial_status_enum 
AS
 ENUM ('draft', 'reviewing', 'published', 'deprecated');

CREATE TYPE
 public.freshness_state_enum 
AS
 ENUM ('fresh', 'stale', 'expired', 'unknown');

CREATE TYPE
 public.message_type_enum 
AS
 ENUM ('text', 'system', 'tool', 'event', 'error');

CREATE TYPE
 public.observation_medium_enum 
AS
 ENUM ('bio_sample', 'device', 'questionnaire', 'imaging', 'clinical_exam', 'estimate', 'unknown');

CREATE TYPE
 public.product_type_enum 
AS
 ENUM ('external_curated', 'member_service');

CREATE TYPE
 public.sample_method_enum 
AS
 ENUM ('venous', 'capillary', 'cgm', 'wearable', 'cuff_bp', 'imaging', 'questionnaire', 'estimate', 'unknown');

CREATE TYPE
 public.sample_type_enum 
AS
 ENUM ('blood', 'urine', 'stool', 'saliva', 'buccal_epithelial', 'cervical_fluid', 'pleural_fluid', 'respiratory_mucosa', 'other', 'unknown');

CREATE TYPE
 public.system_code_enum 
AS
 ENUM ('energy', 'metabolic', 'cardiopulmonary', 'musculoskeletal', 'neurocognitive', 'repair_immune');

CREATE TYPE
 public.system_state_enum 
AS
 ENUM ('ideal', 'normal', 'limited', 'impaired', 'invisible');

-- ========== A1. TABLE DEFINITIONS ==========

CREATE TABLE public.biomarker_catalog (

  id uuid NOT NULL,

  biomarker_code text NOT NULL,

  display_name_zh text NOT NULL,

  display_name_en text,

  unit text,

  value_type text NOT NULL,

  description text,

  meta_json jsonb NOT NULL,

  created_at timestamptz NOT NULL,

  updated_at timestamptz NOT NULL

);

CREATE TABLE public.biomarker_observations (

  id uuid NOT NULL,

  user_id uuid,

  biomarker_code text NOT NULL,

  data_source_id uuid,

  observation_medium observation_medium_enum NOT NULL,

  sample_type sample_type_enum,

  sample_method sample_method_enum NOT NULL,

  sampling_context jsonb NOT NULL,

  value_num numeric,

  value_text text,

  value_json jsonb NOT NULL,

  unit text,

  measured_at timestamptz NOT NULL,

  freshness_state freshness_state_enum NOT NULL,

  accuracy_tier accuracy_tier_enum NOT NULL,

  conflict_group_key text,

  is_preferred_for_assessment boolean NOT NULL,

  meta_json jsonb NOT NULL,

  created_at timestamptz NOT NULL,

  updated_at timestamptz NOT NULL

);

CREATE TABLE public.calculation_rules (

  id uuid NOT NULL,

  rule_code text NOT NULL,

  title text NOT NULL,

  description text,

  system_code system_code_enum,

  rule_json jsonb NOT NULL,

  editorial_status editorial_status_enum NOT NULL,

  created_at timestamptz NOT NULL,

  updated_at timestamptz NOT NULL

);

CREATE TABLE public.chat_messages (

  id uuid NOT NULL,

  session_id uuid NOT NULL,

  role chat_role_enum NOT NULL,

  message_type message_type_enum NOT NULL,

  content text NOT NULL,

  linked_system_code system_code_enum,

  created_at timestamptz NOT NULL,

  updated_at timestamptz NOT NULL,

  meta_json jsonb NOT NULL

);

CREATE TABLE public.chat_sessions (

  id uuid NOT NULL,

  user_id uuid,

  channel jsonb NOT NULL,

  session_context jsonb NOT NULL,

  started_at timestamptz NOT NULL,

  ended_at timestamptz,

  meta_json jsonb NOT NULL

);

CREATE TABLE public.data_sources (

  id uuid NOT NULL,

  user_id uuid,

  source_type data_source_type_enum NOT NULL,

  source_name text,

  source_ref text,

  device_type text,

  device_model text,

  reliability_note text,

  meta_json jsonb NOT NULL,

  created_at timestamptz NOT NULL,

  updated_at timestamptz NOT NULL

);

CREATE TABLE public.product_system_map (

-- ========== STRUCTURE RULES (v0) ==========

-- 

-- - products_services.applicable_system_code

-- - product_system_map 

-- -  trigger  DDL-2.product_system_rules.sql

-- =========================================

  id uuid NOT NULL,

  product_service_id uuid NOT NULL,

  system_code system_code_enum NOT NULL,

  relevance_note text,

  created_at timestamptz NOT NULL

);

CREATE TABLE public.products_services (

  id uuid NOT NULL,

  product_type product_type_enum NOT NULL,

  name text NOT NULL,

  brand text,

  description text,

  applicable_system_code system_code_enum,

  member_price_cny numeric,

  market_price_cny numeric,

  savings_cny numeric,

  has_member_discount boolean NOT NULL,

  commission_cny numeric NOT NULL,

  commission_note text,

  purchase_url text,

  coupon_code text,

  compliance_notes text,

  evidence_links jsonb NOT NULL,

  editorial_status editorial_status_enum NOT NULL,

  meta_json jsonb NOT NULL,

  created_at timestamptz NOT NULL,

  updated_at timestamptz NOT NULL

);

-- ========== A3. CONSTRAINTS ==========

CREATE
 
UNIQUE
 
INDEX
 biomarker_catalog_biomarker_code_key 
ON
 public.biomarker_catalog 
USING
 btree (biomarker_code)

CREATE
 
UNIQUE
 
INDEX
 biomarker_catalog_pkey 
ON
 public.biomarker_catalog 
USING
 btree (id)

CREATE
 
UNIQUE
 
INDEX
 biomarker_observations_pkey 
ON
 public.biomarker_observations 
USING
 btree (id)

CREATE
 
INDEX
 idx_obs_data_source 
ON
 public.biomarker_observations 
USING
 btree (data_source_id)

CREATE
 
INDEX
 idx_obs_user_biomarker_measured_at 
ON
 public.biomarker_observations 
USING
 btree (user_id, biomarker_code, measured_at 
DESC
)

CREATE
 
INDEX
 idx_obs_user_measured_at 
ON
 public.biomarker_observations 
USING
 btree (user_id, measured_at 
DESC
)

CREATE
 
UNIQUE
 
INDEX
 calculation_rules_pkey 
ON
 public.calculation_rules 
USING
 btree (id)

CREATE
 
UNIQUE
 
INDEX
 calculation_rules_rule_code_key 
ON
 public.calculation_rules 
USING
 btree (rule_code)

CREATE
 
UNIQUE
 
INDEX
 chat_messages_pkey 
ON
 public.chat_messages 
USING
 btree (id)

CREATE
 
INDEX
 idx_chat_messages_session_time 
ON
 public.chat_messages 
USING
 btree (session_id, created_at)

CREATE
 
UNIQUE
 
INDEX
 chat_sessions_pkey 
ON
 public.chat_sessions 
USING
 btree (id)

CREATE
 
INDEX
 idx_chat_sessions_user_time 
ON
 public.chat_sessions 
USING
 btree (user_id, started_at 
DESC
)

CREATE
 
UNIQUE
 
INDEX
 data_sources_pkey 
ON
 public.data_sources 
USING
 btree (id)

CREATE
 
INDEX
 idx_product_system_map_system 
ON
 public.product_system_map 
USING
 btree (system_code)

CREATE
 
UNIQUE
 
INDEX
 product_system_map_pkey 
ON
 public.product_system_map 
USING
 btree (id)

CREATE
 
UNIQUE
 
INDEX
 uq_product_system_unique 
ON
 public.product_system_map 
USING
 btree (product_service_id, system_code)

CREATE
 
INDEX
 idx_products_primary_system 
ON
 public.products_services 
USING
 btree (applicable_system_code)

CREATE
 
UNIQUE
 
INDEX
 products_services_pkey 
ON
 public.products_services 
USING
 btree (id)

-- ========== A4. INDEXES ==========

data_sources_pkey	
PRIMARY KEY
 (id)
biomarker_catalog_pkey	
PRIMARY KEY
 (id)
biomarker_catalog_biomarker_code_key	
UNIQUE
 (biomarker_code)
chk_commission_zero	
CHECK
 ((commission_cny = (0)::
numeric
))
products_services_pkey	
PRIMARY KEY
 (id)
product_system_map_pkey	
PRIMARY KEY
 (id)
uq_product_system_unique	
UNIQUE
 (product_service_id, system_code)
product_system_map_product_service_id_fkey	
FOREIGN
 
KEY
 (product_service_id) 
REFERENCES
 products_services(id) 
ON
 
DELETE
 
CASCADE

calculation_rules_pkey	
PRIMARY KEY
 (id)
calculation_rules_rule_code_key	
UNIQUE
 (rule_code)
chk_bio_sample_requires_sample_type	
CHECK
 (((observation_medium <> 'bio_sample'::observation_medium_enum) 
OR
 (sample_type 
IS
 
NOT
 
NULL
)))
biomarker_observations_pkey	
PRIMARY KEY
 (id)
biomarker_observations_biomarker_code_fkey	
FOREIGN
 
KEY
 (biomarker_code) 
REFERENCES
 biomarker_catalog(biomarker_code) 
ON
 
UPDATE
 
CASCADE

biomarker_observations_data_source_id_fkey	
FOREIGN
 
KEY
 (data_source_id) 
REFERENCES
 data_sources(id) 
ON
 
DELETE
 
SET
 
NULL

chat_sessions_pkey	
PRIMARY KEY
 (id)
chat_messages_pkey	
PRIMARY KEY
 (id)
chat_messages_session_id_fkey	
FOREIGN
 
KEY
 (session_id) 
REFERENCES
 chat_sessions(id) 
ON
 
DELETE
 
CASCADE
