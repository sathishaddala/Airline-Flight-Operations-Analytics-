# ✈️ Airline Flight Operations Analytics Platform

**End-to-End Data Engineering Project | Databricks | Lakeflow Spark Declarative Pipelines | SQL**

Transforming raw airline flight data into clean, reliable and business-ready insights.

---

## 📌 Project Overview

The Airline Flight Operations Analytics Platform is an end-to-end Data Engineering project built on Databricks using Lakeflow Spark Declarative Pipelines.

It processes raw domestic airline flight data (India, 2025) through the **Medallion Architecture** (Bronze, Silver, Gold), applies data cleansing and quality checks, and produces business-ready tables that power an interactive AI/BI dashboard.

The outputs help analyze airline performance, flight delays, passenger trends, route performance and ticket revenue.

## 🎯 Project Objectives

- Build a structured data pipeline using Medallion Architecture.
- Ingest raw airline flight data into the Bronze layer.
- Clean and validate records in the Silver layer.
- Identify and separate rejected records.
- Generate aggregated business insights in the Gold layer.
- Implement data-quality checks and reconciliation.
- Build interactive dashboards for operational analysis.

---

## 🏗️ Data Architecture

![Medallion Architecture](Images/Medallion_View_png.png)

### Data Flow

```
        Raw Airline CSV Data
                 |
                 ▼
         BRONZE LAYER
        Raw Data Ingestion
                 |
                 ▼
         SILVER LAYER
     Data Cleaning & Validation
            /         \
           ▼           ▼
    Clean Records   Rejected Records
           |
           ▼
          GOLD LAYER
      Business Aggregations
           |
           ▼
      AI/BI Dashboard
           |
           ▼
      Business Insights
```

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Databricks | Data Engineering Platform |
| Lakeflow Spark Declarative Pipelines | Data Pipeline Development |
| SQL | Data Transformation |
| Medallion Architecture | Data Organization |
| CSV | Source Data Format |
| Databricks AI/BI Dashboards | Data Visualization |
| Git & GitHub | Version Control |

---

## 📂 Project Structure

```
Airline-Flight-Operations-Analytics-/
│
├── DASHBOARD/
│   ├── Executive_Overview.png
│   ├── Airlines__Routes___Delays.png
│   └── Data_Quality___Reconciliation__2_.png
│
├── Data/
│   └── airline_flights_raw.csv
│
├── ETL_PIPELINE/
│   ├── Bronze_Flight/
│   │   └── Bronze_Flight_Layer/
│   │       └── Bronze_transformations/
│   │           └── Bronze_my_transformation.sql
│   │
│   ├── Silver_Flight/
│   │   └── Silver_Flight_Layer/
│   │       └── Silver_transformations/
│   │           └── Silver_my_transformation.sql
│   │
│   └── Gold_Flight/
│       └── Gold_Flight_layer/
│           └── Gold_transformations/
│               └── Gold_my_transformation.sql
│
├── Images/
│   ├── Medallion_View_png.png
│   └── catalog_structure_png_png.png
│
└── README.md
```

---

## 📥 Source Data

**File:** `airline_flights_raw.csv` (1,365 rows, 20 columns)

| Group | Columns |
|---|---|
| Flight | `flight_id`, `flight_number`, `flight_date`, `day_of_week` |
| Airline & Aircraft | `airline`, `aircraft_id`, `aircraft_type` |
| Route | `origin_city`, `destination_city`, `origin_region`, `distance_km` |
| Timing & Delay | `scheduled_departure`, `actual_departure`, `delay_minutes`, `delay_reason` |
| Capacity & Revenue | `seat_capacity`, `passengers`, `avg_fare`, `ticket_revenue`, `fuel_cost` |

---

## ⚙️ Data Engineering Workflow

### 🥉 1. Bronze Layer: Raw Data Ingestion

**Table:** `bronze_airline_flights` (Streaming Table)

- Reads CSV files from the Databricks Volume.
- Preserves the original source columns.
- Captures source file information.
- Adds ingestion timestamps.
- Keeps raw data intact for downstream processing.

### 🥈 2. Silver Layer: Data Cleaning & Transformation

**Tables (Materialized Views):** `silver_flights_clean`, `silver_flights_rejected`

Key transformation rules:

- Remove duplicate records using `flight_id`.
- Standardize text fields using trimming and proper capitalization.
- Handle missing airline and delay-reason values.
- Calculate missing delay durations from scheduled and actual departure timestamps.
- Calculate missing ticket revenue from passengers and average fare.
- Identify invalid passenger counts (overbooked flights) and negative ticket fares.
- Separate rejected records with appropriate rejection reasons.
- Classify flights based on delay duration.

**Delay Classification**

| Delay Duration | Category |
|---|---|
| 0–15 minutes | On Time |
| 16–60 minutes | Minor Delay |
| Above 60 minutes | Major Delay |

### 🥇 3. Gold Layer: Business Analytics

All Gold tables are Materialized Views built from the Silver layer.

