-- remove all tables, databases, data from HDFS and VM environment

echo "Removing all tables and databases."
impala-shell -f remove.sql

echo "Removing salesdb from HDFS"
sudo -u hdfs hdfs dfs -rm -r /salesdb

echo "Removing everything from VM"
cd ..
rm -rf cr7_hadoop_project
cd ..
