Avg Deposit = 
DIVIDE(
    [Total Deposit],
    [Count All Deposit],
    0
)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Count All Deposit = 
CALCULATE(
    COUNT(
        fact_deposit[deposit_id]),
        fact_deposit[days_since_email] <= 14,
        ALL(dim_offer[offer_name])
)


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Count Take Up = 
CALCULATE(
     DISTINCTCOUNT(fact_deposit[player_id]),
     fact_deposit[days_since_email] <= 14
)

// Setting up the promotion window as 14 days


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Count Targeted = 
 DISTINCTCOUNT(dim_target_list[player_id])

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Deposit = 
CALCULATE(
    SUM(
        fact_deposit[deposit_amount_eur]),
        fact_deposit[days_since_email] <= 14
)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

New Players (Opened in Period) = 
CALCULATE(
    DISTINCTCOUNT(dim_player[player_id]),
    USERELATIONSHIP(dim_calendar[Date], dim_player[open_date])
    //Inactive relationship between tables
)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
Depositors (1 deposit) = 
VAR PlayersWithCounts =
// Summarize to group players by deposit
    SUMMARIZE(
        FILTER(fact_deposit, fact_deposit[days_since_email] < 15),
        fact_deposit[player_id],
        "DepositCnt", COUNTROWS(fact_deposit)
    )
RETURN
// Only interesting in players with 1 deposit
    COUNTROWS(
        FILTER(PlayersWithCounts, [DepositCnt] = 1)
    )


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Depositors (multi deposits) = 
VAR PlayersWithCounts =
    SUMMARIZE(
        FILTER(fact_deposit, fact_deposit[days_since_email] < 15),
        fact_deposit[player_id],
        "DepositCnt", COUNTROWS(fact_deposit)
    )
RETURN
    COUNTROWS(
        FILTER(PlayersWithCounts, [DepositCnt] >= 2)
    )


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
Email Bounced Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[is_bounced] = TRUE()
)


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/


Email Clicked Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[cta_clicked] = TRUE()
)



/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/


Email Delivered Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[is_bounced] = FALSE()
)



/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/


Email Open Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[is_opened] = TRUE()
)




/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Estimated Bonus Cost = 
SUMX(
    VALUES(fact_deposit[player_id]),
    CALCULATE( MAX(fact_deposit[offer estimated cost (eur)]) )
)

// We ctake the MAX because the bonus is only available on one deposit.


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

FS Count Opted In = 
CALCULATE(
     DISTINCTCOUNT(fact_deposit[player_id]),
     fact_deposit[days_since_email] <= 14
     && fact_deposit[offer_id_attributed] = "OFF_FS10"
)

// Setting up the promotion window as 14 days



/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

FS Count Targeted = 
CALCULATE(
    DISTINCTCOUNT(dim_target_list[player_id]),
    dim_target_list[offer_id] = "OFF_FS10"
)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
FS Email Clicked Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[cta_clicked] = TRUE()
    && fact_email_send[offer_id] = "OFF_FS10"
)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
FS Email Open Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[is_opened] = TRUE()
    && fact_email_send[offer_id] = "OFF_FS10"
)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

FS Offer Take Up (Delivered) = 
VAR CountDelivered = 
    CALCULATE( 
        DISTINCTCOUNT(fact_email_send[player_id]), 
        fact_email_send[offer_id] = "OFF_FS10"
        && fact_email_send[is_bounced] = FALSE()
)
    
VAR CountOptin = 
    CALCULATE( 
        DISTINCTCOUNT(fact_deposit[player_id]), 
        fact_deposit[days_since_email] <= 14 
        && fact_deposit[offer_id_attributed] = "OFF_FS10" ) 
    
RETURN DIVIDE(CountOptin, CountDelivered, 0)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
FS Offer Take Up (Targeted) = 
VAR CountTargeted = CALCULATE( DISTINCTCOUNT(dim_target_list[player_id]), 
    dim_target_list[offer_id] = "OFF_FS10" ) 
    
VAR CountOptin = CALCULATE( DISTINCTCOUNT(fact_deposit[player_id]), 
    fact_deposit[days_since_email] <= 14 && fact_deposit[offer_id_attributed] = "OFF_FS10" ) 
    