| Gold Table | Business Purpose | Output Records |
|---|---|---|
| `gold_monthly_flights` | Monthly flight and revenue trends | 12 |
| `gold_airline_summary` | Airline performance analysis | 6 |
| `gold_route_summary` | Route-level performance | 90 |
| `gold_delay_summary` | Flight delay analysis | 13 |
| `gold_data_quality` | Data quality and reconciliation metrics | 1 |

### 🔗 Pipeline Lineage

The Lakeflow pipeline graph in the architecture image above shows `bronze_airline_flights`, `silver_flights_clean` and `silver_flights_rejected` feeding the five Gold materialized views.

---

## 📊 Data Quality & Reconciliation

The pipeline evaluates duplicates, missing values, overbooked flights, negative fares and other data-quality conditions.

### Data Processing Results

| Metric | Records |
|---|---|
| Bronze Records | 1,365 |
| Duplicate Records | 25 |
| Clean Records | 1,321 |
| Rejected Records | 19 |

### Data-Quality Issues Detected

| Issue | Rows Affected |
|---|---|
| Duplicate Flights | 25 |
| Missing Delay Minutes | 18 |
| Missing Ticket Revenue | 16 |
| Missing Delay Reason | 12 |
| Missing Airline | 11 |
| Overbooked Flights | 11 |
| Negative Fare | 8 |

### Reconciliation Check

```
Bronze Records = Clean Records + Rejected Records + Duplicate Records
1,365          = 1,321         + 19               + 25
```

**Reconciliation Status: PASSED ✅**

---

## 📈 Dashboard & Business Insights

The project includes three dashboard pages that give a complete view of airline operations.

### 1. Executive Overview

![Executive Overview](DASHBOARD/Executive_Overview.png)

Focus areas:

- Total flights (1.32K), total passengers (172.03K)
- Total ticket revenue (₹118.17 Crores)
- Delayed flights (419)
- Monthly ticket revenue trend for 2025
- On-time performance by airline
- Flights by delay category
- Filters for flight month and airline

### 2. Airline, Route & Delay Performance

![Airlines, Routes & Delays](DASHBOARD/Airlines__Routes___Delays.png)

Focus areas:

- Airline scorecard: flights, passengers, ticket revenue, load factor %, on-time %, average delay
- Top 10 routes by ticket revenue
- Flights by delay category
- Delayed flights by reason (Weather, Air Traffic, Technical, Late Arrival, Crew)
- Filters for airline, origin city and destination city

### 3. Data Quality Monitoring & Reconciliation

![Data Quality & Reconciliation](DASHBOARD/Data_Quality___Reconciliation__2_.png)

Focus areas:

- Bronze, clean, rejected and duplicate record counts
- Rows affected by each data-quality issue
- Reconciliation status across Bronze → Silver → Gold

---

## 🗂️ Databricks Catalog Structure

| Item | Name |
|---|---|
| Catalog | `airline_catlog` |
| Schema | `default` |
| Volume | `airline_flights_volume` |

Tables (8): `bronze_airline_flights`, `silver_flights_clean`, `silver_flights_rejected`, `gold_monthly_flights`, `gold_airline_summary`, `gold_route_summary`, `gold_delay_summary`, `gold_data_quality`

![Databricks Catalog Structure](Images/catalog_structure_png_png.png)

---

## 🚀 How to Run the Project

1. Create a catalog named `airline_catlog`.
2. Use the `default` schema (or create your own schema).
3. Create a volume named `airline_flights_volume`.
4. Upload `airline_flights_raw.csv` into the volume.
5. Import the Bronze, Silver and Gold SQL transformation files into Databricks.
6. Configure the Lakeflow Spark Declarative Pipelines workflow with the required transformations.
7. Run the pipeline and validate the Bronze, Silver and Gold tables.
8. Verify the data-quality reconciliation results.
9. Connect the Gold tables to the dashboard and review the analytical outputs.

---

## 💡 Key Learnings

- Building data pipelines in Databricks.
- Implementing Medallion Architecture.
- Working with Lakeflow Spark Declarative Pipelines (streaming tables and materialized views).
- Writing SQL transformations.
- Performing data cleaning and validation.
- Handling duplicates and rejected records.
- Implementing data-quality checks and reconciliation.
- Creating business-ready Gold tables.
- Developing dashboards for operational insights.
- Managing project code using Git and GitHub.

## 🔮 Future Enhancements

- Automate scheduled data ingestion.
- Integrate real-time flight data sources.
- Implement advanced delay prediction models.
- Add automated pipeline monitoring and alerting.
- Extend analytics with additional operational KPIs.

---

## 👨‍💻 Author

**Sathish Addala**

Aspiring Data Engineer | Data Analytics | SQL | Databricks | ETL

📌 GitHub: [sathishaddala](https://github.com/sathishaddala)
💼 LinkedIn: [Sathish Addala](https://www.linkedin.com/in/sathish-addala-9730492b2)

⭐ If you find this project interesting, consider giving this repository a star!

*Built with curiosity, continuous learning and a passion for Data Engineering.*
