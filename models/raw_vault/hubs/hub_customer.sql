{{
    config(enabled=True)
}}

{%- set source_model = "stg_customers" -%}
{%- set src_pk = "CUSTOMER_PK" -%}
{%- set src_nk = "email" -%}
{%- set src_ldts = "EFFECTIVE_FROM" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.hub(src_pk=src_pk, 
                   src_nk=src_nk,
                   src_ldts=src_ldts,
                   src_source=src_source,
                   source_model=source_model) }}
