# Casino Analytics Dashboard — Revenue & User Performance

This project is a **Power BI analytics dashboard** built on **synthetic casino data**, designed to simulate how an online gaming operator monitors revenue, users, and product performance.

The goal of this report is to demonstrate:
- casino-specific KPIs and business logic
- clean dimensional modeling
- robust DAX patterns for time intelligence and ratios
- dashboard design for both executive and analytical use cases

> ⚠️ Disclaimer  
> All data used in this project is fully synthetic.  
> No real users, operators, or proprietary information are involved.

---

## Business Scope

**Product:** Online Casino  
**Granularity:** Spin-level activity  
**Audience:** Product, Commercial, Analytics

This dashboard focuses on:
- Revenue generation (GGR)
- Player activity and value
- Bonus and promotional cost
- Game and category performance

Sports betting is intentionally excluded, as casino and sportsbook require different analytical approaches.

---

## Dashboards & Pages

### 1) Casino Revenue Overview
- Stake Amount
- Payout Amount
- **GGR (Stake − Payout)**
- Net ARPU
- RTP (Return to Player)
- Bonus vs Purchase overview
- Country-level revenue breakdown

### 2) Casino Metrics & Trends
- MTD vs Previous MTD KPIs
- YTD comparisons
- Stake vs Payout trends
- Purchase & bonus evolution over time

### 3) Casino Games & Users
- Active users by product category
- Stake / Spins / Users toggles
- Top-performing games
- User-level gameplay metrics
- Lifetime purchase segmentation

---

## Data Model Overview

### Fact Tables
- `casino_fact_spin` — spin-level betting activity
- `wallet_fact_purchase` — user deposits / purchases

### Dimension Tables
- `shared_dim_user` — synthetic users
- `shared_dim_geo` — country & region
- `dim_calendar` — custom calendar table
- `casino_dim_game`, `casino_dim_category`, `casino_dim_provider`

A derived analytical table is used for **user purchase profiling** (lifetime deposits, average deposit size, segments).

---

## Key KPI Definitions

- **Stake Amount**: Total amount wagered by players
- **Payout Amount**: Total winnings paid to players
- **GGR (Gross Gaming Revenue)**: Stake − Payout
- **RTP (Return to Player)**: Payout / Stake
- **Active Users**: Distinct users with ≥1 spin in the selected period
- **Net ARPU**: GGR / Active Users
- **Bonus Amount**: Promotional cost (not directly linked to stake)

> Note: Bonus amounts are treated as promotional expense and are linked to wallet purchases, not directly to spins.

---

## DAX Patterns Used

- MTD / Previous MTD
- YTD / Previous YTD
- YoY comparisons
- Ratio best practices (aggregate first, divide last)
- Dynamic Top-N users using `RANKX` + `ALLSELECTED`
- Custom date intelligence using a dedicated calendar table

---

## How to Explore

1. Open the Power BI report (`.pbix`).
2. Use slicers for date, geography, and user segments.
3. Explore KPIs at both high-level and user/game level.

---

## Portfolio Notes

This project is designed as a **learning and portfolio artifact**:
- business logic is simplified but realistic
- modeling choices are documented and intentional
- negative GGR and RTP > 100% can occur due to variance

---

## Screenshots
To be added

---

## License
Shared for educational and demonstration purposes only.
