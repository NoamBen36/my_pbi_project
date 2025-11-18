3 days rolling avg purchase = 
VAR _maxdate = MAX(dim_date[date])
VAR _days = 3
VAR _rollingmetric = CALCULATE(
    [total_gross_purchase],
        DATESINPERIOD(dim_date[date], _maxdate, -_days, DAY)
)
-- WOULD WORK WiTH averagex as well
VAR _result = DIVIDE(_rollingmetric, _days)
RETURN
_result



3 months rolling avg purchase = 
VAR _maxdate = MAX(dim_date[Start of Month])
VAR _months = 3
VAR _rollingmetric = CALCULATE(
    [total_gross_purchase],
        DATESINPERIOD(dim_date[Start of Month], _maxdate, -_months, MONTH)
)
-- WOULD WORK WiTH averagex as well
VAR _result = DIVIDE(_rollingmetric, _months)
RETURN
_result


30-day rolling purchase = 
CALCULATE(
    [total_gross_purchase],
    DATESINPERIOD(
        dim_date[date],
        MAX(dim_date[date]),
        -30,
        DAY
    )
)


active_customers = 
-- Get all the customer who have an approved purchase
VAR PurchCust =
    SELECTCOLUMNS(
        FILTER(
            fact_purchases, fact_purchases[status] = "Approved"), 
            "customer_id", fact_purchases[customer_id]
    )
 -- Get all the customer who have wagered   
VAR WagerCust =
    SELECTCOLUMNS(fact_wagering, "customer_id", fact_wagering[customer_id])
--Get the unique customers count
VAR AllCust = 
    UNION( PurchCust, WagerCust )
RETURN
COUNTROWS( DISTINCT(AllCust)
)



avg_purchase = 
[total_gross_purchase]/[count_purchases]



AvgPurchase_CM_PerTransaction = 
VAR _MaxDate = MAX(dim_date[date])-- Last day of the calendar
VAR _StartOfMonth = DATE ( YEAR (_MaxDate ), MONTH ( _MaxDate), 1 )
VAR _EndOfMonth   = EOMONTH ( _MaxDate, 0 )
VAR _CurrMonthPurchases =
    CALCULATE (
        [total_gross_purchase],
        FILTER (
            ALL ( dim_date ),
            dim_date[date] >= _StartOfMonth &&
            dim_date[date] <= _EndOfMonth
        )
    )
VAR Transactions_CM =
    CALCULATE (
        COUNTROWS ( fact_purchases ),
        FILTER (
            ALL ( dim_date ),
            dim_date[date] >= _StartOfMonth &&
            dim_date[date] <= _EndOfMonth
        )
    )
RETURN
DIVIDE ( _CurrMonthPurchases, Transactions_CM )


AvgPurchase_CM_PerTransaction_previousmonth = 
 CALCULATE(
    [AvgPurchase_CM_PerTransaction],
    DATEADD(dim_date[date], -1,MONTH
    )
)



count_purchases = 
CALCULATE(
    COUNTROWS(fact_purchases),
    FILTER(fact_purchases, fact_purchases[status] = "Approved")
)



count_wager = 
 COUNTROWS(fact_wagering)


count_withdrawals = 
CALCULATE(
 COUNT(fact_withdrawals[customer_id]),
 FILTER(fact_withdrawals,fact_withdrawals[status] = "Approved")
)


gross_purchase_MTD = 
 CALCULATE(
    [total_gross_purchase],
    ALL(dim_date),
    DATESMTD(
        dim_date[date]
    ))


gross_purchase_MTD_PreviousMonth = 
CALCULATE(
    [total_gross_purchase],
    DATESMTD(
        DATEADD(dim_date[date].[Date], -1, MONTH
        )))


gross_purchase_YTD = 
 CALCULATE(
    [total_gross_purchase],
    ALL(dim_date),
    DATESYTD(
        dim_date[date]
    ))


gross_purchase_YTD_PreviousYear = 
CALCULATE(
    [total_gross_purchase],
    DATESYTD(
        DATEADD(dim_date[date].[Date], -1, YEAR
        )))


last_year_purchase = 
 CALCULATE(
    [total_gross_purchase], SAMEPERIODLASTYEAR(dim_date[date]),
        REMOVEFILTERS(dim_date[Start of Month])
 )

lm_active_customers = 
CALCULATE(
    [active_customers],
    REMOVEFILTERS(dim_date[Start of Month]),
    DATEADD(dim_date[date], -1, MONTH))


lm_total_gross_purchase = 
CALCULATE(
    [total_gross_purchase],
    REMOVEFILTERS(dim_date[Start of Month]),
    DATEADD(dim_date[date], -1, MONTH))


lm_total_net_deposit = 
CALCULATE(
    [total_net_deposit],
    REMOVEFILTERS(dim_date[Start of Month]),
    DATEADD(dim_date[date], -1, MONTH))


ly_active_customers = 
CALCULATE(
    [active_customers],
    SAMEPERIODLASTYEAR(dim_date[date]),
    REMOVEFILTERS(dim_date[Start of Year])
)


ly_total_gross_purchase = 
CALCULATE(
    [total_gross_purchase],
    REMOVEFILTERS(dim_date[Start of Year]),
    DATEADD(dim_date[date], -1, YEAR))


ly_total_net_deposit = 
CALCULATE(
    [total_net_deposit],
    REMOVEFILTERS(dim_date[Start of Year]),
    DATEADD(dim_date[date], -1, YEAR))


Purchase By Customer = 
 DIVIDE(
    [total_gross_purchase],
    [active_customers]
 )


 target_m_customers = 
 [lm_active_customers]*1.10


 target_m_gross_purchase = 
 [lm_total_gross_purchase]*1.10


 target_m_net_deposit = 
 [lm_total_net_deposit] *1.10


 target_y_customers = 
 [ly_active_customers]*1.10


 target_y_gross_purchase = 
 [ly_total_gross_purchase]*1.10


 target_y_net_deposit = 
 [ly_total_net_deposit]*1.10


total withdrawals = 
SUM(fact_withdrawals[gross_withdrawal_amount]
)


total_gross_purchase = SUM(
    fact_purchases[gross_purchase_amount])


total_net_deposit = 
SUM(
    fact_purchases[net_deposit])


total_wagering = 
 SUM(fact_wagering[grosswin])