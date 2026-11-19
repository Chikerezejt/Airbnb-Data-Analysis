--Question 1: Which cities have the most listings?--

SELECT
    city,
    COUNT(listing_id) AS total_listings
FROM airbnb_listings
GROUP BY city
ORDER BY total_listings DESC;


--Question 2: How are listings distributed across room types?--

SELECT
    room_type,
    COUNT(listing_id) AS total_listings,
    ROUND(
        COUNT(listing_id) * 100.0 /
        (SELECT COUNT(*) FROM airbnb_listings), 2
    ) AS percentage
FROM airbnb_listings
GROUP BY room_type
ORDER BY total_listings DESC;


--Question 3: Which property types are most common?--

SELECT
	property_type,
	COUNT(listing_id) AS total_listings
FROM
	airbnb_listings
GROUP BY property_type
ORDER BY total_listings DESC;

--Question 4: How do prices vary across cities?--

SELECT
    city,
    COUNT(listing_id) AS total_listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(MIN(price), 2) AS minimum_price,
    ROUND(MAX(price), 2) AS maximum_price,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY price)::numeric, 2
    ) AS median_price
FROM airbnb_listings
WHERE price IS NOT NULL
GROUP BY city
ORDER BY average_price DESC;

--converting each country's currency to USD for a uniform price analysis:--
WITH converted_prices AS (
    SELECT
        listing_id,
        city,
        price AS original_price,

        CASE
            WHEN city = 'Cape Town' THEN 'ZAR'
            WHEN city = 'Bangkok' THEN 'THB'
            WHEN city = 'Mexico City' THEN 'MXN'
            WHEN city = 'Hong Kong' THEN 'HKD'
            WHEN city = 'Rio de Janeiro' THEN 'BRL'
            WHEN city = 'Istanbul' THEN 'TRY'
            WHEN city = 'Sydney' THEN 'AUD'
            WHEN city = 'New York' THEN 'USD'
            WHEN city IN ('Paris', 'Rome') THEN 'EUR'
        END AS currency,

        CASE
            WHEN city = 'Cape Town' THEN 0.05906
            WHEN city = 'Bangkok' THEN 0.02955
            WHEN city = 'Mexico City' THEN 0.05416
            WHEN city = 'Hong Kong' THEN 0.12745
            WHEN city = 'Rio de Janeiro' THEN 0.17298
            WHEN city = 'Istanbul' THEN 0.01984
            WHEN city = 'Sydney' THEN 0.67319
            WHEN city = 'New York' THEN 1.00000
            WHEN city IN ('Paris', 'Rome') THEN 1.09890
        END AS usd_rate

    FROM airbnb_listings
    WHERE price IS NOT NULL
)

SELECT
    listing_id,
    city,
    currency,
    original_price,
    usd_rate,
    ROUND(
        (original_price::numeric * usd_rate::numeric), 2
    ) AS price_usd

FROM converted_prices
ORDER BY city, price_usd DESC;

--Analysing the actual price variation across cities--
WITH converted_prices AS (
    SELECT
        city,
        listing_id,
        price::numeric *

        CASE
            WHEN city = 'Cape Town' THEN 0.05906
            WHEN city = 'Bangkok' THEN 0.02955
            WHEN city = 'Mexico City' THEN 0.05416
            WHEN city = 'Hong Kong' THEN 0.12745
            WHEN city = 'Rio de Janeiro' THEN 0.17298
            WHEN city = 'Istanbul' THEN 0.01984
            WHEN city = 'Sydney' THEN 0.67319
            WHEN city = 'New York' THEN 1.00000
            WHEN city IN ('Paris', 'Rome') THEN 1.09890
        END AS price_usd

    FROM airbnb_listings
    WHERE price IS NOT NULL
)

