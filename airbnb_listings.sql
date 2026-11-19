CREATE TABLE airbnb_listings (
    listing_id BIGINT,
    name TEXT,
    host_id BIGINT,
    host_since DATE,
    host_location TEXT,
    host_response_time TEXT,
    host_response_rate TEXT,
    host_acceptance_rate TEXT,
    host_is_superhost BOOLEAN,
    host_total_listings_count NUMERIC,
    host_has_profile_pic BOOLEAN,
    host_identity_verified BOOLEAN,
    neighbourhood TEXT,
    district TEXT,
    city TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    property_type TEXT,
    room_type TEXT,
    accommodates INT,
    bedrooms NUMERIC,
    amenities TEXT,
    price NUMERIC,
    minimum_nights INT,
    maximum_nights INT,
    review_scores_rating NUMERIC,
    review_scores_accuracy NUMERIC,
    review_scores_cleanliness NUMERIC,
    review_scores_checkin NUMERIC,
    review_scores_communication NUMERIC,
    review_scores_location NUMERIC,
    review_scores_value NUMERIC,
    instant_bookable BOOLEAN
);

SELECT * FROM airbnb_listings;

--If there are duplicates:--
SELECT
    listing_id,
    COUNT(*) AS duplicate_count
FROM airbnb_listings
GROUP BY listing_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


--looking for NULL cells--
--1.--
SELECT *
FROM airbnb_listings
WHERE review_scores_rating IS NULL
   OR review_scores_accuracy IS NULL
   OR review_scores_cleanliness IS NULL
   OR review_scores_checkin IS NULL
   OR review_scores_communication IS NULL
   OR review_scores_location IS NULL
   OR review_scores_value IS NULL;

--Number of NULL cells--
SELECT COUNT(*) AS rows_with_missing_values
FROM airbnb_listings
WHERE review_scores_rating IS NULL
   OR review_scores_accuracy IS NULL
   OR review_scores_cleanliness IS NULL
   OR review_scores_checkin IS NULL
   OR review_scores_communication IS NULL
   OR review_scores_location IS NULL
   OR review_scores_value IS NULL;

--Check for missing cells in all columns--
SELECT
    COUNT(*) FILTER (WHERE review_scores_rating IS NULL) AS missing_rating,
	COUNT(*) FILTER (WHERE review_scores_accuracy IS NULL) AS missing_accuracy,
    COUNT(*) FILTER (WHERE review_scores_cleanliness IS NULL) AS missing_cleanliness,
    COUNT(*) FILTER (WHERE review_scores_checkin IS NULL) AS missing_checkin,
    COUNT(*) FILTER (WHERE review_scores_communication IS NULL) AS missing_communication,
    COUNT(*) FILTER (WHERE review_scores_location IS NULL) AS missing_location,
    COUNT(*) FILTER (WHERE review_scores_value IS NULL) AS missing_value
FROM airbnb_listings;


--How many of these rows are missing all seven scores, and how many are missing just one or two --
SELECT
    COUNT(*) AS total_rows,

    COUNT(*) FILTER (
        WHERE review_scores_rating IS NULL
		AND review_scores_accuracy IS NULL
        AND review_scores_cleanliness IS NULL
        AND review_scores_checkin IS NULL
        AND review_scores_communication IS NULL
        AND review_scores_location IS NULL
        AND review_scores_value IS NULL
    ) AS all_seven_missing,

    COUNT(*) FILTER (
        WHERE review_scores_rating IS NOT NULL
        AND review_scores_accuracy IS NOT NULL
		AND review_scores_cleanliness IS NOT NULL
        AND review_scores_checkin IS NOT NULL
        AND review_scores_communication IS NOT NULL
        AND review_scores_location IS NOT NULL
        AND review_scores_value IS NOT NULL
    ) AS all_seven_available

FROM airbnb_listings;
