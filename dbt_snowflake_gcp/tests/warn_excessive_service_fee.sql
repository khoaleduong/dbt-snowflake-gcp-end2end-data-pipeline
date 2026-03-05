{{ config(severity='warn') }}

SELECT
    booking_id,
    total_amount,
    service_fee
FROM {{ ref('silver_bookings') }}
WHERE service_fee > (total_amount * 0.5)