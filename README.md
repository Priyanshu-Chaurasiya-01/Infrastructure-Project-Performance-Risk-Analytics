# Infrastructure Project Performance & Risk Analytics

An end-to-end **data analytics and business intelligence project** for monitoring infrastructure project performance across **cost, schedule, progress, contractors, risks, milestones, and payments**.

The project demonstrates a complete analytics workflow using **Excel → Python → MySQL → Power BI**, turning multi-table project data into management-oriented KPIs, risk indicators, and project-priority insights.

---

## 📌 Project Overview

Infrastructure projects are exposed to multiple execution risks: **budget overruns, schedule delays, slow progress, contractor performance issues, operational risks, and payment constraints**.

This project builds an analytical framework to answer questions such as:

- Which projects are delayed or over budget?
- Which projects have both **cost overruns and negative progress gaps**?
- Which regions and project types carry greater execution exposure?
- Which contractors show higher historical delay or lower performance ratings?
- What are the major risk categories and their current statuses?
- How many milestones are delayed, and by how much?
- Which ongoing projects require management attention?

---

## 🎯 Business Objectives

1. Monitor **project execution performance**
2. Identify **budget overruns and cost pressure**
3. Measure **planned vs. actual progress**
4. Track **milestone delays**
5. Evaluate **contractor performance**
6. Analyze **project risk exposure**
7. Monitor **payment/disbursement activity**
8. Create a management-oriented **Power BI dashboard**
9. Develop a reusable analytical pipeline from raw data to business insights

---

## 🏗️ Project Architecture

```text
Raw Data
   │
   ▼
Excel Inspection & Initial Cleaning
   │
   ▼
Python / Pandas
   ├── Data Cleaning
   ├── Validation
   ├── Feature Engineering
   └── Exploratory Data Analysis
   │
   ▼
Cleaned & Processed CSVs
   │
   ▼
MySQL
   ├── Relational Analysis
   ├── Joins
   └── KPI / Business Queries
   │
   ▼
Power BI
   ├── KPI Dashboard
   ├── Project Performance
   ├── Milestones
   ├── Risks
   ├── Payments
   └── Contractor Analysis
```

---

## 🛠️ Tech Stack

| Technology                     | Purpose                                                     |
| ------------------------------ | ----------------------------------------------------------- |
| **Microsoft Excel**      | Initial inspection, auditing and spreadsheet-based cleaning |
| **Python**               | Data cleaning, validation, feature engineering and EDA      |
| **Pandas / NumPy**       | Data transformation and analytical calculations             |
| **Matplotlib / Seaborn** | Exploratory visual analysis                                 |
| **MySQL**                | Relational analysis, joins and business queries             |
| **Power BI**             | Interactive dashboard and management reporting              |

---

## 📂 Dataset

The project contains five related datasets.

| Dataset                      | Records | Purpose                                |
| ---------------------------- | ------: | -------------------------------------- |
| **Projects**           |     252 | Core project-level performance         |
| **Contractors**        |      12 | Contractor experience and performance  |
| **Project Milestones** |   1,376 | Planned vs. actual milestone execution |
| **Risks**              |     696 | Risk probability, impact and status    |
| **Payments**           |   1,633 | Project payment/disbursement activity  |

### Core Project Fields

- `Project_ID`
- `Project_Name`
- `Project_Type`
- `Region`
- `Start_Date`
- `Planned_End_Date`
- `Actual_End_Date`
- `Planned_Budget_Cr`
- `Actual_Cost_Cr`
- `Planned_Progress_Pct`
- `Actual_Progress_Pct`
- `Contractor_ID`
- `Status`

Financial values are expressed in **₹ Crore (Cr)**.

---

# 🔄 Data Preparation

## 1. Excel

Initial inspection and cleaning included:

- Duplicate identification
- Text/category standardization
- String trimming and category standardization
- Basic data-type checks
- Workbook-level auditing

## 2. Python Data Cleaning

The Python cleaning notebooks perform table-level transformations such as:

- Duplicate removal using business keys
- Date parsing
- Missing-value handling
- Basic consistency checks
- Relationship-based enrichment
- Clean CSV generation

## 3. Python Feature Engineering

### Cost Overrun

```text
Cost Overrun = Actual Cost - Planned Budget
```

Classification:

- **Under Budget**
- **Exact Budget**
- **Exceeding Budget**

### Progress Gap

```text
Progress Gap = Actual Progress % - Planned Progress %
```

Progress risk is classified using the size of the negative gap:

| Progress Gap | Risk     |
| -----------: | -------- |
|        ≥ 0% | Low      |
|         < 0% | Medium   |
|       < -10% | High     |
|       < -20% | Critical |

### Milestone Delay

```text
Milestone Delay = Actual Date - Planned Date
```

