# Airbnb Data Analysis Documentation



### Airbnb Data Analysis



###### Project Overview

This project explores Airbnb listing and review data to identify patterns in listing distribution, pricing, customer reviews, host responsiveness, and other factors that may support business decisions.



The analysis uses SQL to investigate the datasets and answer business-focused questions.



###### Datasets

The project uses two datasets:



* **Airbnb Listings:** Information about listings, hosts, locations, property types, prices, and review scores.
* **Airbnb Reviews:** Customer review records associated with Airbnb listings.



Data dictionaries are included to explain the dataset fields.



###### Tools Used

* PostgreSQL / SQL
* Excel
* Data exploration and analysis



###### Business Questions

The analysis investigates questions such as:



1\. Which cities have the highest number of Airbnb listings?

2\. Which room types are most common?

3\. Which property types are most frequently listed?

4\. How do average and median listing prices differ across cities?

5\. Which neighbourhoods have the most listings?

6\. Which listings have the highest review scores?

7\. How many reviews does each listing have?

8\. How does review activity change over time?

9\. How do host response and acceptance rates vary?



###### Repository Contents

* `airbnb\_listings.sql` – SQL queries for the listings dataset.
* `airbnb\_reviews.sql` – SQL queries for the reviews dataset.
* `Business\_Analysis\_Questions.sql` – Business questions explored in the project.
* `Listings\_data\_dictionary.csv` – Listings field descriptions.
* `Reviews\_data\_dictionary.csv` – Reviews field descriptions.
* `README.md` – Project documentation.



The large CSV datasets are hosted separately on Kaggle.



###### Key Findings

The exploratory analysis identified differences in listing volumes, room-type distribution, pricing patterns, review activity, and host response times across cities.



Further interpretation and recommendations are documented in the project analysis.



###### Project Links

**GitHub Repository:** https://github.com/Chikerezejt/Airbnb-Data-Analysis

**Kaggle Dataset:** https://www.kaggle.com/datasets/timothykerejohn/airbnb-data-analysis



##### Note:

This project is intended for learning, exploratory data analysis, and portfolio demonstration. Findings should be interpreted in light of data quality limitations, missing values, and possible outliers.



### 

### Data Cleaning

* The name of the two datasets in use for analysis are airbnb\_listings and airbnb\_reviews.
* airbnb\_listings has 31 columns and 279,712 rows.
* airbnb\_reviews has 4 columns and 5,373,143 rows.
* Their datatypes comprise of bigint, text, Boolean, date, numeric, and integers.
* There are 160 duplicated review\_ids in the airbnb\_reviews table. Further examination confirmed that the duplicated records were exact duplicates, containing identical values across the relevant columns. Completely identical duplicate records were removed using PostgreSQL's ctid system column, retaining one instance of each review. 
* In the airbnb\_listings table, host\_response\_time, host\_response\_rate, host\_acceptance\_rate, and district columns all have empty cells. This could be attributed to the customers not filling in those respective fields, because they weren’t made compulsory on the review form, they filled. A proper data validation should be implemented in the review forms.
* Columns review\_scores\_rating, review\_socres\_accuracy, review\_scores\_cleanliness, review\_scores\_checkin, review\_scores\_communication, review\_scores\_location, and review\_scores\_value have 91,881 rows has missing cell values. The missing values may indicate that certain listings have not received guest reviews or have incomplete review-score records. Deleting these rows could result in the loss of otherwise useful listing information and introduce bias into subsequent analyses. The 91,881 affected rows were preserved to maintain the dataset's completeness and minimise unnecessary data loss.
* The Airbnb dataset contains listings across ten international cities, with prices denominated in their respective local currencies. I standardised listing prices to United States Dollars (USD) using city-based currency mappings and European Central Bank reference exchange rates dated 17 November 2026, then applied the relevant USD exchange rate to each listing's original price to calculate its equivalent USD value. Currency standardisation provides a common unit of measurement for comparing listing prices across different cities and reduces the risk of misleading comparisons arising from differences in currency denominations. The original price values were preserved. Currency conversion was performed as a derived calculation for analytical purposes.

&#x09;

## Airbnb Exploratory Data Analysis (EDA): Business Interpretation and Insights

#### 

#### 1\. Which cities have the highest number of Airbnb listings?



###### What the data shows

Paris has the highest number of Airbnb listings, with 64,690 listings across the ten cities examined.

For context, the dataset contains 279,712 listings in total.

Paris therefore accounts for approximately 23.1% of all listings in the dataset.



###### What it means

