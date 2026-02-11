{\rtf1\ansi\ansicpg936\cocoartf2821
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;\f1\fnil\fcharset0 Menlo-Bold;}
{\colortbl;\red255\green255\blue255;\red128\green128\blue128;\red128\green0\blue0;\red0\green128\blue0;
\red255\green0\blue0;\red0\green0\blue128;\red0\green0\blue255;}
{\*\expandedcolortbl;;\csgenericrgb\c50196\c50196\c50196;\csgenericrgb\c50196\c0\c0;\csgenericrgb\c0\c50196\c0;
\csgenericrgb\c100000\c0\c0;\csgenericrgb\c0\c0\c50196;\csgenericrgb\c0\c0\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww27000\viewh13480\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf0 \
\pard\pardeftab720\partightenfactor0
\cf2 -- ===============================\\\cf0 \
\cf2 -- Xiaoge v0 Schema Snapshot\\\cf0 \
\cf2 -- Generated at: 2026-02-07\\\cf0 \
\cf2 -- ===============================\\\cf0 \
\\\
\cf2 -- ========== A2. ENUM / TYPES ==========\\\cf0 \
\\\
\\pard\\tx720\\tx1440\\tx2160\\tx2880\\tx3600\\tx4320\\tx5040\\tx5760\\tx6480\\tx7200\\tx7920\\tx8640\\pardirnatural\\partightenfactor0\
\\cf0 
\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.accuracy_tier_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'gold'\cf0 , \cf4 'standard'\cf0 , \cf4 'low'\cf0 , \cf4 'unknown'\cf0 )\cf5 ;\cf0 \\\
\pard\pardeftab720\partightenfactor0

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.biomarker_role_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'core'\cf0 , \cf4 'auxiliary'\cf0 , \cf4 'derived'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.chat_role_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'user'\cf0 , \cf4 'assistant'\cf0 , \cf4 'system'\cf0 , \cf4 'tool'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.data_source_type_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'manual_input'\cf0 , \cf4 'upload'\cf0 , \cf4 'device_sync'\cf0 , \cf4 'lab_report'\cf0 , \cf4 'provider_service'\cf0 , \cf4 'questionnaire'\cf0 , \cf4 'derived'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.editorial_status_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'draft'\cf0 , \cf4 'reviewing'\cf0 , \cf4 'published'\cf0 , \cf4 'deprecated'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.freshness_state_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'fresh'\cf0 , \cf4 'stale'\cf0 , \cf4 'expired'\cf0 , \cf4 'unknown'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.message_type_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'text'\cf0 , \cf4 'system'\cf0 , \cf4 'tool'\cf0 , \cf4 'event'\cf0 , \cf4 'error'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.observation_medium_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'bio_sample'\cf0 , \cf4 'device'\cf0 , \cf4 'questionnaire'\cf0 , \cf4 'imaging'\cf0 , \cf4 'clinical_exam'\cf0 , \cf4 'estimate'\cf0 , \cf4 'unknown'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.product_type_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'external_curated'\cf0 , \cf4 'member_service'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.sample_method_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'venous'\cf0 , \cf4 'capillary'\cf0 , \cf4 'cgm'\cf0 , \cf4 'wearable'\cf0 , \cf4 'cuff_bp'\cf0 , \cf4 'imaging'\cf0 , \cf4 'questionnaire'\cf0 , \cf4 'estimate'\cf0 , \cf4 'unknown'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.sample_type_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'blood'\cf0 , \cf4 'urine'\cf0 , \cf4 'stool'\cf0 , \cf4 'saliva'\cf0 , \cf4 'buccal_epithelial'\cf0 , \cf4 'cervical_fluid'\cf0 , \cf4 'pleural_fluid'\cf0 , \cf4 'respiratory_mucosa'\cf0 , \cf4 'other'\cf0 , \cf4 'unknown'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.system_code_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'energy'\cf0 , \cf4 'metabolic'\cf0 , \cf4 'cardiopulmonary'\cf0 , \cf4 'musculoskeletal'\cf0 , \cf4 'neurocognitive'\cf0 , \cf4 'repair_immune'\cf0 )\cf5 ;\cf0 \\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 TYPE
\f0\b0 \cf0  public.system_state_enum 
\f1\b \cf3 AS
\f0\b0 \cf0  ENUM (\cf4 'ideal'\cf0 , \cf4 'normal'\cf0 , \cf4 'limited'\cf0 , \cf4 'impaired'\cf0 , \cf4 'invisible'\cf0 )\cf5 ;\cf0 \\\
\\\
\\pard\\tx720\\tx1440\\tx2160\\tx2880\\tx3600\\tx4320\\tx5040\\tx5760\\tx6480\\tx7200\\tx7920\\tx8640\\pardirnatural\\partightenfactor0\
\\cf0 \\\
\pard\pardeftab720\partightenfactor0
\cf2 -- ========== A1. TABLE DEFINITIONS ==========\\\cf0 \
\\\
\\pard\\tx720\\tx1440\\tx2160\\tx2880\\tx3600\\tx4320\\tx5040\\tx5760\\tx6480\\tx7200\\tx7920\\tx8640\\pardirnatural\\partightenfactor0\
\\cf0 
\f1\b \cf6 "CREATE TABLE public.biomarker_catalog (\\
\f0\b0 \cf0 \
\pard\pardeftab720\partightenfactor0

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   biomarker_code text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   display_name_zh text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   display_name_en text,\\
\f0\b0 \cf0 \

