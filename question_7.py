from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum as _sum


input_path = "revenue_folder/input.json"
output_path  = "revenue_folder/output.parquet"

spark = SparkSession.builder \
     .appName("calcTotalRev") \
     .getOrCreate()

df = spark.read.json(input_path)

total_revenue_df = df.groupBy("user_id").agg(
    _sum(col("amount")).alias("total_revenue")
)

total_revenue_df.write.parquet(output_path)


result = spark.read.parquet(output_path)
result.show()