Paris has the largest concentration of Airbnb accommodation options among the ten cities analysed.

This suggests that Paris has a particularly established Airbnb marketplace, with a substantial supply of accommodation available to travellers.

However, having the most listings does not automatically mean that Paris generates the highest revenue or attracts the most bookings.

The number of listings measures supply, not necessarily demand or profitability.



###### Business insight

* **Market expansion:** Airbnb could use this information to identify cities with comparatively smaller listing inventories as potential markets for host acquisition.
* **Competitive positioning:** Hosts operating in Paris may face greater competition because of the concentration of available properties.
* **Marketing strategy:** Airbnb could investigate whether its marketing and customer acquisition efforts are proportionate to the size of each city's listing inventory.

#### 

#### 2\. Which property types are most frequently listed?

###### 

###### What the data shows



Room type	Number of listings	Percentage

Entire place	182,005			65.07%

Private room	86,988			31.10%

Hotel room	5,857			2.09%

Shared room	4,862			1.74%

Total		279,712			100%



Entire-place accommodation dominates the dataset, accounting for approximately two-thirds of all listings.

Private rooms represent another 31.10%, while hotel and shared rooms collectively account for just 3.83%.



###### What it means

The distribution suggests that Airbnb's accommodation supply in these ten cities is predominantly made up of properties offering guests exclusive use of an entire accommodation space.

This indicates a strong presence of accommodation options catering to travellers who prefer privacy, independence and exclusive access to their accommodation.

Private rooms also represent a significant part of the marketplace, suggesting that shared-property hosting remains an important accommodation model.

###### 

###### Business insight

* **Customer segmentation:** Airbnb could develop marketing campaigns targeting travellers who prefer entire accommodation spaces, while maintaining offerings for budget-conscious travellers who prefer private rooms.
* **Host acquisition:** The relatively small proportion of shared and hotel rooms could present opportunities to attract more hosts operating these accommodation types.
* **Product development:** Airbnb could investigate whether customers booking entire places have different expectations, booking behaviours and spending patterns from those booking private rooms.



#### 3\. Which property types are most common?



###### What the data shows

Entire apartments are the most common property type, with 138,989 listings.

This represents approximately 49.7% of all listings in the dataset.



###### What it means

Almost half of the Airbnb listings analysed are classified as entire apartments.

This reinforces the finding from Question 2 that entire-property accommodation represents a substantial proportion of Airbnb's accommodation supply.

It also suggests that apartments are an important component of Airbnb's marketplace across the ten cities.

However, the fact that apartments are the most common property type does not establish that they are the most profitable or most frequently booked.



###### Business insight

* **Host acquisition:** Airbnb could prioritise apartment owners when developing host acquisition strategies, given the significant representation of apartments in its existing inventory.
* **Customer experience:** Airbnb could investigate which apartment features are most associated with positive guest reviews.
* **Market positioning:** The company could use this information to understand the type of accommodation that dominates its marketplace and align its marketing strategies accordingly.



#### 4\. How do average and median listing prices differ across cities?

&#x20;

###### What the data shows

I standardised listing prices across the ten cities into USD, making the comparison more meaningful.



The results are:

|**City		|Average price	|Median price**|
|---|---:|---:|

| Sydney | $149.46 | $80.78 |

| New York | $142.84 | $99.00 |

| Cape Town | $142.05 | $63.14 |

| Rio de Janeiro | $128.45 | $48.43 |

| Paris	| $124.28 | $87.91 |

| Rome | $115.50 | $71.43 |

| Hong Kong | $95.10 | $49.20 |

| Mexico City | $62.24 | $35.80 |

| Bangkok | $61.41 | $32.51 |

| Istanbul | $10.57 | $5.00 |



###### Key findings:

* Sydney has the highest average listing price at $149.46.
* New York follows at $142.84.
* Cape Town comes third at $142.05.
* Istanbul has the lowest average listing price at $10.57.
* Rio de Janeiro, Cape Town and Sydney have particularly large differences between their average and median prices.

###### 

###### What it means

There are two important things happening in this analysis.



**First: Listing prices vary considerably across cities.**

Sydney, New York and Cape Town have the highest average listing prices, while Istanbul, Bangkok and Mexico City have the lowest.

This indicates that accommodation pricing differs considerably across the ten markets.

However, these differences alone do not establish why prices vary. Factors such as location, property size, accommodation quality and local market conditions could contribute.



**Second: The average and median prices reveal potential price concentration.**

The average price is influenced by every listing's price, including unusually expensive properties.