\f1\b \cf6   unit text,\\
\f0\b0 \cf0 \

\f1\b \cf6   value_type text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   description text,\\
\f0\b0 \cf0 \

\f1\b \cf6   meta_json jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   created_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   updated_at timestamptz NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\

\f1\b \cf6 "CREATE TABLE public.biomarker_observations (\\
\f0\b0 \cf0 \

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   user_id uuid,\\
\f0\b0 \cf0 \

\f1\b \cf6   biomarker_code text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   data_source_id uuid,\\
\f0\b0 \cf0 \

\f1\b \cf6   observation_medium observation_medium_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   sample_type sample_type_enum,\\
\f0\b0 \cf0 \

\f1\b \cf6   sample_method sample_method_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   sampling_context jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   value_num numeric,\\
\f0\b0 \cf0 \

\f1\b \cf6   value_text text,\\
\f0\b0 \cf0 \

\f1\b \cf6   value_json jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   unit text,\\
\f0\b0 \cf0 \

\f1\b \cf6   measured_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   freshness_state freshness_state_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   accuracy_tier accuracy_tier_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   conflict_group_key text,\\
\f0\b0 \cf0 \

\f1\b \cf6   is_preferred_for_assessment boolean NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   meta_json jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   created_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   updated_at timestamptz NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\

\f1\b \cf6 "CREATE TABLE public.calculation_rules (\\
\f0\b0 \cf0 \

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   rule_code text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   title text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   description text,\\
\f0\b0 \cf0 \

\f1\b \cf6   system_code system_code_enum,\\
\f0\b0 \cf0 \

\f1\b \cf6   rule_json jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   editorial_status editorial_status_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   created_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   updated_at timestamptz NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\

\f1\b \cf6 "CREATE TABLE public.chat_messages (\\
\f0\b0 \cf0 \

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   session_id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   role chat_role_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   message_type message_type_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   content text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   linked_system_code system_code_enum,\\
\f0\b0 \cf0 \

\f1\b \cf6   created_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   updated_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   meta_json jsonb NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\

\f1\b \cf6 "CREATE TABLE public.chat_sessions (\\
\f0\b0 \cf0 \

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   user_id uuid,\\
\f0\b0 \cf0 \

\f1\b \cf6   channel jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   session_context jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   started_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   ended_at timestamptz,\\
\f0\b0 \cf0 \

\f1\b \cf6   meta_json jsonb NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\

\f1\b \cf6 "CREATE TABLE public.data_sources (\\
\f0\b0 \cf0 \

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   user_id uuid,\\
\f0\b0 \cf0 \

\f1\b \cf6   source_type data_source_type_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   source_name text,\\
\f0\b0 \cf0 \

\f1\b \cf6   source_ref text,\\
\f0\b0 \cf0 \

\f1\b \cf6   device_type text,\\
\f0\b0 \cf0 \

\f1\b \cf6   device_model text,\\
\f0\b0 \cf0 \

\f1\b \cf6   reliability_note text,\\
\f0\b0 \cf0 \

\f1\b \cf6   meta_json jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   created_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   updated_at timestamptz NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\

\f1\b \cf6 "CREATE TABLE public.product_system_map (\\
\f0\b0 \cf0 \
\

\f1\b \cf6 -- ========== STRUCTURE RULES (v0) ==========
\f0\b0 \cf0 \

\f1\b \cf6 -- \uc0\u21333 \u20027 \u22810 \u36741 \u35268 \u21017 \u65306 
\f0\b0 \cf0 \

\f1\b \cf6 -- - \uc0\u27599 \u20010 \u21830 \u21697 \u21482 \u33021 \u26377 \u19968 \u20010 \u20027 \u31995 \u32479 \u65306 products_services.applicable_system_code
\f0\b0 \cf0 \