Categories:

- **On Time**
- **Minor Delay**: 10–24 days
- **Major Delay**: 25–39 days
- **Extreme Delay**: 40+ days

### Contractor Segmentation

Contractors are segmented using:

- Performance rating
- Experience years
- Average delay days

---

# 📊 Key KPIs

The dashboard and SQL analysis focus on:

### Project Performance

- Total projects
- Completed projects
- Ongoing projects
- Delayed projects
- At-risk projects
- On-hold projects
- Projects with negative progress gaps

### Financial

- Total planned budget
- Total actual cost
- Total cost overrun
- Overall overrun percentage
- Number of over-budget projects

### Schedule

- Delayed projects
- Average project delay
- Delayed milestones
- Average milestone delay
- Extreme milestone delays

### Contractor

- Performance rating
- Average delay days
- Experience
- Performance category
- Delay category

### Risk

- High / Very High probability risks
- High / Critical impact risks
- Open risks
- Mitigated risks
- Risk distribution by type, project type and region

### Management Attention

A project is flagged as **Critical Attention** when it simultaneously has:

```text
Actual Cost > Planned Budget
AND
Actual Progress < Planned Progress
```

This provides a simple executive escalation indicator.

---

# 🔎 Key Findings from the Current Processed Dataset

The following figures are calculated from the processed CSVs included in this repository.

### Project Portfolio

- **252 projects** across **6 regions**
- **8 project types**
- 83 Completed
- 74 Ongoing
- 61 Delayed
- 25 At Risk
- 9 On Hold

### Financial Exposure

- Planned budget: **₹22,881.97 Cr**
- Actual cost: **₹23,929.34 Cr**
- Total cost overrun: **₹1,047.37 Cr**
- Portfolio-level overrun: **4.58%**
- **159 of 252 projects** are above planned budget

### Progress Exposure

- **129 projects** have negative progress gaps
- **71 projects** fall into the Critical progress-risk category
- **77 projects** simultaneously have a cost overrun and negative progress gap

These 77 projects represent the strongest candidates for management review under the project's escalation rule.

### Milestones

- **1,376 milestones**
- 1,011 records have a calculated milestone delay
- Average recorded milestone delay: **22.2 days**
- 878 milestones are delayed by more than 0 days
- Maximum recorded milestone delay: **80 days**

### Risk Portfolio

- **696 risk records**
- 346 risks have High / Very High probability
- 346 risks have High / Critical impact
- Risk types include:
  - Regulatory
  - Environmental
  - Safety
  - Schedule
  - Financial
  - Land Acquisition
  - Supply Chain
  - Technical

### Payment Activity

- **1,633 payment records**
- Total recorded payment amount: approximately **₹12,262.72 Cr**
- Payment statuses include Approved, Partially Paid, Pending, On Hold and Paid.

---

# 🧠 Analytical Questions Addressed

The MySQL analysis includes queries for:

### 1. Delayed Projects

Identifies projects currently marked as delayed.

### 2. Budget Overruns

Calculates the amount by which actual cost exceeds planned budget.

### 3. Contractor Performance

Identifies contractors with:

- Below-average performance rating
- Above-average average delay

### 4. High-Risk Project Types

Aggregates projects associated with high probability or high-impact risks.

### 5. Regional Delays

Compares regions using project delay and delayed-project counts.

### 6. Cost Overrun Drivers

Examines cost overruns by:

- Project type
- Contractor rating tier
- High-impact risk exposure

### 7. Management Attention

Creates an attention classification:

```text
Critical Attention
        ↓
Cost Overrun + Negative Progress Gap

Needs Attention
        ↓
Cost Overrun OR Negative Progress Gap

Normal
        ↓
Neither condition
```

---

# 📈 Power BI Dashboard

The Power BI solution is organized into multiple analytical pages covering:

1. **Project Performance Dashboard**
2. **Contractor Analysis**
3. **Project Milestone Analysis**
4. **Payment Analysis**
5. **Risk Analysis**

The dashboard supports interactive exploration using project, region, project type, contractor, status and risk dimensions.

# 📁 Repository Structure

