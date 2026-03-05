{% set nights_booked = 1 %}

select * from {{ ref('bronze_bookings') }}
where NIGHTS_BOOKED > {{ nights_booked }}