\f1\b \cf6 -- - product_system_map \uc0\u20165 \u23384 \u25918 \u25193 \u23637 \u31995 \u32479 \u65288 \u19981 \u24471 \u20986 \u29616 \u20027 \u31995 \u32479 \u65289 
\f0\b0 \cf0 \

\f1\b \cf6 -- - \uc0\u35813 \u35268 \u21017 \u30001 \u25968 \u25454 \u24211  trigger \u24378 \u21046 \u20445 \u35777 \u65288 \u35265  DDL-2.product_system_rules.sql\u65289 
\f0\b0 \cf0 \

\f1\b \cf6 -- =========================================
\f0\b0 \cf0 \

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   product_service_id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   system_code system_code_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   relevance_note text,\\
\f0\b0 \cf0 \

\f1\b \cf6   created_at timestamptz NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\

\f1\b \cf6 "CREATE TABLE public.products_services (\\
\f0\b0 \cf0 \

\f1\b \cf6   id uuid NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   product_type product_type_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   name text NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   brand text,\\
\f0\b0 \cf0 \

\f1\b \cf6   description text,\\
\f0\b0 \cf0 \

\f1\b \cf6   applicable_system_code system_code_enum,\\
\f0\b0 \cf0 \

\f1\b \cf6   member_price_cny numeric,\\
\f0\b0 \cf0 \

\f1\b \cf6   market_price_cny numeric,\\
\f0\b0 \cf0 \

\f1\b \cf6   savings_cny numeric,\\
\f0\b0 \cf0 \

\f1\b \cf6   has_member_discount boolean NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   commission_cny numeric NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   commission_note text,\\
\f0\b0 \cf0 \

\f1\b \cf6   purchase_url text,\\
\f0\b0 \cf0 \

\f1\b \cf6   coupon_code text,\\
\f0\b0 \cf0 \

\f1\b \cf6   compliance_notes text,\\
\f0\b0 \cf0 \

\f1\b \cf6   evidence_links jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   editorial_status editorial_status_enum NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   meta_json jsonb NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   created_at timestamptz NOT NULL,\\
\f0\b0 \cf0 \

\f1\b \cf6   updated_at timestamptz NOT NULL\\
\f0\b0 \cf0 \

\f1\b \cf6 );\\
\f0\b0 \cf0 \

