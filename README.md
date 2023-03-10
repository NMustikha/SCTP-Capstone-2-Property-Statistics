# Capstone on Relational Database and Excel Dashboard

## _Understanding the Property Market with Statistics_

[![SLIDE](https://i.gyazo.com/26de1e460c449cfc9a2a9819fb0ce7c9.jpg)](https://gyazo.com/26de1e460c449cfc9a2a9819fb0ce7c9)
[![EXCEL](https://i.gyazo.com/663fd56a85e2925164683fcbd33b2ab7.png)](https://gyazo.com/663fd56a85e2925164683fcbd33b2ab7)

#

#### Description of Dataset

The main dataset used in this capstone is the CEA Salespersons' Property Transactions. It mainly consists of all transactions from January 2017 to February 2023 of each property agent with an active license. This includes property type, transaction type and the representing party involved in the transactions. The dataset has a size of 689,068 rows.

The secondary dataset is the CEA Salesperson Information which serves as supplementary information. It mainly consists of each property agent's license registration and expiry as well as the agency they are working for. The dataset has a size of 35,133 rows.

#### **Main assumption made on the main dataset:**
Property agents can close multiple transactions in the same month within the same location and represent parties of the same and/or different category (i.e. seller, buyer). For example, Agent A closed 2 transactions in January 2021 where both are located in Yishun and both clients are buyers.

[![ERD](https://i.gyazo.com/28e43fce451060263a8277479e4990bf.png)](https://gyazo.com/28e43fce451060263a8277479e4990bf)
[![SCHEMA](https://i.gyazo.com/04294690ee03b56048aefbce5c874701.png)](https://gyazo.com/04294690ee03b56048aefbce5c874701)

#### Description of Dashboard
The dashboard mainly focuses on the percentage on time delivery by shipment with the following as secondary information: total orders by shipment, total weight by shipment, total expenditure by shipment, geographical chart of countries, total orders by month and total sum of items by month.

#### Observations & Insights
Go to the [presentation slides]( https://github.com/NMustikha/SCTP-Capstone-2-Property-Statistics/blob/main/Capstone%202%20-%20Property%20Statistics.pptx) for more information (includes SQL codes):
**1. For property type in Singapore, HDB and Condominiums have around 5% difference in total number of transactions**
Condos are very popular in recents years (2020s) with a steep increase to compensate its non existent or low transaction in the 2010s as compared to HDB steady increase over the 2010s and 2020s.

**2. High count for resale flats (both buyers and sellers) as well as whole rental**
Probably with the onset of the pandemic and delay in BTO flats, home owners turn to the resale market. Also, a possibility that whole rental comes from condo owners who stay in HDB but generate passive income through rental.

**3. Districts 9 and 10 top the chart as most popular locations with high counts of condominium transactions**
There is a dominance of that specific property type in those districts which happen to be in the affluent central region. Those districts are known as "high end" due to locations such as Orchard, Cainhill, Bukit Timah, etc and they are known for private properties rather than residential estates.

#### Other Comments
The main dataset only includes property type where residential estates are categoried as HDB. By including the different housing types (i.e. 3 room), a more holistic analysis could be done by having the transaction breakdown of each housing type to better understand the market. The possibility of including the sales of each transaction also the analysis of the overall market value.

#### Connect with Me!
Like my work? Send me a DM on [Linkedin!](https://sg.linkedin.com/in/noor-mustikha-nk)