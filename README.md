# restaurant_dbt – Star schema demo (Databricks)

Flow:  seeds (raw)  ->  staging (clean)  ->  intermediate (price lines)  ->  marts (dims + facts)

Quick start
1. pip install dbt-databricks
2. Copy profiles.yml.example to ~/.dbt/profiles.yml and fill in your Databricks details
3. dbt debug      # checks connection
4. dbt deps       # installs dbt_utils
5. dbt seed       # loads the 8 CSVs in /seeds as raw tables
6. dbt run        # builds staging + dims + facts
7. dbt test       # runs 39 data quality tests
(or just:  dbt build   = seed + run + test in order)
8. dbt docs generate && dbt docs serve    # lineage graph for your demo
