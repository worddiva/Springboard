
# Load the data in RStudio
library(dplyr)
library(readr)
refine_original <- read_csv("~/Documents/Springboard/Data Wrangling/refine_original.csv")

#Inspect dataset and convert to local data frame
View(refine_original)
tbl_df(refine_original)

# 1: Clean up brand names
refine_original$company <-gsub("^[Pp|Ff].*[Ss]$", "philips", refine_original$company)
refine_original$company <-gsub("^[Aa].*[Oo0]$", "akzo", refine_original$company)
refine_original$company <-gsub("^[Vv].*n$", "van houten", refine_original$company)
refine_original$company <-gsub("^[Uu].*r$", "unilever", refine_original$company)

# 2: Separate product code and number
library(tidyr)
refine_original <- separate(refine_original, "Product code / number",c("product_code","product_number"), sep = "-")

# 3: Add product categories
#Function to convert product codes into product categories
code_to_cat <- function(code) {
  if(code == "p"){
    return("Smartphone")
  } else if (code == "v"){
    return("TV")
  } else if (code == "x"){
    return("Laptop")
  } else if (code == "q"){
    return("Tablet")
  } else 
    return(Unclassified)
}

refine_original$product_category <-sapply(refine_original$product_code, code_to_cat)

# 4: Add full address for geocoding
refine_original <- mutate(refine_original, full_address = paste(address, city, country, sep = ","))

# 5: Create dummy variables for company and product category
# Dummy variables for product company
refine_original$company_philips <- as.numeric(refine_original$company == "philips")
refine_original$company_akzo <- as.numeric(refine_original$company == "akzo")
refine_original$company_van_houten <- as.numeric(refine_original$company == "van houten")
refine_original$company_unilever <- as.numeric(refine_original$company == "unilever")

# Dummy variables for product category
refine_original$product_smartphone <- as.numeric(refine_original$product_category == "Smartphone")
refine_original$product_tv <- as.numeric(refine_original$product_category == "TV")
refine_original$product_laptop <- as.numeric(refine_original$product_category == "Laptop")
refine_original$product_tablet <- as.numeric(refine_original$product_category == "Tablet")

# Cleaned up data as a CSV file called refine_clean.csv
write_csv(refine_original, "refine_clean.csv")

