## Player Retention & Activity Analysis

This report focuses on **player lifecycle analytics**, with a specific emphasis on **retention, activity, and engagement patterns**.

Using synthetic data, the dashboard answers three core questions:
- How many new players are acquired over time?
- How many players remain active, and how engaged are they?
- How does retention evolve across cohorts after player acquisition?

---

### Key Concepts

**Cohort-based Retention**
Players are grouped by their **open month** (cohort).  
Retention is measured as the percentage of players from each cohort who remain active in subsequent months.

- **Month 0 = 100%** (cohort size at acquisition)
- **Month N** = players with at least one activity in month N after opening

This approach provides a clear and comparable view of player retention over time.

---

### Activity Segmentation

Players are segmented based on their **lifetime activity**:
- **Single-Active Players**: exactly one activity
- **Multi-Active Players**: two or more activities

This segmentation helps distinguish between one-time users and more engaged players.

---

### Key Metrics Included
- New Players (by open month)
- Unique Active Players (by activity month)
- Single-Active vs Multi-Active players
- Monthly cohort retention matrix

---

### Dataset Notes

All data used in this report is **fully synthetic** and generated for educational and portfolio purposes.
The structure and metrics are designed to reflect realistic online gaming / betting use cases, without using any real user or operator data.
