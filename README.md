<p align="center">
  <img src="images/dashboard.png" alt="Domino's Pizza Sales Dashboard" width="900">
</p>

# 🍕 Domino's Pizza Sales Analysis

End-to-end sales analysis of a full year (2015) of pizza orders using **Excel**, **MySQL** and **Power BI**. The project answers core business questions on revenue, order behaviour, menu performance and demand patterns, and turns them into recommendations.

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Tools Used](#tools-used)
- [Project Structure](#project-structure)
- [Methodology](#methodology)
- [Key Metrics](#key-metrics)
- [Key Findings](#key-findings)
- [Recommendations](#recommendations)
- [Data Quality Notes](#data-quality-notes)
- [How to Run](#how-to-run)
- [Author](#author)

## Project Overview
The goal is to understand how the business performed in 2015 and where it can grow. The analysis covers:

- Total revenue, orders, pizzas sold and average order value
- Revenue by pizza category, size and individual pizza
- Time patterns by month, weekday and hour of day
- Order-size behaviour (how many pizzas per order)
- Data health checks and a review of the SQL logic

## Dataset
| Item | Detail |
| --- | --- |
| File | `pizza_sales.csv` |
| Period | 1 Jan 2015 – 31 Dec 2015 |
| Rows | 48,620 order line items |
| Orders | 21,350 distinct orders |
| Menu | 32 pizzas, 4 categories (Classic, Supreme, Chicken, Veggie), 5 sizes (S, M, L, XL, XXL) |

**Columns:** `pizza_id`, `order_id`, `pizza_name_id`, `quantity`, `order_date`, `order_time`, `unit_price`, `total_price`, `pizza_size`, `pizza_category`, `pizza_ingredients`, `pizza_name`

## Tools Used
- **Excel**: initial cleaning and inspection
- **MySQL**: table creation, data exploration and business-question queries
- **Power BI**: interactive dashboard (KPI cards, charts and slicers)

## Project Structure
```
├── images/
│   └── dashboard.png                  # Dashboard preview
├── pizza_sales.csv                    # Raw dataset
├── Business_Analysis_Using_SQL.sql    # MySQL queries (4 levels of analysis)
├── Pizza_Sales_Dashboard.pbix         # Power BI dashboard
├── Pizza_Sales_Report_2015.pdf        # Formal performance report
└── README.md
```

## Methodology
1. **Data preparation**: created the `pizza_sales` table, imported the CSV, and dropped the unused `pizza_ingredients` column.
2. **Data exploration**: checked row counts and null values.
3. **SQL analysis**, organised in four levels:
   - *Level 1, Basic totals:* revenue, orders, pizzas sold, average order value, pizzas per order
   - *Level 2, Sales by group:* category, size, top and bottom pizzas by revenue and quantity
   - *Level 3, Time patterns:* monthly revenue, weekday and hourly demand, busiest and quietest hours
   - *Level 4, Percentages:* revenue share by category and size, order-size distribution
4. **Visualisation**: built a Power BI dashboard on the cleaned data.
5. **Reporting**: wrote a structured report with an executive summary, trends, diagnostics and an action plan.

## Key Metrics
| Metric | Value |
| --- | --- |
| Total revenue | **$817,860** |
| Total orders | **21,350** |
| Pizzas sold | **49,574** |
| Average order value | **$38.31** |
| Pizzas per order | **2.32** |

## Key Findings
- **Sales were flat all year.** Monthly revenue stayed between $64.0K and $72.6K (July was the peak), and H2 finished 2.3% below H1.
- **Chicken pizzas earn the most per pizza.** The top three pizzas by revenue are Thai Chicken, Barbecue Chicken and California Chicken (15.6% combined). Chicken averages $17.73 per pizza against $14.78 for Classic.
- **Large pizzas carry the revenue.** Size L brings 45.9% of revenue. XL and XXL together bring 1.8%, and only the Greek Pizza comes in those sizes.
- **Demand is concentrated.** 45% of orders arrive in four hours (12–2 pm and 5–7 pm). Friday averages 71 orders a day and Sunday only 50.
- **Order size is the main lever.** 38% of orders contain a single pizza.
- **The menu has a long tail.** Brie Carre is the weakest pizza, at 490 sold and 1.4% of revenue.

## Recommendations
| Action | Estimated impact* |
| --- | --- |
| Prompt a second pizza or combo on single-pizza orders | About +$13.4K (+1.6%) if 10% of single-pizza orders add one pizza |
| Run a Sunday offer to lift Sunday to Monday's level | About +$15.4K (+1.9%) |
| Promote the three top Chicken pizzas | About +$9.8K (+1.2%) per +5% in Chicken pizzas sold |
| Staff and prep around the 12–2 pm and 5–7 pm peaks | Faster service on 45% of orders |
| Decide the future of Brie Carre and the XXL size | Simpler menu and prep |


## Data Quality Notes
- No missing values in any column, no duplicate `pizza_id`, and `unit_price × quantity = total_price` on every row.
- 7 days have no sales (24–25 Sep, 5/12/19/26 Oct, 25 Dec). These explain most of the September–October dip; confirm whether they are closures or missing records.
- Dates in the CSV are `dd-mm-yyyy`. Convert them on import (e.g. `STR_TO_DATE(order_date, '%d-%m-%Y')`) so month and week results are correct.
- Query logic to keep in mind when reading results:
  - Use `SUM(quantity)` for pizzas sold. `COUNT(quantity)` counts line items.
  - Use `DAYNAME(order_date)` with `COUNT(DISTINCT order_id)` for weekday orders. `WEEK()` returns week of the year.

## How to Run
1. Create the table and import `pizza_sales.csv` into a MySQL database (`analytics_db`), converting dates as noted above.
2. Run `Business_Analysis_Using_SQL.sql` section by section.
3. Open `Pizza_Sales_Dashboard.pbix` in Power BI Desktop to explore the dashboard. Refresh the data source path if prompted.

## Author
**Your Name**
[LinkedIn](https://www.linkedin.com/) · [GitHub](https://github.com/) · your.email@example.com
