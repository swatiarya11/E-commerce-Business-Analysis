# E-commerce Sales & Promotion Analytics

End-to-end analytics project on **160K+ e-commerce clickstream events**, covering SQL-based data cleaning, Python EDA, interactive Power BI dashboards, and AI-powered executive business reporting using Google Gemini API.

---

# Overview

This project analyzes user browsing and purchase events from an e-commerce platform (Oct–Nov 2019) alongside a promotions calendar to answer:

- Where is revenue coming from (brand, category, state, channel, time of day)?
- How do customers move through the funnel — **View → Cart → Purchase**?
- Are promotional discounts driving incremental sales?
- How can AI automatically generate executive business insights from business KPIs?

---

# Tech Stack

| Layer | Tools |
|--------|-------|
| Database | SQL Server |
| Data Cleaning & Aggregation | T-SQL (Views & KPI Aggregation) |
| EDA & Feature Engineering | Python (Pandas, NumPy, Matplotlib, SQLAlchemy) |
| Visualization | Power BI |
| AI Reporting | Google Gemini API, Prompt Engineering |

---

# Repository Contents

| File | Description |
|------|-------------|
| Sales_Data_Ecommerce.csv | Raw clickstream data (~160K events) |
| Promotion.csv | Promotion calendar (61 records) |
| ecomm_analysis.sql | Data cleaning, KPI queries and reusable SQL views |
| Ecommerce_Analytics.ipynb | Data cleaning, EDA, feature engineering and AI report generation |
| Ecommerce_Analysis.pbix | Power BI dashboards (Executive Overview & Marketing & Promotion Effectiveness) |
| ai_summary.md | AI-generated Executive Business Report |

---

# Dataset

**Sales data (160K rows, 18 columns):** User ID, event date/time, channel, event type (View/Cart/Purchase), product ID, category, brand, price, session ID, state, and customer score.

**Promotion data (61 rows):** Promotion ID, product ID, discount %, and promotion date.

---

# Workflow

### SQL Layer
- Validated data quality, removed invalid records, and created reusable SQL views for Executive KPIs, Revenue Analysis, Customer Funnel, and Promotion Performance.

### Python Layer
- Connected SQL Server using SQLAlchemy, cleaned and merged datasets, engineered business features, performed EDA, and analyzed revenue, customer funnel, and promotional performance.

### Power BI Layer
Built **2 interactive dashboards**:

**Executive Overview**
- KPI Cards
- Revenue by Brand, Category & State
- Revenue Trend Analysis
- Interactive Slicers

**Marketing & Promotion Effectiveness**
- Customer Funnel
- Promotion Performance
- Event Distribution
- Discount vs Revenue Analysis

### AI Reporting Layer
- Integrated **Google Gemini API** with Python to automatically generate executive business reports in Markdown, providing business insights, risks, and strategic recommendations from SQL-derived KPIs.

---

# Key Insights

- **Customer Funnel:** 125,925 Views → 19,409 Carts (15.4%) → 14,628 Purchases (~75% Cart-to-Purchase conversion), with the largest drop-off occurring between **View → Cart**.
- **Revenue Performance:** Apple generated **~$3.08M**, while Electronics contributed **~$4.97M**, making them the strongest revenue drivers.
- **Promotion Effectiveness:** Promotions contributed **21%** of total revenue, while **79%** came from non-promotional sales.
- **Time-of-Day Analysis:** Purchase activity peaked between **8–11 AM**, indicating the most profitable sales window.
- **AI Executive Reporting:** Automated KPI interpretation using **Google Gemini API**, generating management-ready summaries and strategic business recommendations.

---

# Project Highlights

- Processed **160K+ e-commerce clickstream events**
- Built reusable SQL views for business KPIs
- Performed end-to-end EDA using Python
- Designed **2 interactive Power BI dashboards**
- Automated executive reporting using **Google Gemini API**
- Generated AI-powered business insights in Markdown format
