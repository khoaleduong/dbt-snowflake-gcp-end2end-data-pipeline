-- 1. Define the File Format for CSV ingestion
-- This object specifies the structure of the source files in GCS
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = TRUE
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

-- 2. Create an External Stage pointing to Google Cloud Storage (GCS)
-- Note: GCS uses the 'gcs://' protocol. 
-- Integration via STORAGE_INTEGRATION is recommended for production security.
CREATE OR REPLACE STAGE snowstage
  URL = 'gcs://your_gcs_bucket_name/path/'
  FILE_FORMAT = csv_format;

-- 3. Load data from GCS into the target Snowflake table
-- For GCS, Snowflake authenticates via a Service Account managed through a Storage Integration.
-- Ensure the Snowflake Service Account has 'Storage Object Viewer' permissions on the GCS bucket.
COPY INTO <your_table_name>
FROM @snowstage
FILES = ('your_file_name.csv');