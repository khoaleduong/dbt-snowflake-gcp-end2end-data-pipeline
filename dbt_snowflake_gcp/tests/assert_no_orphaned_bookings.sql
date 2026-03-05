SELECT
    b.listing_id
FROM {{ ref('silver_bookings') }} b
LEFT JOIN {{ ref('silver_listings') }} l 
    ON b.listing_id = l.listing_id
WHERE l.listing_id IS NULL