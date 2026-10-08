# Financial Performance & Risk Analytics

## Project Overview
This project presents an end-to-end data analytics workflow designed to evaluate corporate financial performance alongside operational risk metrics. 
Using a synthesized IoT-financial dataset of ~8,900 transaction records, the project spans the entire analytical pipeline—from data ingestion and cleaning in Python to relational database modeling in PostgreSQL, followed by interactive data visualization in Power BI.

The primary objective is to provide executive leadership with a consolidated view of organizational health. By integrating top-line financial metrics (Revenue, Profit, Operating Costs) with granular risk indicators (Fraud Risk Scores, Security Breach Attempts, Automation Efficiency), this solution equips stakeholders with actionable insights to drive revenue growth while mitigating operational and security vulnerabilities.

## Business Problem
Finance and risk management teams often operate in silos, making it difficult to evaluate the impact of operational security on bottom-line financial health. Key business challenges include:
- Lack of a unified view connecting departmental financial performance with operational risk indicators.
- Inability to quickly identify departments or regions experiencing disproportionately high security breach attempts.
- Unclear relationship between process automation efficiency and fraud risk mitigation.

## Business Objectives
- Develop a centralized data pipeline combining data cleaning, SQL querying, and executive reporting.
- Quantify key financial metrics including Total Revenue, Net Profit, Operating Costs, and Gross Margin.
- Evaluate department-wise risk levels using Fraud Risk Scores and Security Breach Attempt trends.
- Deliver a scroll-free, corporate-ready 2-page Power BI dashboard for seamless executive decision-making.

## Dataset
- **Rows:** ~8,900
- **Columns:** 12+
- **Data Type:** Financial Transactions & Operational Logs
- **Key Fields:** `Transaction_ID`, `Department`, `Region`, `Financial_Status`, `Transaction_Amount`, `Net_Profit`, `Operating_Cost`, `Fraud_Risk_Score`, `Security_Breach_Attempts`, `Automation_Efficiency`

## Tools & Technologies
| Tool | Purpose |
| :--- | :--- |
| **Python (Pandas, NumPy)** | Data cleaning, data type validation, missing value handling, and exploratory data analysis (EDA). |
| **PostgreSQL** | Relational database analysis, SQL schema design (Star Schema), KPI querying, and aggregate functions. |
| **Power BI Desktop** | Star Schema data modeling, DAX measure creation, UI layout design, and interactive dashboard development. |
| **DAX (Data Analysis Expressions)** | Custom KPIs (`SUM`, `AVERAGE`, `COUNT`, `MAX`), conditional formatting, and filter context management. |
| **GitHub** | Version control, project documentation, and portfolio showcase. |

## Project Workflow
- **Raw Dataset Ingestion**
- **Python Data Cleaning & EDA**
- **PostgreSQL Analysis & Business Queries**
- **Power BI Data Modeling & DAX Measures**
- **Interactive 2-Page Power BI Dashboard**
- **Business Insights & Recommendations**

---

## Python Analysis
Python was utilized for initial data ingestion, structural validation, and automated data cleaning:
- Handled missing values, standardized string formats, and validated numeric data types.
- Conducted exploratory data analysis (EDA) to check metric distribution and detect anomalous outliers.
- Exported clean CSV datasets ready for database loading and Power BI integration (`03_Dim_Department_Processed_Data.csv`, `04_Dim_Region_Processed_Data.csv`, `05_Dim_Status_Processed_Data.csv`, `06_Fact_Financials_Processed_Data.csv`).

**Python Notebook:** [07_data_cleaning_and_eda.ipynb](scripts/07_data_cleaning_and_eda.ipynb)

---

## SQL Analysis
PostgreSQL was leveraged to structure the relational database and execute business-critical queries:
- Designed a Star Schema architecture establishing relationships between Fact tables (`06_Fact_Financials_Processed_Data`) and Dimension tables (`03_Dim_Department_Processed_Data`, `04_Dim_Region_Processed_Data`, `05_Dim_Status_Processed_Data`).
- Wrote analytical queries to calculate departmental aggregations, regional revenue contributions, and breach attempt distribution.
- Optimized indexing to ensure efficient query performance across ~8,900 records.

**SQL File:** [08_financial_analytics_queries.sql](scripts/08_financial_analytics_queries.sql)

---

## Power BI Dashboard
The Power BI report contains 2 dedicated interactive pages:

### 1. Executive Financial Overview
Focuses on executive-level financial metrics, revenue streams, and departmental profitability.
- **Core KPIs:** Total Revenue ($4.67K), Total Net Profit ($1.36K), Total Operating Cost ($2.29K), Avg Gross Margin (37.86%)
- **Net Profit Performance By Department:** Horizontal bar chart displaying Net Profit ranked across Investment, Audit, Accounts, Treasury, Risk, and Operations.
- **Total Revenue Contribution By Region:** Donut chart highlighting percentage breakdown across South, West, Central, North, and East regions.

### 2. Risk & Operational Analytics
Focuses on threat monitoring, fraud risk distribution, and process automation efficiency.
- **Core KPIs:** High Risk Txns (1K), Avg Fraud Risk Score (50.33%), Avg Automation Efficiency (74.41%)
- **High Risk Txns by Department & Region Breach Donut:** Clustered column chart showing transaction counts and donut chart breaking down 85K total breach attempts by region.
- **Risk Score vs Automation Efficiency:** Scatter plot evaluating correlation between automation adoption and fraud risk by department.
- **Departmental Risk Summary:** A clean, scroll-free summary table tracking `Max Breach Attempts`, `Avg Fraud Risk`, and `Avg Automation Efficiency` across all 6 departments.

**Power BI Dashboard File:** [09_Financial_&_Operational_Analytics_Dashboard.pbix](reports/09_Financial_&_Operational_Analytics_Dashboard.pbix)

---

## Key KPIs
| KPI | Overall Result |
| :--- | :--- |
| **Total Revenue** | $4.67K |
| **Total Net Profit** | $1.36K |
| **Total Operating Cost** | $2.29K |
| **Avg Gross Margin** | 37.86% |
| **High Risk Transactions** | 1K |
| **Avg Fraud Risk Score** | 50.33% |
| **Avg Automation Efficiency** | 74.41% |

---

## Key Business Insights
### Financial Performance Insights
- **Departmental Profitability Leader:** Investment leads in net profit generation ($235.36), closely followed by Audit ($234.99) and Accounts ($228.41).
- **Even Regional Distribution:** Revenue contribution across regions is highly balanced, with South ($954.85 / 20.46%) and West ($946.21 / 20.27%) taking the top spots.

### Risk & Operational Insights
- **High Security Threat Volume:** Security breach attempts reached 85K overall, distributed uniformly across South (20.21%), Central (20.52%), and North (20.64%).
- **Automation Impact:** Operational efficiency averages 74.41%, showing a positive correlation with reduced risk scores in automated departments like Audit and Accounts.

---

## Business Recommendations
- **Enhance Security Monitoring:** Target high-breach regions (North and Central) with automated threat detection systems to curb the 85K breach attempt volume.
- **Optimize Operational Costs:** Re-evaluate process overhead in lower-margin departments to improve the overall 37.86% Gross Margin.
- **Scale Automation:** Expand high-performing automation workflows across Treasury and Operations to lower fraud risk scores closer to target thresholds.

--- 

## Dashboard Preview

### Executive Financial Overview
![Executive Financial Overview](docs/10_Page_1_Dashboard_Preview.png)

### Risk & Operational Analytics
![Risk & Operational Analytics](docs/11_Page_2_Dashboard_Preview.png)