The median represents the middle listing price when all listings are arranged from lowest to highest.



For example:

* Sydney: Average = $149.46; Median = $80.78.
* Cape Town: Average = $142.05; Median = $63.14.
* Rio de Janeiro: Average = $128.45; Median = $48.43.



The substantial differences suggest positively skewed price distributions.

In other words, relatively expensive listings may be pulling the average upwards.



###### Business insight

* **Pricing strategy:** Hosts should not rely exclusively on city-wide average prices when determining their listing prices. Median prices may provide a more representative starting point.
* **Market segmentation:** Airbnb could segment listings by price range to understand the distribution of budget, mid-range and premium accommodation.
* **Revenue opportunities:** Cities with higher average prices may present opportunities for premium accommodation offerings, although actual revenue depends on booking frequency and occupancy.
* **Data quality:** Zero-priced listings and unusually expensive properties should be investigated before using the results to inform pricing decisions.



#### 5\. Which neighbourhoods have the most listings?



###### What the data shows

Centro Storico in Rome has the highest number of listings, with 14,874 Airbnb listings.

###### 

###### What it means

Centro Storico has the largest concentration of Airbnb accommodation among the neighbourhoods examined.

This suggests that the neighbourhood is an important accommodation market within Rome.

A high concentration of listings could reflect its popularity among travellers, the availability of properties suitable for short-term rentals, or the commercial attractiveness of the location to hosts.



###### Business insight

* **Host competition:** The large number of listings could indicate a highly competitive environment for hosts operating in Centro Storico.
* **Market opportunities:** Airbnb could investigate neighbourhoods with fewer listings to identify potential opportunities for host acquisition.
* **Marketing:** The concentration of listings could help Airbnb identify locations where targeted traveller marketing campaigns may be worthwhile.
* **Pricing:** Hosts in highly concentrated neighbourhoods may need to pay closer attention to competing accommodation prices and guest reviews.



#### 6\. Which listings have the highest review scores?



###### What the data shows

My analysis identifies One cozy private BR close to the mecca of shopping in Upper East Side neighbourhood in New York as the highest-rated result, with a review score of 100 and 329 reviews.



###### What it means

The result suggests that the listing or group of listings represented by this record has an excellent review score and a considerable number of reviews.

The 329 reviews provide more context than a perfect rating alone.

For example, a property with a perfect score based on one review would provide less evidence of consistently positive guest experiences than a property with a perfect score based on 329 reviews.



###### Business insight

* **Customer experience:** Listings with consistently high review scores could provide useful examples of practices associated with positive guest experiences.
* **Host performance:** Airbnb could identify high-performing hosts and investigate the service characteristics contributing to their ratings.
* **Customer confidence:** Strong review scores and substantial review histories could help customers make more informed accommodation decisions.
* **Operational improvement:** Airbnb could use findings from highly rated listings to identify opportunities for improving guest experiences elsewhere.



#### 7\. How many reviews does each listing have?

&#x20;

###### What the data shows

The analysis identifies the following listings with the highest review counts:

### Top 10 Listings by Number of Reviews

| Listing Name | City | Number of Reviews |
|---|---|---:|
| Sweet & cosy room next to Canal Saint Martin | Paris | 891 |
| Cheung Chau Island listing | Hong Kong | 828 |
| A Journey Into The Heart Of Paris | Paris | 796 |
| Bed in 8 Bed Dorm | Paris | 762 |
| B&B Rione Monti | Rome | 754 |
| Enjoy great views of the City with FREE PARKING! | New York | 753 |
| Caroline's cheap rate near Termini | Rome | 717 |
| Bed in a 4 Bed Mixed Dormitory | Paris | 710 |
| Colonna's Home in the heart of Rome | Rome | 702 |
| Brand new Modern flat Central Paris Boutique Hotel | Paris | 700 |

The table shows that Paris and Rome feature prominently among the listings with the highest review counts.



###### What it means

The findings suggest that some Airbnb listings have accumulated considerably more guest reviews than others.

* A high review count could indicate several things:
* The property has been available on Airbnb for a considerable period.
* The listing has attracted a relatively high volume of guest stays.
* Guests have been willing to leave reviews after their stays.
* The property may have maintained sufficient service quality to encourage continued customer engagement.

However, review volume is not necessarily equivalent to booking volume.

Not every guest leaves a review, and older listings have had more time to accumulate reviews.

Therefore, the number of reviews should not be treated as a direct measure of current demand or occupancy.



###### Business insight

