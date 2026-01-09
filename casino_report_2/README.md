# Online Gaming Analytics Dashboards (Casino + Sportsbook) — Power BI Portfolio Project

This repository contains a portfolio-style analytics project built in **Power BI** using **synthetic (dummy) data** to simulate an online gaming operator with two product lines:
- **Casino** (spins, games, providers, categories)
- **Sportsbook** (bets, markets, events, odds, open vs settled)

The goal is to demonstrate **data modeling**, **DAX patterns**, and **domain-specific KPIs** commonly used in iGaming / sports betting analytics — for learning, training, and sharing.

> ⚠️ **Disclaimer:** All datasets are synthetic. No real customer, operator, or proprietary data is used.

---

## Highlights

### ✅ What this project demonstrates
- Star-schema / dimensional modeling (facts + dimensions)
- Separate analytics approach for **Casino** vs **Sportsbook** (different mechanics & KPIs)
- Core revenue logic (e.g., **GGR = Stake − Payout**)
- Time intelligence patterns (MTD / YTD / YoY, Previous period comparisons)
- User profiling with a derived table (purchase/deposit behaviour)
- Dashboard design for both:
  - Executive overview KPIs
  - Deep-dive operational analytics

---

## Dashboards Included

### 1) Casino Revenue Dashboard
Key topics:
- Stake, Payout, **GGR**, **Net ARPU**
- **RTP** (Actual payout ratio)
- Bonus vs Purchases (promo cost)
- Trends and country breakdowns

### 2) Casino Metrics & Trends
- MTD vs Previous MTD comparisons
- YTD comparisons
- Purchase & bonus trends
- Stake vs payout time series

### 3) Casino Games & Users
- Users / Stake / Spins by category
- Top games
- Gameplay metrics by user
- Purchase segment slicers (e.g., 0–100, 100–500, 500+)

> Note: Sportsbook dashboards are maintained as a separate section due to different revenue mechanics (open bets, exposure/liability, settlement timing).

---

## Data Model

### Core Facts
- `casino_fact_spin` — casino betting activity at spin level  
- `sports_fact_bet` — sportsbook bets (open/settled)  
- `wallet_fact_purchase` — deposits/purchases (funding events)

### Shared Dimensions
- `shared_dim_user` — synthetic users (name, segment, geo mapping)
- `shared_dim_geo` — globalised geography (country/region)
- `dim_calendar` — custom date table (DateKey, YearMonth, YearWeek, etc.)

### Casino Dimensions
- `casino_dim_game`, `casino_dim_category`, `casino_dim_provider`

---

## Key KPIs (iGaming definitions)

### Casino
- **Stake Amount** = total wagered amount  
- **Payout Amount** = winnings returned to players  
- **GGR (Gross Gaming Revenue)** = Stake − Payout  
- **RTP (Return to Player)** = Payout / Stake  
- **Active Users** = distinct users with ≥1 spin in the selected period  
- **ARPU (Net)** = GGR / Active Users

### Sportsbook (conceptual)
- **Realised Revenue** = settled GGR only  
- **Exposure / Liability** = potential payout on open bets  
- Open vs Settled bet handling is essential for correct KPIs

---

## DAX Patterns Used

This repo includes reusable DAX patterns such as:
- **MTD / Previous MTD**
- **YTD / Previous YTD**
- Ratio best practices (aggregate components → then divide)
- Dynamic Top-N users (RANKX + ALLSELECTED)
- Time-series friendly calendar keys (YearMonth, YearWeek)

> Tip: For ratios like ARPU, the correct pattern is:
> **ARPU MTD = (GGR MTD) / (Active Users MTD)**  
> not `TOTALMTD(ARPU)`.

---

## How to Use

1. Download the `.pbix` (or load the CSVs if provided).
2. Ensure relationships are set:
   - `dim_calendar[DateKey]` → fact `[..._date_id]`
   - `shared_dim_user[user_id]` → facts `user_id`
3. Mark `dim_calendar` as a Date table.
4. Refresh and explore dashboards.

---

## Portfolio Notes / Assumptions

- All numbers are synthetic and designed for analytics practice.
- Bonus amounts are treated as **promotional cost** and linked to wallet purchases (funding), not directly to stake at spin level.
- Negative GGR and RTP > 100% can occur over short periods due to variance — this is realistic in casino operations.

---

## Screenshots
_Add screenshots of your key pages here (recommended for LinkedIn)._

---

## License
This project is shared for learning and demonstration purposes.
