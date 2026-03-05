{% set cols = ["NIGHTS_BOOKED", "BOOKING_ID", "BOOKING_AMOUNT"] %}
{% set prefix = "booking" %}

SELECT
{%- for col in cols %}
  {{ col }} AS {{ prefix }}_{{ col }}
  {%- if not loop.last %},{% endif %}
{%- endfor %}

FROM {{ ref('bronze_bookings') }}