SELECT
    city,
    COUNT(listing_id) AS total_listings,

    ROUND(AVG(price_usd), 2) AS average_price_usd,

    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY price_usd)::numeric, 2
    ) AS median_price_usd,

    ROUND(MIN(price_usd), 2) AS minimum_price_usd,

    ROUND(MAX(price_usd), 2) AS maximum_price_usd

FROM converted_prices
GROUP BY city
ORDER BY average_price_usd DESC;

--Zero pricing investigation--

SELECT
    city,
    COUNT(*) AS zero_price_listings
FROM airbnb_listings
WHERE price = 0
GROUP BY city
ORDER BY zero_price_listings DESC;


--Question 5: Which neighbourhoods have the most listings?--

SELECT
	city,
	neighbourhood,
	COUNT(listing_id) AS total_listings
FROM 
	airbnb_listings
GROUP BY city, neighbourhood
ORDER BY total_listings DESC;


--Question 6: Which listings have the highest review scores?--

SELECT
    l.listing_id,
    l.name,
    l.city,
    l.neighbourhood,
    l.review_scores_rating,
    COUNT(r.review_id) AS total_reviews
FROM airbnb_listings l
LEFT JOIN airbnb_reviews r
    ON l.listing_id = r.listing_id
WHERE l.review_scores_rating IS NOT NULL
GROUP BY
    l.listing_id,
    l.name,
    l.city,
    l.neighbourhood,
    l.review_scores_rating
ORDER BY
    l.review_scores_rating DESC,
    total_reviews DESC
LIMIT 20;


--Question 7: How many reviews does each listing have?--

SELECT
    l.listing_id,
    l.name,
    l.city,
    COUNT(r.review_id) AS total_reviews
FROM airbnb_listings l
LEFT JOIN airbnb_reviews r
    ON l.listing_id = r.listing_id
GROUP BY
    l.listing_id,
    l.name,
    l.city
ORDER BY total_reviews DESC
LIMIT 20;


--Question 8: How does review activity change over time?--

SELECT
	DATE_TRUNC('month', date)::date AS review_month,
	COUNT(review_id) AS total_reviews
FROM airbnb_reviews
GROUP BY review_month
ORDER BY review_month;

--Question 9: How do host response and acceptance rates vary?--

--The distribution of host response times:--
SELECT
    host_response_time,
    COUNT(host_id) AS total_hosts
FROM airbnb_listings
GROUP BY host_response_time
ORDER BY total_hosts DESC;

--Average response rate and average acceptance rate by city:--
SELECT
    city,
    ROUND(
        AVG(
            NULLIF(
                REPLACE(host_response_rate, '%', ''),
                ''
            )::numeric
        ), 2
    ) AS avg_response_rate,

    ROUND(
        AVG(
            NULLIF(
                REPLACE(host_acceptance_rate, '%', ''),
                ''
            )::numeric
        ), 2
    ) AS avg_acceptance_rate

FROM airbnb_listings
GROUP BY city
ORDER BY avg_response_rate DESC;


--Question 10: Which characteristics are common among higher-priced listings?--

--Room_type--
SELECT
    city,
    room_type,
    COUNT(listing_id) AS total_listings,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY price)::numeric, 2
    ) AS median_price
FROM airbnb_listings
WHERE price IS NOT NULL
GROUP BY city, room_type
ORDER BY city, average_price DESC;

--Property_type--

SELECT
    city,
    property_type,
    COUNT(listing_id) AS total_listings,
    ROUND(AVG(price), 2) AS average_price
FROM airbnb_listings
WHERE price IS NOT NULL
GROUP BY city, property_type
HAVING COUNT(listing_id) >= 5
ORDER BY total_listings, average_price DESC;

--Accommodation capacity to price--

SELECT
	city,
	accommodates,
	COUNT(listing_id) AS total_listings,
	ROUND(AVG(price), 2) AS average_price
FROM airbnb_listings
WHERE price IS NOT NULL
GROUP BY city, accommodates
ORDER BY city, average_price DESC;