\f1\b \cf6 "
\f0\b0 \cf0 \\\
\\pard\\tx720\\tx1440\\tx2160\\tx2880\\tx3600\\tx4320\\tx5040\\tx5760\\tx6480\\tx7200\\tx7920\\tx8640\\pardirnatural\\partightenfactor0\
\\cf0 \\\
\\\
\pard\pardeftab720\partightenfactor0
\cf2 -- ========== A3. CONSTRAINTS ==========\\\cf0 \
\\\
\\pard\\tx720\\tx1440\\tx2160\\tx2880\\tx3600\\tx4320\\tx5040\\tx5760\\tx6480\\tx7200\\tx7920\\tx8640\\pardirnatural\\partightenfactor0\
\\cf0 
\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  biomarker_catalog_biomarker_code_key 
\f1\b \cf3 ON
\f0\b0 \cf0  public.biomarker_catalog 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (biomarker_code)\\\
\pard\pardeftab720\partightenfactor0

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  biomarker_catalog_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.biomarker_catalog 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  biomarker_observations_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.biomarker_observations 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  idx_obs_data_source 
\f1\b \cf3 ON
\f0\b0 \cf0  public.biomarker_observations 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (data_source_id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  idx_obs_user_biomarker_measured_at 
\f1\b \cf3 ON
\f0\b0 \cf0  public.biomarker_observations 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (user_id, biomarker_code, measured_at 
\f1\b \cf3 DESC
\f0\b0 \cf0 )\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  idx_obs_user_measured_at 
\f1\b \cf3 ON
\f0\b0 \cf0  public.biomarker_observations 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (user_id, measured_at 
\f1\b \cf3 DESC
\f0\b0 \cf0 )\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  calculation_rules_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.calculation_rules 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  calculation_rules_rule_code_key 
\f1\b \cf3 ON
\f0\b0 \cf0  public.calculation_rules 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (rule_code)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  chat_messages_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.chat_messages 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  idx_chat_messages_session_time 
\f1\b \cf3 ON
\f0\b0 \cf0  public.chat_messages 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (session_id, created_at)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  chat_sessions_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.chat_sessions 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  idx_chat_sessions_user_time 
\f1\b \cf3 ON
\f0\b0 \cf0  public.chat_sessions 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (user_id, started_at 
\f1\b \cf3 DESC
\f0\b0 \cf0 )\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  data_sources_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.data_sources 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  idx_product_system_map_system 
\f1\b \cf3 ON
\f0\b0 \cf0  public.product_system_map 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (system_code)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  product_system_map_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.product_system_map 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  uq_product_system_unique 
\f1\b \cf3 ON
\f0\b0 \cf0  public.product_system_map 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (product_service_id, system_code)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  idx_products_primary_system 
\f1\b \cf3 ON
\f0\b0 \cf0  public.products_services 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (applicable_system_code)\\\

\f1\b \cf3 CREATE
\f0\b0 \cf0  
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  
\f1\b \cf3 INDEX
\f0\b0 \cf0  products_services_pkey 
\f1\b \cf3 ON
\f0\b0 \cf0  public.products_services 
\f1\b \cf3 USING
\f0\b0 \cf0  btree (id)\\\
\\pard\\tx720\\tx1440\\tx2160\\tx2880\\tx3600\\tx4320\\tx5040\\tx5760\\tx6480\\tx7200\\tx7920\\tx8640\\pardirnatural\\partightenfactor0\
\\cf0 \\\
\\\
\pard\pardeftab720\partightenfactor0
\cf2 -- ========== A4. INDEXES ==========\\\cf0 \
\\\
\\pard\\tx720\\tx1440\\tx2160\\tx2880\\tx3600\\tx4320\\tx5040\\tx5760\\tx6480\\tx7200\\tx7920\\tx8640\\pardirnatural\\partightenfactor0\
\\cf0 data_sources_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
biomarker_catalog_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
biomarker_catalog_biomarker_code_key	
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  (biomarker_code)\\\
chk_commission_zero	
\f1\b \cf3 CHECK
\f0\b0 \cf0  ((commission_cny = (\cf7 0\cf0 )::
\f1\b \cf3 numeric
\f0\b0 \cf0 ))\\\
products_services_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
product_system_map_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
uq_product_system_unique	
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  (product_service_id, system_code)\\\
product_system_map_product_service_id_fkey	
\f1\b \cf3 FOREIGN
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (product_service_id) 
\f1\b \cf3 REFERENCES
\f0\b0 \cf0  products_services(id) 
\f1\b \cf3 ON
\f0\b0 \cf0  
\f1\b \cf3 DELETE
\f0\b0 \cf0  
\f1\b \cf3 CASCADE
\f0\b0 \cf0 \\\
calculation_rules_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
calculation_rules_rule_code_key	
\f1\b \cf3 UNIQUE
\f0\b0 \cf0  (rule_code)\\\
chk_bio_sample_requires_sample_type	
\f1\b \cf3 CHECK
\f0\b0 \cf0  (((observation_medium <> \cf4 'bio_sample'\cf0 ::observation_medium_enum) 
\f1\b \cf3 OR
\f0\b0 \cf0  (sample_type 
\f1\b \cf3 IS
\f0\b0 \cf0  
\f1\b \cf3 NOT
\f0\b0 \cf0  
\f1\b \cf3 NULL
\f0\b0 \cf0 )))\\\
biomarker_observations_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
biomarker_observations_biomarker_code_fkey	
\f1\b \cf3 FOREIGN
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (biomarker_code) 
\f1\b \cf3 REFERENCES
\f0\b0 \cf0  biomarker_catalog(biomarker_code) 
\f1\b \cf3 ON
\f0\b0 \cf0  
\f1\b \cf3 UPDATE
\f0\b0 \cf0  
\f1\b \cf3 CASCADE
\f0\b0 \cf0 \\\
biomarker_observations_data_source_id_fkey	
\f1\b \cf3 FOREIGN
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (data_source_id) 
\f1\b \cf3 REFERENCES
\f0\b0 \cf0  data_sources(id) 
\f1\b \cf3 ON
\f0\b0 \cf0  
\f1\b \cf3 DELETE
\f0\b0 \cf0  
\f1\b \cf3 SET
\f0\b0 \cf0  
\f1\b \cf3 NULL
\f0\b0 \cf0 \\\
chat_sessions_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
chat_messages_pkey	
\f1\b \cf3 PRIMARY
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (id)\\\
chat_messages_session_id_fkey	
\f1\b \cf3 FOREIGN
\f0\b0 \cf0  
\f1\b \cf3 KEY
\f0\b0 \cf0  (session_id) 
\f1\b \cf3 REFERENCES
\f0\b0 \cf0  chat_sessions(id) 
\f1\b \cf3 ON
\f0\b0 \cf0  
\f1\b \cf3 DELETE
\f0\b0 \cf0  
\f1\b \cf3 CASCADE
\f0\b0 \cf0 \\\
\}}