-- 1. Create Dimension Tables

CREATE TABLE Dim_Region (
    Region_ID VARCHAR(20) PRIMARY KEY,
    Region VARCHAR(50) NOT NULL
);

CREATE TABLE Dim_Department (
    Department_ID VARCHAR(20) PRIMARY KEY,
    Department VARCHAR(50) NOT NULL
);

CREATE TABLE Dim_Status (
    Status_ID VARCHAR(20) PRIMARY KEY,
    Financial_Status VARCHAR(50) NOT NULL
);

-- 2. Create Fact Table

CREATE TABLE Fact_Financials (
    Transaction_ID VARCHAR(20) PRIMARY KEY,
    Branch_ID INT,
    Device_ID VARCHAR(20),
    Region_ID VARCHAR(20) REFERENCES Dim_Region(Region_ID),
    Department_ID VARCHAR(20) REFERENCES Dim_Department(Department_ID),
    Status_ID VARCHAR(20) REFERENCES Dim_Status(Status_ID),
    Smart_Terminal_Usage NUMERIC(10,2),
    ERP_Response_Time_ms NUMERIC(10,2),
    Network_Latency_ms NUMERIC(10,2),
    Sensor_Data_Integrity NUMERIC(10,2),
    Connected_Devices_Count INT,
    Cloud_Sync_Delay_s NUMERIC(10,2),
    System_Uptime NUMERIC(10,2),
    API_Request_Rate INT,
    Transaction_Processing_Time_ms NUMERIC(10,2),
    Device_Error_Rate NUMERIC(10,2),
    Revenue NUMERIC(15,2),
    Net_Profit NUMERIC(15,2),
    Operating_Cost NUMERIC(15,2),
    Gross_Margin NUMERIC(10,2),
    ROI NUMERIC(10,2),
    EBITDA NUMERIC(15,2),
    Current_Ratio NUMERIC(10,2),
    Quick_Ratio NUMERIC(10,2),
    Cash_Flow NUMERIC(15,2),
    Working_Capital NUMERIC(15,2),
    Debt_to_Equity NUMERIC(10,2),
    Resource_Utilization NUMERIC(10,2),
    Energy_Consumption_kWh NUMERIC(10,2),
    Maintenance_Cost NUMERIC(15,2),
    Transaction_Cost NUMERIC(10,2),
    Automation_Efficiency NUMERIC(10,2),
    Fraud_Risk_Score NUMERIC(10,3),
    Credit_Risk_Level NUMERIC(10,3),
    Security_Breach_Attempts INT,
    Compliance_Score NUMERIC(10,2),
    Market_Volatility_Index NUMERIC(10,2),
    Anomaly_Score NUMERIC(10,3),
    Performance_Score NUMERIC(10,2)
);


SELECT * FROM dim_department;
SELECT * FROM dim_region;
SELECT * FROM dim_status;
SELECT * FROM fact_financials;


SELECT 'Fact_Financials' AS table_name, COUNT(*) AS total_rows FROM Fact_Financials
UNION ALL
SELECT 'Dim_Region', COUNT(*) FROM Dim_Region
UNION ALL
SELECT 'Dim_Department', COUNT(*) FROM Dim_Department


-- 3. Executive Financial Summary

SELECT 
    ROUND(SUM(f.Revenue) / 1000000.0, 2) AS total_revenue_millions,
    ROUND(SUM(f.Net_Profit) / 1000000.0, 2) AS total_net_profit_millions,
    ROUND(SUM(f.Operating_Cost) / 1000000.0, 2) AS total_operating_cost_millions,
    ROUND(AVG(f.Gross_Margin), 2) AS avg_gross_margin_pct
FROM Fact_Financials f;


-- 4. Department-wise Performance & Profitability Ranking

WITH Department_Metrics AS (
    SELECT 
        d.Department,
        ROUND(SUM(f.Revenue) / 1000000.0, 2) AS total_revenue_m,
        ROUND(SUM(f.Net_Profit) / 1000000.0, 2) AS total_profit_m,
        ROUND(AVG(f.Gross_Margin), 2) AS avg_margin_pct
    FROM Fact_Financials f
    JOIN Dim_Department d ON f.Department_ID = d.Department_ID
    GROUP BY d.Department
)
SELECT 
    Department,
    total_revenue_m,
    total_profit_m,
    avg_margin_pct,
    DENSE_RANK() OVER (ORDER BY total_profit_m DESC) AS profit_rank
FROM Department_Metrics;


-- 5. Regional Revenue Contribution & Percentage Share

WITH Region_Metrics AS (
    SELECT 
        r.Region,
        ROUND(SUM(f.Revenue) / 1000000.0, 2) AS regional_revenue_m,
        ROUND(SUM(f.Net_Profit) / 1000000.0, 2) AS regional_profit_m
    FROM Fact_Financials f
    JOIN Dim_Region r ON f.Region_ID = r.Region_ID
    GROUP BY r.Region
)
SELECT 
    Region,
    regional_revenue_m,
    regional_profit_m,
    ROUND((regional_revenue_m / SUM(regional_revenue_m) OVER()) * 100, 2) AS revenue_contribution_pct
FROM Region_Metrics
ORDER BY regional_profit_m DESC;


-- 6. Operational Risk & Anomaly Profiling

SELECT 
    f.Transaction_ID,
    d.Department,
    r.Region,
    s.Financial_Status,
    f.ERP_Response_Time_ms,
    f.Network_Latency_ms,
    f.Fraud_Risk_Score,
    f.Security_Breach_Attempts,
    f.Anomaly_Score
FROM Fact_Financials f
JOIN Dim_Department d ON f.Department_ID = d.Department_ID
JOIN Dim_Region r ON f.Region_ID = r.Region_ID
JOIN Dim_Status s ON f.Status_ID = s.Status_ID
WHERE f.Fraud_Risk_Score > 0.85 OR f.Security_Breach_Attempts > 3
ORDER BY f.Fraud_Risk_Score DESC
LIMIT 10;


-- 7. Cumulative Revenue Trend & Running Total

WITH Daily_Revenue AS (
    SELECT 
        Transaction_ID,
        Department_ID,
        Revenue,
        ROUND(SUM(Revenue) OVER (ORDER BY Transaction_ID) / 1000000.0, 2) AS running_total_revenue_m
    FROM Fact_Financials
)
SELECT 
    Transaction_ID,
    Department_ID,
    ROUND(Revenue / 1000000.0, 4) AS transaction_revenue_m,
    running_total_revenue_m
FROM Daily_Revenue
LIMIT 10;


-- 8. High Risk & Low Efficiency Flagging

WITH Department_Risk_Profiling AS (
    SELECT 
        f.Transaction_ID,
        d.Department,
        f.Fraud_Risk_Score,
        f.Automation_Efficiency,
        NTILE(4) OVER (ORDER BY f.Fraud_Risk_Score DESC) AS risk_quartile
    FROM Fact_Financials f
    JOIN Dim_Department d ON f.Department_ID = d.Department_ID
)
SELECT 
    Department,
    COUNT(Transaction_ID) AS high_risk_transaction_count,
    ROUND(AVG(Automation_Efficiency), 2) AS avg_automation_efficiency_pct
FROM Department_Risk_Profiling
WHERE risk_quartile = 1 -- Top 25% Highest Risk Transactions
GROUP BY Department
ORDER BY high_risk_transaction_count DESC;