RETURN DIVIDE(CountOptin, CountTargeted, 0)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
MU Count Opted In = 
CALCULATE(
     DISTINCTCOUNT(fact_deposit[player_id]),
     fact_deposit[days_since_email] <= 14
     && fact_deposit[offer_id_attributed] = "OFF_MATCH20_100"
)

// Setting up the promotion window as 14 days

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

MU Count Targeted = 
CALCULATE(
    DISTINCTCOUNT(dim_target_list[player_id]),
    dim_target_list[offer_id] = "OFF_MATCH20_100"
)


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
MU Email Clicked Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[cta_clicked] = TRUE()
    && fact_email_send[offer_id] = "OFF_MATCH20_100"
)


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
MU Email Open Count = 
CALCULATE(
    COUNTROWS(fact_email_send),
    fact_email_send[is_opened] = TRUE()
    && fact_email_send[offer_id] = "OFF_MATCH20_100"
)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
MU Offer Take Up (Delivered) = 
VAR CountDelivered = 
    CALCULATE( 
        DISTINCTCOUNT(fact_email_send[player_id]), 
        fact_email_send[offer_id] = "OFF_MATCH20_100"
        && fact_email_send[is_bounced] = FALSE()
)
    
VAR CountOptin = 
    CALCULATE( 
        DISTINCTCOUNT(fact_deposit[player_id]), 
        fact_deposit[days_since_email] <= 14 
        && fact_deposit[offer_id_attributed] = "OFF_MATCH20_100"
) 
    
RETURN DIVIDE(CountOptin, CountDelivered, 0)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

MU Offer Take Up (Targeted) = 
VAR CountTargeted = CALCULATE( DISTINCTCOUNT(dim_target_list[player_id]), 
    dim_target_list[offer_id] = "OFF_MATCH20_100" ) 
    
VAR CountOptin = CALCULATE( DISTINCTCOUNT(fact_deposit[player_id]), 
    fact_deposit[days_since_email] <= 14 && fact_deposit[offer_id_attributed] = "OFF_MATCH20_100" ) 
    
RETURN DIVIDE(CountOptin, CountTargeted, 0)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
Net Contribution (proxy) = 
[Total Deposit] - [Estimated Bonus Cost]

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
Offer Take Up (Delivered) = 
VAR DeliveredPlayers =
    CALCULATE(
        DISTINCTCOUNT(fact_email_send[player_id]),
        fact_email_send[is_bounced] = FALSE()
    )
VAR OptinPlayers =
    CALCULATE(
        DISTINCTCOUNT(fact_deposit[player_id]),
        fact_deposit[days_since_email] <= 14
    )
RETURN
    DIVIDE(OptinPlayers, DeliveredPlayers, 0)

/*
We only look at a two weeks window following the promotion start
& only the players that the email reached
*/



/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Offer Take Up (Targeted) = 
VAR CountTargeted =
    DISTINCTCOUNT(dim_target_list[player_id])
VAR CountOptin =
    CALCULATE(
        DISTINCTCOUNT(fact_deposit[player_id]),
        fact_deposit[days_since_email] <= 14
    )
RETURN
    DIVIDE(CountOptin, CountTargeted, 0)

/*
We only look at the deposits done over a 2 weeks windows after the promotion startdate
*/


/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/

Offer Take Up (Targeted) Both = 
VAR OfferId = SELECTEDVALUE(dim_offer[offer_id])
VAR CountTargeted =
    CALCULATE(
        DISTINCTCOUNT(dim_target_list[player_id]),
        dim_target_list[offer_id] = OfferId
    )
VAR CountOptin =
    CALCULATE(
        DISTINCTCOUNT(fact_deposit[player_id]),
        fact_deposit[days_since_email] <= 14,
        fact_deposit[offer_id_attributed] = OfferId
    )
RETURN
    DIVIDE(CountOptin, CountTargeted, 0)

/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
Total Deposit = 
CALCULATE(
    SUM(
        fact_deposit[deposit_amount_eur]),
        fact_deposit[days_since_email] <= 14,
        ALL(dim_offer[offer_name])
)
/**********************************************************************************************
***********************************************************************************************
***********************************************************************************************/
