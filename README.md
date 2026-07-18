# E-commerce Sales & Promotion Analytics

End-to-end analytics project on 160K+ e-commerce clickstream events — covering SQL-based data cleaning, Python EDA, and an interactive Power BI dashboard to track revenue, customer behavior, and promotion effectiveness.

## Overview

This project analyzes user browsing and purchase events from an e-commerce platform (Oct–Nov 2019) alongside a promotions calendar, to answer:
- Where is revenue coming from (brand, category, state, channel, time of day)?
- How do customers move through the funnel — View → Cart → Purchase?
- Are promotional discounts actually driving incremental sales?

## Tech Stack

| Layer | Tools |
|---|---|
| Database | SQL Server |
| Data Cleaning & Aggregation | T-SQL (views for KPIs, revenue breakdowns, funnel, promotions) |
| EDA & Feature Engineering | Python (pandas, numpy, matplotlib, SQLAlchemy) |
| Visualization | Power BI |

## Repository Contents

| File | Description |
|---|---|
| `Sales_Data_Ecommerce.csv` | Raw clickstream data — 160,000 events (View/Cart/Purchase) across users, products, and sessions |
| `Promotion.csv` | Promotion calendar — 61 records mapping discount % to product and date |
| `ecomm_analysis.sql` | Data quality checks, KPI/revenue/funnel queries, and reusable SQL views |
| `Ecommerce_Analytics.ipynb` | Python notebook — data cleaning, merging, feature engineering, and EDA |
| `Ecommerce_Analysis.pbix` | Power BI dashboard (Executive Overview + Marketing & Promotion Effectiveness) |

## Dataset

**Sales data** (160,000 rows, 18 columns): user ID, event date/time/hour, channel (App/Browser), event type (View/Cart/Purchase), product ID, category/sub-categories, brand, price, session ID, state, and user score.

**Promotion data** (61 rows): promotion ID, date, discount %, and the product it applied to.

## Workflow

1. **SQL layer** — Validated row counts and null values, removed fully-null promotion rows, and built reusable views (`vw_ExecutiveKPIs`, `vw_RevenueByBrand`, `vw_RevenueByCategory`, `vw_RevenueByState`, `vw_CustomerFunnel`, `vw_PromotionPerformance`) joining sales to promotions on product ID and date.
2. **Python layer** — Loaded data via SQLAlchemy, removed 38 duplicate rows, converted date types, merged sales with promotions, engineered `revenue` and `promotion_flag` fields, and ran EDA across the funnel, pricing distribution, and revenue by brand/category/state/hour/promotion.
3. **Power BI layer** — Built a two-page interactive dashboard:
   - **Executive Overview**: KPI cards, revenue by brand/category (bar charts), category treemap, and revenue trend lines, with slicers for channel/state/category/date.
   - **Marketing & Promotion Effectiveness**: conversion funnel, event-type breakdown, revenue by promotion, and discount-vs-revenue combo chart.

## Key Insights

- **Funnel**: 125,925 Views → 19,409 Carts (15.4% conversion) → 14,628 Purchases (~75% Cart→Purchase conversion). The biggest drop-off is View → Cart, making cart conversion the primary growth lever.
- **Revenue concentration**: Apple leads brand revenue (₹3.08M), more than double Samsung (₹1.29M). Electronics dominates category revenue (₹4.97M), far ahead of Appliances (₹0.37M) and Computers (₹0.31M).
- **Regional performance**: Revenue is fairly balanced across the top 10 states (₹119K–₹134K), led by MS, IA, and MD.
- **Time-of-day**: Revenue peaks 8–11 AM (~₹420K/hour) and drops below ₹100K/hour after 8 PM — mornings are the most profitable window.
- **Promotion effectiveness**: Promotional sales (₹23.1K) account for under 1% of total revenue (₹5.62M non-promotional) — indicating current promotions have minimal measurable impact or very limited promotional coverage relative to overall catalog activity.