* **Performance benchmarking:** Airbnb could study highly reviewed listings to identify characteristics associated with sustained customer engagement.
* **Customer trust:** Listings with substantial review histories may provide prospective guests with more information when making accommodation decisions.
* **Host improvement:** Hosts with relatively low review volumes could be encouraged to improve guest engagement and post-stay review requests.
* **Market analysis:** The concentration of highly reviewed listings in Paris and Rome could justify further investigation into customer engagement across these cities.



#### 8\. How does review activity change over time?

&#x20;

###### What the data shows

The visible trend suggests:

* Review activity was relatively low during the earlier period.
* Review volume gradually increased over time.
* Growth became considerably stronger during the later period.
* Review activity eventually reached a major peak.
* There were subsequent sharp declines, followed by partial recoveries.

The chart therefore indicates a substantial increase in review activity over much of the period examined, although activity becomes irregular towards the end.



###### What it means

The general upward trend suggests that Airbnb's listings experienced increasing review activity over the period covered by the dataset.

This could reflect increasing customer engagement, greater platform usage or an expansion in the number of accommodation listings and completed stays.

However, there is an important distinction:

**An increase in reviews does not necessarily mean an equivalent increase in bookings.**



Reviews are generated after guests complete their stays and submit feedback. Not every guest submits a review.

Also, the sharp declines towards the end of the chart could be caused by incomplete data for the most recent dates rather than an actual collapse in customer activity.



###### Business insight

**Customer engagement:** Airbnb could use review trends to monitor changes in guest engagement over time.

**Demand monitoring:** Consistent increases in review activity could provide an additional indicator of marketplace activity.

**Operational planning:** Periods of increased review activity could help Airbnb anticipate greater demand for customer support and host services.

**Performance monitoring:** Sudden declines in review activity should trigger further investigation to establish whether they reflect genuine changes in customer behaviour or incomplete data.



#### 9\. How do host response and acceptance rates vary?

&#x20;

###### What the data shows

The analysis examines two areas:

1. The distribution of host response times.
2. Average host response and acceptance rates across cities.



**A. Distribution of Host Response Times
**

| Host Response Time | Number of Hosts/Listings | Percentage |
|---|---:|---:|
| Missing (NULL) | 128,782 | 46.0% |
| Within an hour | 83,464 | 29.8% |
| Within a few hours | 28,891 | 10.3% |
| Within a day | 23,425 | 8.4% |
| A few days or more | 15,150 | 5.4% |


The most important observation is that 46% of the records have missing host response-time information.

Among the records with a reported response time, approximately 55.7% fall within the one-hour category.



**B. Average Host Response and Acceptance Rates by City**

| City | Average Response Rate | Average Acceptance Rate |
|---|---:|---:|
| Cape Town | 91% | 80% |
| Mexico City | 89% | 89% |
| New York | 89% | 80% |
| Sydney | 88% | 79% |
| Rome | 87% | 90% |
| Paris | 86% | 81% |
| Bangkok | 85% | 91% |
| Istanbul | 83% | 85% |
| Hong Kong | 83% | 80% |
| Rio de Janeiro | 83% | 76% |



###### What it means

There are several important observations here.



**First: A considerable proportion of host response-time information is missing.**

With 46% of records having NULL response-time values, it is difficult to make a definitive assessment of host responsiveness across the entire dataset.

This is an important data-quality limitation.

The missing values should not automatically be interpreted as hosts failing to respond. They simply indicate that response-time information is unavailable.



**Second: Some cities demonstrate stronger response performance than others.**

Cape Town has the highest average host response rate at 91%.

Rio de Janeiro and Hong Kong have the lowest, at 83%.

This suggests differences in the responsiveness of hosts across the cities examined.



**Third: Response rates and acceptance rates do not necessarily move together.**

Consider Cape Town and Bangkok.

* Cape Town has a 91% response rate but an 80% acceptance rate.
* Bangkok has an 85% response rate but a 91% acceptance rate.

This means that responding to customer enquiries and accepting booking requests are two different aspects of host performance.



A host may respond quickly but still decline a booking request.



###### Business insight

* **Host performance:** Airbnb could use response and acceptance rates to identify differences in host performance across its markets.
* **Customer experience:** Improving host responsiveness could help reduce uncertainty for prospective guests.
* **Booking conversion:** Airbnb could investigate whether higher acceptance rates are associated with better booking conversion rates.
* **Host support:** Cities with comparatively lower response rates could benefit from targeted host education and engagement initiatives.
* **Data quality:** Airbnb should investigate the high proportion of missing response-time records before using this metric for performance evaluations.





