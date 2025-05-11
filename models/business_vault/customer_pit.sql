{{ config(materialized='pit_incremental') }}

{%- set yaml_metadata -%}
source_model: hub_customer
src_pk: customer_pk
as_of_dates_table: as_of_date
satellites:
  sat_customer:
    pk:
      pk: customer_pk
    ldts:
      ldts: effective_from
  sat_customer_crm:
    pk:
      pk: customer_pk
    ldts:
      ldts: effective_from
src_ldts: effective_from
stage_tables_ldts:
  stg_customers: effective_from
  stg_customers_crm: effective_from
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set src_pk = metadata_dict['src_pk'] %}
{% set as_of_dates_table = metadata_dict['as_of_dates_table'] %}
{% set satellites = metadata_dict['satellites'] %}
{% set src_ldts = metadata_dict['src_ldts'] %}
{% set stage_tables_ldts = metadata_dict['stage_tables_ldts'] %}

{{ automate_dv.pit(source_model=source_model, 
                   src_pk=src_pk,
                   as_of_dates_table=as_of_dates_table,
                   satellites=satellites,
                   src_ldts=src_ldts,
                   stage_tables_ldts=stage_tables_ldts) }}