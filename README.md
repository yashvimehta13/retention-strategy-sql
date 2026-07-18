# Decoding Customer Retention: A Full-Stack Analytics Project

## Project Overview

A D2C fashion brand with 3,900 customers had no structured way to understand who its most valuable customers were, whether its promotional programme was building loyalty or just attracting one-time bargain hunters, and what a path to sustainable retention looked like.

This project builds a complete customer intelligence system from scratch using only transactional and behavioural data — with no pre-built loyalty scores, no churn labels, and no external benchmarks.

---

## Business Problem

> *"Is the business successfully building a loyal customer base, or is it reliant on continuous promotional activity? What strategic actions should be taken under either scenario?"*

---

## Key Findings

- **42.7% of revenue is promo-driven** — nearly half the business depends on discounts to convert
- **Only 16.1% of customers are genuinely loyal** — 627 out of 3,900
- **100% of loyal customers have zero promo dependency** — promotions do not create loyalty, they attract a different customer entirely
- **Even Premium tier customers are 42% promo dependent** — discounting is not targeted, it is brand-wide
- **Boomers (55+) are the largest and highest-spending segment** — currently untargeted by the brand
- **Arizona, Tennessee, and Alaska show strong organic demand** — commercially underlevered geographies

---

## Project Structure

```
customer_retention/
│
├── customer_segmentation_queries.sql        # 5 segmentation queries
├── Customer_Value_EDA.ipynb                 # Exploratory data analysis
├── Customer_Value_FeatureEngineering.ipynb  # Data cleaning + feature engineering
├── Customer_Value_Dashboard.pbix            # Power BI 4-panel founder dashboard
├── Executive_Summary.pdf                    # 1-page findings + recommendations
└── Retention_Playbook.pdf                   # Promo sunset plan + ideal customer profile
```

---

## Engineered Features

| Feature | Description |
|---|---|
| `Promo_Dependency_Score` | How reliant is this customer on discounts to buy? (0 = never, 1 = always) |
| `Value_Tier` | Overall customer worth — Low / Medium / High / Premium |
| `Loyalty_Def1` | Behavioural loyalty — frequent buyer, long history, zero promo dependency |
| `Loyalty_Def2` | Value + satisfaction loyalty — high spend, high rating, subscribed |
| `Satisfaction_Flag` | At-risk indicator based on review rating threshold |
| `Frequency_Score` | Numeric mapping of purchase frequency (1 = Annually, 7 = Weekly) |
| `Age_Group` | Generational cohort — Gen Z, Millennial, Mid-Millennial, Gen X, Boomer |

**Two competing loyalty definitions were built and tested.** Definition 1 (Behavioural) was adopted as the working definition because Definition 2 loyal customers showed 100% promo dependency — meaning they are high spenders driven by incentives, not genuine loyalty.

---

## SQL Segmentation

Five queries were written to answer specific business questions:

| Query | Business Question |
|---|---|
| Query 1 | Who are genuinely loyal customers vs discount hunters? |
| Query 2 | What behavioural patterns predict high customer value? |
| Query 3 | Which geographies signal organic vs discount-driven demand? |
| Query 4 | Which categories and seasons attract high-tenure customers? |
| Query 5 | What does the brand's ideal customer profile look like? |

---

## Exploratory Data Analysis

EDA was conducted across five dimensions:

- **Value distribution** — how customers are spread across Low, Medium, High, and Premium tiers
- **Promo dependency by tier** — whether higher-value customers are more or less discount-driven
- **Loyalty rate analysis** — what separates the 16.1% loyal segment from the rest
- **Generational breakdown** — spend, frequency, and promo behaviour by age cohort
- **Geographic patterns** — state-level variance in organic vs promo-dependent purchasing

---

## Dashboard (Power BI)

Four-panel founder dashboard built to answer the core retention question at a glance:

1. **Customer Pyramid** — value tier distribution across the full base
2. **Promo Dependency vs Loyalty Rate** — by value tier, showing the inverse relationship
3. **Geographic Opportunity Map** — organic vs discount-driven demand by state
4. **Average Spend by Category and Season** — where the real revenue comes from

---

## Retention Playbook Summary

**Promotional Sunset Plan:**
- Stop discounts for the Genuinely Loyal segment immediately — they never used them anyway
- Pilot the rollout in Fall (lowest promo dependency season) starting with Arizona, Tennessee, and Texas
- 4-phase execution over 12 months across all tiers and geographies
- Success metric: % revenue without promo codes below 30% within 12 months

**Ideal Customer Profile:**
- Age: Boomer (55+)
- Category: Clothing
- Season: Spring & Fall
- Payment: Cash or Credit Card
- Promo Dependency Score: 0.00 — never uses discounts
- Purchase History: 37+ previous purchases

---

## Tools Used

| Tool | Purpose |
|---|---|
| Python (Pandas, Matplotlib, Seaborn) | Data cleaning, feature engineering, EDA |
| MySQL | Customer segmentation queries |
| Power BI Desktop | Founder dashboard |
| Jupyter Notebook | Analysis environment |

---

## Dataset

3,900 customers · 18 original features · 28 features after engineering · No timestamps · No churn labels · Fully derived from transactional and behavioural data