```text
Infrastructure Project Performance & Risk Analytics/
│
├── Data/
│   ├── Raw/
│   │   ├── Raw_Projects.csv
│   │   ├── Raw_Contractors.csv
│   │   ├── Raw_ProjectMilestones.csv
│   │   ├── Raw_Risks.csv
│   │   └── Raw_Payments.csv
│   │
│   ├── Cleaned/
│   │   ├── Projects.csv
│   │   ├── Contractors.csv
│   │   ├── ProjectMilestones.csv
│   │   ├── Risks.csv
│   │   └── Payments.csv
│   │
│   └── Processed/
│       ├── Projects.csv
│       ├── Contractors.csv
│       ├── ProjectMilestones.csv
│       ├── Risks.csv
│       └── Payments.csv
│
├── Excel/
│   ├── 1_Projects.xlsx
│   ├── 2_Contractors.xlsx
│   ├── 3_ProjectMilestones.xlsx
│   ├── 4_Risks.xlsx
│   └── 5_Payments.xlsx
│
├── Python/
│   ├── Data_Cleaning/
│   │   ├── 1_Projects.ipynb
│   │   ├── 2_Contractors.ipynb
│   │   ├── 3_ProjectMilestones.ipynb
│   │   ├── 4_Risks.ipynb
│   │   └── 5_Payments.ipynb
│   │
│   └── Data_Analysis/
│       ├── 1_Projects.ipynb
│       ├── 2_Contractors.ipynb
│       ├── 3_ProjectMilestones.ipynb
│       ├── 4_Risks.ipynb
│       └── 5_Payments.ipynb
│
├── MySQL/
│   └── Query.sql
│
├── PowerBI/
│   └── Dashboard.pbix
│
├── Screenshots/
│   ├── Dashboard Page 1.png
│   ├── Contractors Page 2.png
│   ├── ProjectMilestones Page 3.png
│   ├── Payments Page 4.png
│   └── Risks Page 5.png
│
└── README.md
```

---

# 🧪 Data Quality & Assumptions

The project includes a data-cleaning workflow, but the current processed data still contains a few issues that should be considered before production deployment.

### Observed Issues

- Some project, milestone and payment records contain missing values.
- Some milestone records have missing actual dates, so delay cannot be calculated for those records.
- A small number of milestone/payment records reference project IDs that are not present in the Projects table.
- One contractor ID contains whitespace inconsistency, which can affect joins.
- One contractor record has a missing contractor name.
- The risk data contains a small number of non-standard impact values such as `Null` and `Severe`.
- Some project fields were imputed during cleaning, including missing start dates, actual costs and planned end dates.

### Important Analytical Assumption

The cleaning notebooks use business-rule-based imputation where required. For example, missing project actual cost is filled using the dataset median, while missing dates may be derived from related milestone information or average project duration.

These assumptions are suitable for demonstrating an analytics pipeline, but should be **reviewed with domain stakeholders before using the model for real financial or operational decisions**.

---

# 🚀 How to Reproduce the Analysis

### Step 1 — Inspect the Data

Open the Excel workbooks in:

```text
Excel/
```

### Step 2 — Run Python Cleaning

Run the notebooks in:

```text
Python/Data_Cleaning/
```

The cleaned datasets are written to:

```text
Data/Cleaned/
```

### Step 3 — Run Python Analysis

Run:

```text
Python/Data_Analysis/
```

The feature-engineered datasets are written to:

```text
Data/Processed/
```

### Step 4 — Run MySQL Analysis

Import the cleaned/processed project tables into MySQL and execute:

```text
MySQL/Query.sql
```

### Step 5 — Open Power BI

Open:

```text
PowerBI/Dashboard.pbix
```

and refresh the data connections if required.

---

# 💼 Business Value

This project demonstrates how raw infrastructure data can be transformed into a **decision-support system**.

The analytical workflow helps management:

- Detect financial leakage
- Identify schedule and progress issues
- Prioritize projects requiring intervention
- Monitor contractor performance
- Understand risk exposure
- Track milestone execution
- Monitor payment activity
- Move from descriptive reporting toward **risk-based project prioritization**

---

# 🔮 Future Improvements

Potential next steps include:

- Build a formal **Project Risk Score**
- Add **earned value management (EVM)** metrics such as CPI and SPI
- Add project-level schedule variance and forecast completion dates
- Create contractor scorecards with weighted KPIs
- Add payment aging and outstanding-payment analysis
- Introduce automated data-quality checks
- Add time-series monitoring of project progress and payments
- Build predictive models for **cost overrun and delay risk**
- Add Power BI drill-through pages for individual projects
- Automate the ETL pipeline instead of manually running notebooks

---

# 👨‍💻 Skills Demonstrated

**Data Analytics | Data Cleaning | Exploratory Data Analysis | Python | Pandas | NumPy | SQL | MySQL | Excel | Power BI | Data Visualization | KPI Development | Risk Analytics | Project Performance Analytics | Business Intelligence**

---

## ⭐ Project Summary

**Infrastructure Project Performance & Risk Analytics** is a portfolio-ready end-to-end analytics project that demonstrates the complete journey from **raw operational data → cleaned datasets → engineered business metrics → SQL analysis → interactive Power BI reporting**.

The project combines technical data skills with business-oriented analysis to identify **cost, schedule, progress, contractor and risk-related issues** across a portfolio of infrastructure projects.
