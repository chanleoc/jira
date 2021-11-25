{% snapshot lc_worklogs_snapshot %}

{{
    config(
      target_database='KEBOOLA_4197',
      target_schema='WORKSPACE_7852031',
      unique_key='"id"',

      strategy='timestamp',
      updated_at='"_timestamp"',
    )
}}

select * from "worklogs"

{% endsnapshot %}