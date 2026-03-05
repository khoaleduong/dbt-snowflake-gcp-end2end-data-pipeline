{% macro trimmer(col) %}
  UPPER(TRIM({{ col }}))
{% endmacro %}