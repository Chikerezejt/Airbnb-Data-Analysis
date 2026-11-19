CREATE TABLE airbnb_reviews (
	listing_id BIGINT,
	review_id BIGINT,
	Date DATE,
	reviewer_id BIGINT
);

SELECT * FROM airbnb_reviews;

--If there are duplicates:--
SELECT
    review_id,
    COUNT(*) AS duplicate_count
FROM airbnb_reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

--investigate the duplicates:--
SELECT COUNT(*) AS total_duplicated_review_ids
FROM (
    SELECT review_id
    FROM airbnb_reviews
    GROUP BY review_id
    HAVING COUNT(*) > 1
) AS duplicates;
