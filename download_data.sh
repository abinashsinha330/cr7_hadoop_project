# Downloading data
wget https://csci5751-2020sp.s3-us-west-2.amazonaws.com/sales-data/salesdata.tar.gz

# Extracting data
tar -xf salesdata.tar.gz

# Remove tar.gz file
rm salesdata.tar.gz

# Go to salesdb directory
cd salesdb;

# create corresponding directories
mkdir customers
mkdir employees
mkdir products
mkdir sales

# Move each csv file to its respective folder.
mv Customers2.csv customers/; mv Employees2.csv employees/; mv Products.csv products/; mv Sales2.csv sales/;

# Move to /home/cloudera.
cd ..;
