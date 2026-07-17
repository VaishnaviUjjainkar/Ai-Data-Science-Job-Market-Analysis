# AI & Data Science Job Market Analysis 📊💼

A comprehensive Data Analytics and Business Intelligence project focused on analyzing global hiring trends, salary structures, workplace preferences, and in-demand skills within the Artificial Intelligence and Data Science employment sectors.

---

## 📌 Project Overview
As companies undergo rapid digital transformation, massive amounts of job-related data are generated daily. This project addresses the challenge of distributed and fragmented career information by engineering an end-to-end analytics pipeline. By collecting, processing, and visualizing thousands of records, it transforms raw job data into structured, actionable business intelligence to aid students, recruiters, and educational institutions.

---

## 🚀 Key Objectives
- **Job Demand Profiling:** Pinpoint the most highly sought-after roles (e.g., Data Analyst, Data Scientist, ML Engineer, Data Engineer).
- **Compensation Mapping:** Analyze salary variations across different geographic locations, experience tiers, and company sizes.
- **Skillset Gap Audit:** Identify the most valuable core competencies (Python, SQL, Machine Learning, Cloud Computing) demanded by modern employers.
- **Work Environment Trends:** Evaluate the macroeconomic shift and operational distribution among Remote, Hybrid, and Onsite working arrangements.

---

## 🛠️ Tech Stack & Dependencies
The data ecosystem relies on a robust combination of industry-standard tools:
- **Data Validation:** Microsoft Excel
- **Programming Language:** Python 3.x (Jupyter Notebook)
- **Data Engineering & Manipulation:** Pandas, NumPy
- **Statistical Visualization:** Matplotlib
- **Database Engine:** MySQL Server (SQL queries for advanced analytical logic)
- **Business Intelligence App:** Power BI Desktop

---

## 🔄 Core Methodology & Pipeline
1. **Data Collection & Ingestion:** Aggregating broad, multi-attribute datasets containing detailed company, country, and job fields.
2. **Preprocessing & Cleaning:** Utilizing Python to handle missing values, drop duplicate logs, and standardize schema data types.
3. **Exploratory Data Analysis (EDA):** Extracting summary statistics, data distributions, and finding multivariable correlations via visual plots.
4. **Relational Staging:** Exporting processed datasets to MySQL for deep-dive filtering, grouping, aggregation, and ranking operations.
5. **Interactive Visualization Canvas:** Linking clean data arrays to a custom Power BI interface loaded with real-time KPI metrics and dashboard filters.

---

## 💻 Sample Database Implementations
The repository relies on standard, performance-optimized relational queries inside MySQL:

### 1. Identify Top 5 Highest-Paying Job Roles
```sql
SELECT job_title, COUNT(*) as total_postings, ROUND(AVG(salary_in_usd), 2) as average_salary
FROM job_market_data
GROUP BY job_title
HAVING total_postings >= 10
ORDER BY average_salary DESC
LIMIT 5;
```

### 2. Breakdown of Postings & Salaries by Work Mode
```sql
SELECT work_mode, COUNT(*) as total_jobs, ROUND(AVG(salary_in_usd), 2) as avg_salary
FROM job_market_data
GROUP BY work_mode
ORDER BY total_jobs DESC;
```

---

## 📂 Repository Structure
```text
├── Data/                 # Contains raw and preprocessed clean CSV files
├── Notebooks/            # Jupyter Notebook files for data cleaning and EDA scripts
├── SQL_Queries/          # Clean database schemas and strategic business queries
├── Dashboard/            # Power BI (.pbix) visual development templates
└── README.md             # In-depth project documentation
```

---

## ⚙️ How to Run the Project Local Instance

### Step 1: Initialize Dependencies
Install all core libraries using python pip packaging framework:
```bash
pip install pandas numpy matplotlib seaborn mysql-connector-python
```

### Step 2: Clean the Dataset
Run the data cleaning execution blocks located inside the `Notebooks/` directory to prepare your clean data asset pipeline.

### Step 3: Populate the Database Server
Import the resulting CSV dataset files into your active MySQL instance engine using the structured tables defined in the `SQL_Queries/` directory.

### Step 4: Access Dashboard Controls
Launch **Power BI Desktop**, open the configuration template inside `Dashboard/`, and link your system query data tables to enable full slicing functionality.

## 📜 License & Usage Rights
This project was compiled to fulfill the structural guidelines of a master's academic submission and hybrid corporate internship expectations. All rights regarding visualization frames, reporting models, and pipeline configurations belong to the original developer and authorized stakeholders.


