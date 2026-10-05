{# Trims a text column and collapses repeated spaces:  '   Pablo    Perez ' -> 'Pablo Perez' #}
{% macro clean_text(column_name) %}
    trim(regexp_replace({{ column_name }}, ' +', ' '))
{% endmacro %}
