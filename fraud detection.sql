create table dataset(
Transaction_ID	varchar(50),
User_ID	varchar(50),
Transaction_Amount float,
Transaction_Type	varchar(50),
Account_Balance float,
Device_Type varchar(50),
Location varchar(50),
Merchant_Category varchar(50),	IP_Address_Flag int default 0,
Daily_Transaction_Count	int,
Avg_Transaction_Amount_Id float,
Failed_Transaction_Count_Id	int,
Card_Type varchar(50),
Card_Age int,
Transaction_Distance float,
Authentication_Method varchar(50),
Risk_Score float,
Fraud_Label int
);
-- 1 List all transactions where the account balance is below $1000
SELECT * FROM dataset WHERE Account_Balance < 1000;

-- 2. Find all transactions where the fraud label is 1
SELECT * FROM DATASET WHERE FRAUD_LABEL=1;

 -- 3.Show the top 10 highest transaction amounts.
SELECT * FROM DATASET
ORDER BY TRANSACTION_AMOUNT DESC
LIMIT 10;

-- 4. Find all transactions from a specific location (e.g., 'New York').
SELECT * FROM DATASET
WHERE LOCATION = 'New York';

-- 5.List all users who made more than 10 transactions in a day.
SELECT User_ID, COUNT(*) AS transaction_count 
FROM DATASET
WHERE Daily_Transaction_Count > 10
GROUP BY User_ID;

ALTER TABLE DATASET 
RENAME COLUMN avg_transaction_amount_id to avg_7d;

ALTER TABLE DATASET 
RENAME COLUMN failed_transaction_count_id to failtransaction_7d;

 -- 8. Retrieve transactions where the transaction amount is greater than the 7-day average.
SELECT TRANSACTION_AMOUNT, AVG_7D FROM DATASET
WHERE Transaction_Amount > Avg_7d;

-- 9.Count the number of transactions made by each user.
SELECT USER_ID, COUNT(*) AS TRANSACTION_COUNT FROM DATASET
GROUP BY USER_ID
ORDER BY TRANSACTION_COUNT DESC;

-- 10. Find all transactions from a specific device (e.g., 'mobile').
select (user_id),device_type from dataset
where device_type = 'Mobile';

-- 11 List all unique `Transaction_Type` values from the dataset.
SELECT DISTINCT Transaction_Type 
FROM dataset;

-- 12. Find all transactions made using the `Visa` card type
SELECT * FROM DATASET
WHERE Card_Type = 'Visa';

-- 13 Count the number of fraudulent transactions ('Fraud_Label = 1')
SELECT COUNT(*) AS Fraudulent_Transactions FROM dataset
 WHERE Fraud_Label = 1;

-- 14. Find the average `Transaction_Amount` for each Transaction_Type.
 SELECT transaction_type, AVG(Transaction_Amount) AS Avg_Amount
 FROM DATASET
 group by transaction_type;

-- 15. Retrieve the top 10 users (User_ID) who have made the highest number of transactions.
SELECT USER_ID, COUNT(*) AS TRANSACTION_COUNT
FROM DATASET
GROUP BY USER_ID
ORDER BY TRANSACTION_COUNT DESC
LIMIT 10;

 -- 16. Find the total number of transactions per Merchant_Category.
SELECT MERCHANT_CATEGORY, COUNT(*) AS TOTAL_TRANSACTION FROM DATASET
GROUP BY MERCHANT_CATEGORY;

-- 17.Retrieve transactions where the Risk_Score is above the average Risk_Score of all transactions.
SELECT * FROM dataset
 WHERE Risk_Score > (SELECT AVG(Risk_Score) FROM dataset);

-- 18. Rank transactions by Transaction_Amount within each Transaction_Type using a window function.
SELECT Transaction_ID, Transaction_Type, Transaction_Amount,
RANK() OVER (PARTITION BY Transaction_Type ORDER BY Transaction_Amount DESC) AS Rank
FROM dataset;


select * from dataset;