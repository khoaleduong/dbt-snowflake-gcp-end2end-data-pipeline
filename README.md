# dbt-snowflake-gcp-end2end-data-pipeline
## 1. Overview
This project implements an end-to-end ETL pipeline for Airbnb data using **GCP**, **Snowflake**, and **dbt**. It processes raw listings, bookings, and hosts data through **Medallion Architecture** (Bronze -> Silver -> Gold), demonstrating best practices in cloud data warehousing and transformation.

**Key features:**
* **Data Modeling:** Incremental loading and SCD Type 2 implementation.
* **Transformation:** Modular SQL modeling and data quality testing via dbt.
* **Infrastructure:** Scalable analytics-ready datasets on Snowflake powered by GCP ecosystem.

## 2. Architecture
### Data Flow

```text
Source Data (CSV) → Google Cloud Storage (GCS) → Snowflake (Staging) → Bronze Layer → Silver Layer → Gold Layer
                                                                          ↓              ↓              ↓
                                                                      Raw Tables    Cleaned Data    Analytics

```

### Tech Stack
* **Cloud Data Warehouse**: Snowflake
* **Transformation Layer**: dbt (Data Build Tool)
* **Cloud Storage**: Google Cloud Storage (GCS)
* **Version Control**: Git
* **Python**: 3.10+
* **Key dbt Features**:
  * Incremental models
  * Snapshots (SCD Type 2)
  * Custom macros
  * Jinja templating
  * Testing and documentation

## 3. Data Model

### **Medallion Architecture**

**Bronze Layer (Raw Data)**

Raw data ingested from staging with minimal transformations:
* `bronze_bookings` - Raw booking transactions
* `bronze_hosts` - Raw host information
* `bronze_listings` - Raw property listings

**Silver Layer (Cleaned Data)**

Cleaned and standardized data:

* `silver_bookings` - Validated booking records
* `silver_hosts` - Enhanced host profiles with quality metrics
* `silver_listings` - Standardized listing information with price categorization

**Gold Layer (Analytics-Ready)**

Business-ready datasets optimized for analytics:

* `obt (One Big Table)` - Denormalized fact table joining bookings, listings, and hosts
* `fact` - Fact table for dimensional modeling
* Ephemeral models for intermediate transformations

### **Snapshots (SCD Type 2)**

Slowly Changing Dimensions to track historical changes:

* `dim_bookings` - Historical booking changes
* `dim_hosts` - Historical host profile changes
* `dim_listings` - Historical listing changes

## 4. Project structure
```bash
dbt_snowflake_gcp/
├── README.md                           # Project documentation
├── pyproject.toml                      # Python dependencies (Poetry/Pip)
├── main.py                             # Main execution script for the pipeline
│
├── SourceData/                         # Raw CSV data files (to be loaded to GCS)
│   ├── bookings.csv
│   ├── hosts.csv
│   └── listings.csv
│
├── DDL/                                # Database schema definitions
│   ├── ddl.sql                         # Initial table creation scripts
│   └── resources.sql                   # Snowflake RBAC & warehouse setup
│
└── gcp_dbt_snowflake_project/          # Core dbt transformation project
    ├── dbt_project.yml                 # dbt project configuration
    ├── ExampleProfiles.yml             # Snowflake connection profile template
    │
    ├── models/                         # dbt models (Medallion Architecture)
    │   ├── sources/
    │   │   └── sources.yml             # Data source definitions
    │   ├── bronze/                     # Raw data layer (1:1 with source)
    │   │   ├── bronze_bookings.sql
    │   │   ├── bronze_hosts.sql
    │   │   └── bronze_listings.sql
    │   ├── silver/                     # Cleaned & Transformed data layer
    │   │   ├── silver_bookings.sql
    │   │   ├── silver_hosts.sql
    │   │   └── silver_listings.sql
    │   └── gold/                       # Analytics-ready layer
    │       ├── fact.sql                # Fact tables for BI
    │       ├── obt.sql                 # One Big Table for denormalized analysis
    │       └── ephemeral/              # Intermediate transformations
    │           ├── bookings.sql
    │           ├── hosts.sql
    │           └── listings.sql
    │
    ├── macros/                         # Reusable SQL logic & functions
    │   ├── generate_schema_name.sql    # Custom schema naming convention
    │   ├── multiply.sql                # Custom math operations
    │   ├── tag.sql                     # Business categorization logic
    │   └── trimmer.sql                 # String cleaning utilities
    │
    ├── snapshots/                      # Slowly Changing Dimensions (SCD Type 2)
    │   ├── dim_bookings.yml            # Tracking history for bookings
    │   ├── dim_hosts.yml               # Tracking history for hosts
    │   └── dim_listings.yml            # Tracking history for listings
    │
    ├── tests/                          # Custom data quality & business rule tests
    │   └── source_tests.sql
    │
    ├── seeds/                          # Static reference data (e.g., country codes)
    └── analyses/                       # Ad-hoc analysis & SQL playgrounds
```
