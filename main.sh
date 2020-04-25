#!/bin/bash

echo ""
echo "Deliverable 1 done (Git setup and team formation; Code at https://github.com/abinashsinha330/cr7_hadoop_project)!"
echo ""

chmod +x *.sh

argument=$1

describe_main_script(){
	echo "Below are the arguments as described:"
	echo ""
	echo "-h (help)"
	echo "-l (download raw data from https://csci5751-2020sp.s3-us-west-2.amazonaws.com/sales-data/salesdata.tar.gz and load into hdfs)"
	echo "-d2 (execute code for Deliverable 2)"
	echo "-d3 (execute code for Deliverable 3)"
	echo "-d23 (execute code for getting, loading, creating and inserting data of Deliverables 1 and 2)"
	echo "-r (remove all tables, databases and everthing related to project in HDFS and VM environment)"
	echo "-tv (test performance of views)"
	echo "-tt (test performance of tables)"
}

get_and_loadhdfs(){
	echo "Deliverable 2, Step 1"

	echo "Downloading data"
	./download_data.sh

	echo "Loading raw data to HDFS"
	./load_hdfs.sh
}

execute_deliverable_2(){
	echo "Deliverable 2"
	
	echo "Creating database (cr7_sales_raw) and external table using raw data"
	impala-shell -f create_sales_raw.sql
	
	echo "Deliverable 2, Step 2"
	
	echo "Creating database (cr7_sales) and Parquet managed tables using processed data"
	impala-shell -f create_sales_analysed.sql
	
	echo "Creating view to get monthly sales in 2019 for each customer"
	impala-shell -f customer_monthly_sales_2019_view.sql
	
	echo "Creating view to get top ten customers sorted in decreasing order by amount of sales"
	impala-shell -f top_ten_customers_amount_view.sql
}

execute_deliverable_3(){
	echo "Deliverable 3"
	
	echo "Creating Impala Parquet materialised table having sales and product data partitioned by year and month"
	impala-shell -f product_sales_partition.sql

	echo "Creating view to get monthly sales in 2019 for each customer using partitioned table having saled and product data"
	impala-shell -f customer_monthly_sales_2019_partitioned_view.sql

	echo "Creating Impala Parquet materialised table having sales and region data partitioned by region, year and month"
	impala-shell -f product_region_sales_partition.sql
}

remove_all(){
	echo "Deliverable 3 Step 4"
	echo "Deleting all tables, databases and data from HDFS and VM environment"
	./remove_all.sh
}

test_perf_views(){
        echo "Test performance of views!"
        echo ""
        ./test_perf_views.sh
}

test_perf_tables(){
        echo "Test performance of tables!"
        echo ""
        ./test_perf_tables.sh
}

execute_all(){
	get_and_loadhdfs
	execute_deliverable_2
	execute_deliverable_3
	test_perf_views
	test_perf_tables
}



case $argument in
	-h)
	describe_main_script
	echo ""
	;;
	
	-l)
	get_and_loadhdfs
	touch l.txt
	echo ""
	;;

	-d2)
	f1=l.txt
	if test -f "$f1"; then
		execute_deliverable_2
		touch d2.txt
	else
		echo "execute command \"./main.sh -l\" before this command"
	fi
	echo ""
	;;
	
	-d3)
	f1=l.txt
	f2=d2.txt
	if test -f "$f1" && test -f "$f2";then
		execute_deliverable_3
		touch d3.txt
	else
		echo "execute commands \"./main.sh -l\" and \"./main/sh -d2\" before this command" 
	fi
	echo ""
	;;
	
	-r)
	remove_all
	echo ""
	;;

	-d23)
	execute_all
	echo ""
	;;
	
	-tv)
	f1=l.txt
        f2=d2.txt
	f3=d3.txt
        if test -f "$f1" && test -f "$f2" && test -f "$f3";then
		test_perf_views
	else
		echo "execute commands \"./main.sh -l\", \"./main/sh -d2\" and \"./main/sh -d3\" before this command "
	fi
	echo ""
	;;

	-tt)
	f1=l.txt
        f2=d2.txt
        f3=d3.txt
        if test -f "$f1" && test -f "$f2" && test -f "$f3";then
		test_perf_tables
	else 
                echo "execute commands \"./main.sh -l\", \"./main/sh -d2\" and \"./main/sh -d3\" before this command "
        fi
	echo ""
	;;
	
	*)
	echo "Invalid argument passed!"
	echo ""
esac
