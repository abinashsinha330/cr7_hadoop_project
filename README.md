# CSCI 5751 Hadoop Project

## Team: *cr7*
>Abinash Sinha<br/>
>sinha160@umn.edu<br/>
>slack channel: *cr7*



## Deployment RunBook

Run the below commands in sequential fashion:

1. Run `git clone https://github.com/abinashsinha330/cr7_hadoop_project.git` command to get code; if we get http error then need to update curl library in linux using command, `sudo yum update -y nss curl libcurl` and then again run the git clone command
2. Run `cd cr7_hadoop_project`
3. Run `chomd +x ./main.sh` command to make main.sh executable bash script
4. `main.sh` is main script used for deploying as per need and also to rollback whole deployment. Run either of these commands as part of the deliverables of the project:
	* Run `./main.sh -h` command for knowing functionality of main script
	* Run `./main.sh -l` command to download data and load into hdfs
	* Run `./main.sh -d2` command for Deliverable 2 (can be executed only when `./main.sh -l` gets executed successfully
	* Run `./main.sh -d3` command for Deliverable 3 (can be executed only when `./main.sh -l` and `./main.sh -d2` get executed successfully)
	* Run `./main.sh -d23` command for Deliverable 2 and 3 both
	* Run `./main.sh -r` command for removing all tables, databases and everything related to project in HDFS and VM environment
	* Run `./main.sh -tv` command for testing performance of views created (use partitioned and non-partitioned table); `./main.sh -l`, `./main.sh -d2` and `./main.sh -d3` get executed successfully
	* Run `./main.sh -tt` command for testing performance of external and internal tables created; `./main.sh -l`, `./main.sh -d2` and `./main.sh -d3` get executed successfully



## User Documentation

### Databases

#### cr7_sales_raw: 
database created using direct raw data secured from https://csci5751-2020sp.s3-us-west-2.amazonaws.com/sales-data/salesdata.tar.gz
 
#### cr7_sales:
database including managed tables in Parquet format after analysing raw sales data in *cr7_sales_raw* database and views created using these managed tables

### Tables in *cr7_sales* db

#### Internal Tables (Managed tables in parquet format)
The 4 raw csv files had duplicate records as identified during analysis of raw data. Below 4 internal tables correspond to 4 raw csv files extracted after removing these duplicates. Quality analysis of external tables corresponding to these 4 internal tables in *cr7_sales_raw* also showed that certain items are priced at $0.00 and also instead of NULL as entry there are blanks in some fields (which is not affecting here so didn't change here)

##### customers

| Column       | Data Type     |
|---------------	|-----------	|
| `customerid`      | `int`         |
| `firstname`       | `varchar`     |
| `middleinitial`   | `varchar`     |
| `lastname`        | `varchar`     |

##### employees

| Column       | Data Type     |
|---------------	|-----------	|
| `employeeid `     | `int`         |
| `firstname`       | `varchar`     |
| `middleinitial`   | `varchar`     |
| `lastname`        | `varchar`     |
| `region`          | `varchar`     |

##### products

| Column       | Data Type      |
|---------------	|-----------	 |
| `productid`       | `int`          |
| `name`            | `varchar`      |
| `price`           | `decimal(38,4)` |

##### sales

| Column       | Data Type     |
|---------------	|-----------	|
| `orderid`       	| `int`       	|
| `salespersonid` 	| `int`       	|
| `customerid`    	| `int`       	|
| `productid`     	| `int`       	|
| `quantity`      	| `int`       	|
| `datesale` 	| `Timestamp` 	|


#### Partitioned Tables
Below 2 tables are containg product & sales combined data partitioned by year & month and region and product, sales & region data combined where partitioning is done by region, year & month

##### product_sales_partition

| Column       | Data Type      |
|---------------	|-----------	  |
| `orderid`         | `int`          |
| `salespersonid`   | `int`          |
| `customerid`      | `int`          |
| `productid`       | `int`          |
| `productname`     | `varchar`      |
| `price`    | `decimal(38,4)` |
| `quantity`        | `int`          |
| `amount`  | `decimal(38,4)` |
| `orderdate`       | `Timestamp`    |
| `year`            | `int`          |
| `month`           | `int`          |

##### product_region_sales_partition

| Column       | Data Type      |
|---------------	|-----------	  |
| `orderid`         | `int`          |
| `salespersonid`   | `int`          |
| `customerid`      | `int`          |
| `productid`       | `int`          |
| `productname`     | `varchar`      |
| `price`    | `decimal(8,4)` |
| `quantity`        | `int`          |
| `amount`  | `decimal(8,4)` |
| `orderdate`       | `Timestamp`    |
| `region`          | `varchar`      |
| `year`            | `int`          |
| `month`           | `int`          |

### Views in *cr7_sales* db

1st view returns monthly sales amount by customer in 2019 (on non-partitioned data), 2nd view returns top 10 customers with largest total sales over lifetime in decreasing order of amount in dollars, 3rd view also returns monthly sales amount by customer in 2019 but operates on partitioned data

##### customer_monthly_sales_2019_view

| Column       | Data Type     |
|---------------	    |-----------     |
| `customerid`          | `int`          |
| `lastname`           | `varchar`      |
| `firstname`            | `varchar`      |
| `year`                | `int`          |
| `month`               | `int`          |
| `totalamount`    | `decimal(38,4)` |

##### top_ten_customers_amount_view

| Column       | Data Type     |
|---------------	    |-----------      |
| `customerid`          | `int`          |
| `lastname`           | `varchar`      |
| `firstname`            | `varchar`      |
| `total_sales_amount` | `decimal(38,4)` |

##### customer_monthly_sales_2019_partitioned_view

| Column       | Data Type     |
|---------------	    |-----------     |
| `customerid`          | `int`          |
| `lastname`           | `varchar`      |
| `firstname`            | `varchar`      |
| `year`                | `int`          |
| `month`               | `int`          |
| `totalamount`    | `decimal(38,4)` |


Query execution can be parallelised across partitions and later results from all partitions can be aggregated. But in non-parititioned data, query execution is serial in nature. Therefore, query execution on partitioned data would be faster given we have a lot of data. Having parallelism on less amount of data would be not give performance benefit due to overhead in terms of cost of causing parallelism.

In our case, the view using partitioned table (where partition is done using year and month) scans only the necessary portion of the whole data but the view using non-partitioned scans whole data for retreiving customer sales on monthly basis in 2019.



## Acknowledgement
I am very grateful towards **Prof. Chad Dvoracek** and **Prof. Donald Sawyer** for understanding my personal situation and giving me additional time to finish this project for complete learning.
