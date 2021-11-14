# Market-basket-analysis
association rule are used to predict the likelihood of products being purchased together and count the frequency of items that occur together, seeking to find associations that occur far more often than expected       
## Dataset
the dataset is from the UCI Machine Learning Repository. The dataset contains transaction data from 01/12/2010 to 09/12/2011 for a UK-based registered non-store online retail.

### data discription
*1.Number of Rows:541909*
*2.Number of Attributes:08*
### Attribute Information
*1.InvoiceNo: Invoice number. Nominal, a 6-digit integral number uniquely assigned to each transaction. If this code starts with letter 'c', it indicates a cancellation. *
*2.StockCode: Product (item) code. Nominal, a 5-digit integral number uniquely assigned to each distinct product.*
*3.Description: Product (item) name. Nominal.*
*4.Quantity: The quantities of each product (item) per transaction. Numeric.*
*5.InvoiceDate: Invoice Date and time. Numeric, the day and time when each transaction was generated. Example from dataset: 12/1/2010 8:26*
*6.UnitPrice: Unit price. Numeric, Product price per unit in sterling.*
*7.CustomerID: Customer number. Nominal, a 5-digit integral number uniquely assigned to each customer.*
*8.Country: Country name. Nominal, the name of the country where each customer resides.*

##Libraries
| package | Descriptiom |
|:---------|:-------------|
|arules | Provides the infrastructure for representing, manipulating and analyzing transaction data and patterns (frequent itemsets and association rules).|
|arulesViz|Extends package 'arules' with various visualization techniques for association rules and item-sets. The package also includes several interactive visualizations for rule exploration.|
|tidyverse | The tidyverse is an opinionated collection of R packages designed for data science |
|readxl | Read Excel Files in R |
|plyr | Tools for Splitting, Applying and Combining Data |
|ggplot2 | Create graphics and charts |
|knitr | Dynamic Report generation in R |
|lubridate | Lubridate is an R package that makes it easier to work with dates and times. |
