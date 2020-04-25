#!/bin/bash

# Move DB to hdfs. 
sudo -u hdfs hdfs dfs -put salesdb /salesdb

# Remove local copy
rm -rf salesdb
