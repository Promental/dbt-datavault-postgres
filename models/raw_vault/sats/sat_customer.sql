{{
    config(
        enabled=True,
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key=['customer_pk', 'effective_from']
    )
}}

{%- set source_model = 'stg_customers' -%}
{%- set src_pk = "CUSTOMER_PK" -%}
{%- set src_hashdiff = "CUSTOMER_HASHDIFF" -%}
{%- set src_payload = ["first_name", "last_name", "email"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "EFFECTIVE_FROM" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, 
                   src_hashdiff=src_hashdiff,
                   src_payload=src_payload,
                   src_eff=src_eff,
                   src_ldts=src_ldts, 
                   src_source=src_source,
                   source_model=source_model) }}
