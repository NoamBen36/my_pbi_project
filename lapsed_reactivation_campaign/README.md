# Lapsed Reactivation Campaign – Power BI Dashboard Documentation

## 1. Overview

This dashboard analyzes the performance of a **lapsed player reactivation campaign** targeting players with **no purchase activity for at least 12 months**.

Two promotional mechanics were tested:
- **Free Spins on Deposit (FS)** – minimum deposit €10
- **100% Match Bonus (MU)** – minimum deposit €20

The dashboard is split into **two pages**:
1. **Conversion & Reactivation (high level)**
2. **Revenue & Value (financial view)**

Attribution window for all analyses: **14 days after email delivery**.

---

## 2. Page 1 – Conversion & Reactivation

### Purpose
Provide a **high-level, executive view** of campaign performance:
- How many players were reactivated
- How efficiently each offer converted
- How fast players reacted after the promotion went live

---

### 2.1 Key KPIs

| KPI | Definition |
|---|---|
| Players Reactivated | Distinct players who made at least one deposit within the attribution window |
| Offer Targeted | Number of players included in the target list for the selected offer |
| Offer Take-Up | Reactivated players / Targeted players |

**Note:**  
Take-up is always calculated using **Targeted players** as the denominator (not Delivered or Opened).

---

### 2.2 Conversion Funnel

**Funnel steps:**
1. Targeted
2. Email Delivered (non-bounced)
3. Email Opened
4. Email Clicked
5. Deposited

**Interpretation rules:**
- All steps are reported **relative to the original targeted population**
- Deposited conversion rate = Deposited / Targeted
- Clicked step may appear small and should be interpreted via CTR (tooltip)

**Assumptions:**
- Only one campaign email per player
- Email bounce events are excluded from Delivered, Opened, and Clicked

---

### 2.3 Take-Up by Day (Cohort View)

This visual shows **when** players reacted after the promotion started.

Cohorts:
- D+0
- D+1
- D+3
- D+7
- D+14

These cohorts are **cumulative**:
- D+7 includes all deposits from D+0 to D+7
- D+14 represents the full attribution window

**Purpose:**
- Compare reactivation speed between offers
- Identify early vs delayed engagement patterns

---

### 2.4 Offer Toggle

The page can be filtered to a **single offer**:
- Free Spins on Deposit
- 100% Match Bonus

This updates all KPIs, funnel steps, and cohort visuals consistently.

---

## 3. Page 2 – Revenue & Value

### Purpose
Evaluate the **financial quality** of the reactivation:
- Deposit volume
- Player quality
- Estimated promotional cost
- Net contribution (proxy)

---

### 3.1 Revenue KPIs

| KPI | Definition |
|---|---|
| Total Deposit | Sum of deposits within attribution window |
| Deposit Count | Total number of deposit transactions |
| Avg Deposit | Total Deposit / Deposit Count |
| Active (1 deposit) | Players with exactly one deposit |
| Multi-Active (2+) | Players with two or more deposits |

---

### 3.2 Bonus Cost Assumption

**Key assumption (documented):**

> The promotional bonus cost is applied **once per redeemer**, assuming the offer is redeemed on a **single eligible deposit** (first eligible deposit) within the attribution window.

- Additional deposits are considered **incremental** and do not generate extra bonus cost.

Estimated bonus cost per redeemer is defined in the offer dimension.

---

### 3.3 Net Contribution & ROI (Proxy)

Because only deposit data is available, the following **proxy metrics** are used:

- **Estimated Bonus Cost**  
  Redeemers × Estimated cost per redeemer

- **Net Contribution (proxy)**  
  Total Deposit − Estimated Bonus Cost

- **ROI (proxy)**  
  Net Contribution / Estimated Bonus Cost

These metrics are directional and should not be interpreted as full financial ROI (no NGR, fees, or holdout baseline included).

---

### 3.4 Revenue Breakdown

- Deposit contribution by offer (donut)
- Daily deposit trend (time series)
- Player-level table for audit and exploration:
  - Player ID
  - Offer opted in
  - Lapsed days
  - Total deposit amount
  - Deposit count

---

## 4. Data Model Summary

### Main Tables
- **dim_target_list** – campaign target population
- **fact_email_send** – email delivery and interaction events
- **fact_deposit** – deposit transactions (within attribution window)
- **dim_offer** – offer mechanics and estimated cost

### Relationships
- Player-level relationships between target list, email events, and deposits
- Offer-level relationships via offer identifiers
- Single-direction filters from dimensions to facts

---

## 5. Key Assumptions & Limitations

- No control group / holdout → results are **not incremental**
- Revenue is based on **deposit amounts only**
- No geographic or regulatory segmentation included
- Attribution window fixed at 14 days
- Bonus costing is estimated, not actual

---

## 6. Intended Audience

- CRM / Lifecycle Marketing
- Product & Commercial teams
- Management & Stakeholders (executive overview)

---

## 7. Recommended Next Steps

- Add holdout group for incrementality
- Extend analysis to post-reactivation LTV
- Replace deposit-based proxy with NGR when available
