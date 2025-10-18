CREATE DATABASE sentiment_analysis_db;

USE sentiment_analysis_db;

-- Table to store feedback

CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    product_name VARCHAR(100),
    review_text TEXT,
    polarity FLOAT,
    sentiment VARCHAR(10),
    review_date DATE
);

INSERT INTO feedback (customer_name, product_name, review_text, polarity, sentiment, review_date) VALUES
('Riya', 'Wireless Earbuds', 'Excellent sound quality and battery life!', 0.85, 'Positive', '2025-10-01'),
('Aarav', 'Smartphone X', 'Worst phone I have ever used.', -0.9, 'Negative', '2025-10-02'),
('Kavya', 'Laptop Pro', 'Good performance but gets heated quickly.', 0.2, 'Neutral', '2025-10-03'),
('Rahul', 'Smartwatch Z', 'Love the design and features!', 0.9, 'Positive', '2025-10-04'),
('Sneha', 'Bluetooth Speaker', 'Sound quality is terrible and very noisy.', -0.8, 'Negative', '2025-10-05'),
('Arjun', 'Smart TV', 'Picture quality is good but sound could be better.', 0.1, 'Neutral', '2025-10-06'),
('Priya', 'Laptop Pro', 'Absolutely amazing performance and sleek design.', 0.95, 'Positive', '2025-10-07'),
('Dev', 'Smartphone X', 'Battery drains too fast.', -0.6, 'Negative', '2025-10-08'),
('Anjali', 'Bluetooth Speaker', 'Affordable and works great.', 0.75, 'Positive', '2025-10-09'),
('Vikram', 'Smart TV', 'Not worth the price.', -0.7, 'Negative', '2025-10-10');


-- 1. Total Reviews by Sentiment

SELECT sentiment, COUNT(*) AS total_reviews
FROM feedback
GROUP BY sentiment;


-- 2. Average Polarity by Sentiment

SELECT sentiment, ROUND(AVG(polarity), 3) AS avg_polarity
FROM feedback
GROUP BY sentiment;


-- 3. Top Positive Feedback

SELECT customer_name, product_name, review_text, polarity
FROM feedback
ORDER BY polarity DESC
LIMIT 3;


-- 4. SELECT customer_name, product_name, review_text, polarity

SELECT customer_name, product_name, review_text, polarity
FROM feedback
ORDER BY polarity ASC
LIMIT 3;


-- 5. Sentiment Analysis by Product

SELECT product_name, sentiment, COUNT(*) AS total
FROM feedback
GROUP BY product_name, sentiment
ORDER BY product_name;


-- 6. Most Loved Products (Highest Average Polarity)

SELECT product_name, ROUND(AVG(polarity), 2) AS avg_sentiment_score
FROM feedback
GROUP BY product_name
ORDER BY avg_sentiment_score DESC;


-- 7. Daily Sentiment Trend

SELECT review_date, sentiment, COUNT(*) AS total
FROM feedback
GROUP BY review_date, sentiment
ORDER BY review_date;


-- 8. How many feedbacks are positive, negative, and neutral?

SELECT sentiment, COUNT(*) AS total 
FROM feedback 
GROUP BY sentiment;


-- 9. What is the average polarity score of all reviews?

SELECT ROUND(AVG(polarity), 2) AS avg_polarity 
FROM feedback;


-- 10. Which product received the highest number of reviews?

SELECT product_name, COUNT(*) AS total_reviews
FROM feedback
GROUP BY product_name
ORDER BY total_reviews DESC
LIMIT 1;


-- 11. Show all reviews submitted in October 2025.

SELECT * FROM feedback
WHERE MONTH(review_date) = 10 AND YEAR(review_date) = 2025;


-- 12. Find the product with the highest average sentiment score.

SELECT product_name, ROUND(AVG(polarity), 2) AS avg_score
FROM feedback
GROUP BY product_name
ORDER BY avg_score DESC
LIMIT 1;


-- 13. Which product has received the most negative feedback?

SELECT product_name, COUNT(*) AS negative_reviews
FROM feedback
WHERE sentiment = 'Negative'
GROUP BY product_name
ORDER BY negative_reviews DESC
LIMIT 1;


-- 14. Find customers who gave only positive feedback.

SELECT customer_name
FROM feedback
GROUP BY customer_name
HAVING SUM(sentiment = 'Negative') = 0
AND SUM(sentiment = 'Positive') > 0;


-- 15. Find the average sentiment polarity per day.

SELECT review_date, ROUND(AVG(polarity), 2) AS avg_polarity
FROM feedback
GROUP BY review_date
ORDER BY review_date;


-- 16. Show the ratio of positive to negative feedback for each product.

SELECT 
  product_name,
  SUM(sentiment = 'Positive') AS positive_count,
  SUM(sentiment = 'Negative') AS negative_count,
  ROUND(SUM(sentiment = 'Positive') / SUM(sentiment = 'Negative'), 2) AS pos_neg_ratio
FROM feedback
GROUP BY product_name;


-- 17. Find customers who gave both positive and negative reviews.

SELECT customer_name
FROM feedback
GROUP BY customer_name
HAVING SUM(sentiment = 'Positive') > 0 AND SUM(sentiment = 'Negative') > 0;


-- 18. Identify products with mixed sentiment (positive and negative).

SELECT product_name
FROM feedback
GROUP BY product_name
HAVING SUM(sentiment = 'Positive') > 0 AND SUM(sentiment = 'Negative') > 0;


-- 19. Calculate the percentage of each sentiment type.

SELECT 
  sentiment,
  ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM feedback), 2) AS percentage
FROM feedback
GROUP BY sentiment;


-- 20. Which day had the most positive feedback submissions?

SELECT review_date, COUNT(*) AS total_positive
FROM feedback
WHERE sentiment = 'Positive'
GROUP BY review_date
ORDER BY total_positive DESC
LIMIT 1;


-- 21. Find products whose sentiment score is below the overall average.

SELECT product_name, ROUND(AVG(polarity), 2) AS avg_score
FROM feedback
GROUP BY product_name
HAVING AVG(polarity) < (SELECT AVG(polarity) FROM feedback);


-- 22. What is the most frequent word in positive feedback (if tokenized and stored)?

SELECT word, COUNT(*) AS frequency
FROM words
WHERE sentiment = 'Positive'
GROUP BY word
ORDER BY frequency DESC
LIMIT 1;
 

