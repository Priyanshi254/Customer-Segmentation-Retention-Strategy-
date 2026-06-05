CREATE DATABASE customer_retention_project;
USE customer_retention_project;

SHOW TABLES;
SELECT *
FROM cleaned_feature_engineered_dataset
LIMIT 5;

RENAME TABLE cleaned_feature_engineered_dataset
TO dataset;
DESC dataset;

ALTER TABLE dataset
CHANGE COLUMN `ï»¿customer_id`
customer_id INT;

-- ====================================
-- QUESTION 1
-- Customer Segment Distribution
-- ====================================

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM dataset),
    2) AS percentage_share
FROM dataset
GROUP BY customer_segment
ORDER BY total_customers DESC;


SELECT
    customer_segment,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty_score,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_purchase_amount,
    COUNT(*) AS total_customers
FROM dataset
GROUP BY customer_segment
ORDER BY avg_loyalty_score DESC;


SELECT
    customer_id,
    age,
    gender,
    location,
    category,
    purchase_amount_usd,
    previous_purchases,
    loyalty_score,
    promo_dependency_score,
    customer_segment
FROM dataset
WHERE loyalty_score >= 0.70
AND promo_dependency_score <= 0.30
ORDER BY loyalty_score DESC
LIMIT 20;


SELECT
    CASE
        WHEN loyalty_score >= 0.7
        THEN 'Highly Loyal'
        WHEN loyalty_score >= 0.4
        THEN 'Moderately Loyal'
        ELSE 'Low Loyalty'
    END AS loyalty_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending
FROM dataset
GROUP BY loyalty_group
ORDER BY avg_discount_dependency;


SELECT
    CASE
        WHEN purchase_amount_usd >= 75
        THEN 'High Value Customer'
        ELSE 'Low Value Customer'
    END AS customer_value_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty_score,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_promo_dependency,
    ROUND(AVG(purchase_frequency_score),2)
    AS avg_purchase_frequency,
    ROUND(AVG(review_rating),2)
    AS avg_review_rating
FROM dataset
GROUP BY customer_value_group;

-- =======================
-- Question 2
-- ========================

SELECT
    CASE
        WHEN purchase_amount_usd >= 75
        THEN 'High Value Customer'
        ELSE 'Low Value Customer'
    END AS customer_value_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty_score,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_promo_dependency,
    ROUND(AVG(purchase_frequency_score),2)
    AS avg_purchase_frequency,
    ROUND(AVG(review_rating),2)
    AS avg_review_rating
FROM dataset
GROUP BY customer_value_group;


SELECT
    frequency_of_purchases,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases
FROM dataset
GROUP BY frequency_of_purchases
ORDER BY avg_spending DESC;


SELECT
    subscription_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency
FROM dataset
GROUP BY subscription_status;


SELECT
    CASE
        WHEN promo_dependency_score >= 0.7
        THEN 'Highly Promo Dependent'
        WHEN promo_dependency_score >= 0.4
        THEN 'Moderately Promo Dependent'
        ELSE 'Low Promo Dependency'
    END AS promo_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases
FROM dataset
GROUP BY promo_group
ORDER BY avg_spending DESC;


SELECT
    customer_segment,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(purchase_frequency_score),2)
    AS avg_frequency,
    ROUND(AVG(review_rating),2)
    AS avg_rating,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency
FROM dataset
GROUP BY customer_segment
ORDER BY avg_spending DESC;

-- ===============================
-- Question 3
-- ==============================

SELECT
    location,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases
FROM dataset
GROUP BY location
ORDER BY avg_spending DESC;


SELECT
    location,
    COUNT(*) AS customers,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(churn_risk_score),2)
    AS avg_churn_risk,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending
FROM dataset
GROUP BY location
ORDER BY avg_loyalty DESC;


SELECT
    gender,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency
FROM dataset
GROUP BY gender;

SELECT
    age_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency
FROM dataset
GROUP BY age_group
ORDER BY avg_spending DESC;

SELECT
    location,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency,
    CASE
        WHEN COUNT(*) < 60
        AND AVG(purchase_amount_usd) > 60
        THEN 'Underleveraged Opportunity'
        WHEN COUNT(*) >= 60
        THEN 'Established Market'
        ELSE 'Low Potential'
    END AS market_status
FROM dataset
GROUP BY location
ORDER BY avg_spending DESC;


-- ====================================
-- QUESTION 4
-- Discount vs Non-Discount Customers
-- ====================================

SELECT
    discount_applied,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(churn_risk_score),2)
    AS avg_churn_risk
FROM dataset
GROUP BY discount_applied;

-- ====================================
-- Promo Dependency by Customer Segment
-- ====================================

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_promo_dependency,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending
FROM dataset
GROUP BY customer_segment
ORDER BY avg_promo_dependency DESC;

-- ====================================
-- High Value Customers Receiving Discounts
-- ====================================

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_promo_dependency
FROM dataset
WHERE purchase_amount_usd >= 75
GROUP BY customer_segment
ORDER BY avg_spending DESC;

-- ====================================
-- Churn Risk vs Promo Dependency
-- ====================================

SELECT
    CASE
        WHEN churn_risk_score >= 0.7
        THEN 'High Risk'
        WHEN churn_risk_score >= 0.4
        THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS churn_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_promo_dependency,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending
FROM dataset
GROUP BY churn_group;


-- ====================================
-- Promotion Strategy Recommendation
-- ====================================

SELECT
    customer_segment,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_promo_dependency,
    ROUND(AVG(churn_risk_score),2)
    AS avg_churn_risk,
    CASE
        WHEN AVG(loyalty_score) >= 0.7
        AND AVG(promo_dependency_score) <= 0.3
        THEN 'Avoid Discounts - Offer Premium Benefits'
        WHEN AVG(churn_risk_score) >= 0.6
        THEN 'Retention Discounts Recommended'
        ELSE 'Selective Promotions'
    END AS recommendation
FROM dataset
GROUP BY customer_segment;

-- ====================================
-- QUESTION 5
-- Ideal Customer Profile
-- ====================================

SELECT
    gender,
    age_group,
    category,
    subscription_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases,
    ROUND(AVG(promo_dependency_score),2)
    AS avg_discount_dependency
FROM dataset
WHERE customer_segment = 'vip_loyalists'
GROUP BY
    gender,
    age_group,
    category,
    subscription_status
ORDER BY avg_spending DESC;

-- ====================================
-- Best Age Group Analysis
-- ====================================

SELECT
    age_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty,
    ROUND(AVG(previous_purchases),2)
    AS avg_previous_purchases
FROM dataset
WHERE customer_segment = 'vip_loyalists'
GROUP BY age_group
ORDER BY avg_spending DESC;

-- ====================================
-- Gender Profile of VIP Customers
-- ====================================

SELECT
    gender,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty
FROM dataset
WHERE customer_segment = 'vip_loyalists'
GROUP BY gender
ORDER BY avg_spending DESC;

-- ====================================
-- Favorite Category of VIP Customers
-- ====================================

SELECT
    category,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty
FROM dataset
WHERE customer_segment = 'vip_loyalists'
GROUP BY category
ORDER BY total_customers DESC;


-- ====================================
-- Best Location for Ideal Customers
-- ====================================

SELECT
    location,
    COUNT(*) AS total_customers,
    ROUND(AVG(purchase_amount_usd),2)
    AS avg_spending,
    ROUND(AVG(loyalty_score),2)
    AS avg_loyalty
FROM dataset
WHERE customer_segment = 'vip_loyalists'
GROUP BY location
ORDER BY avg_spending DESC
LIMIT 15;