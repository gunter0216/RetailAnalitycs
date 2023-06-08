SET datestyle = 'ISO, DMY'; CREATE OR REPLACE PROCEDURE import_table(file_name varchar(255), table_name varchar(64), delimiter varchar(1)) LANGUAGE plpgsql AS $$ DECLARE dir varchar(255) := (SELECT setting AS directory FROM pg_settings WHERE name = 'data_directory') || '/' || file_name; BEGIN EXECUTE format('copy %s from %L with csv delimiter %L header', quote_ident(table_name), dir, delimiter); END $$; CREATE OR REPLACE PROCEDURE import_dataset(file_name varchar(255), table_name varchar(64), delimiter varchar(1)) LANGUAGE plpgsql AS $$ DECLARE dir varchar(255) := '/datasets/' || file_name; BEGIN EXECUTE format('copy %s from %L with csv delimiter %L header', quote_ident(table_name), dir, delimiter); END $$; CREATE OR REPLACE PROCEDURE import_personal_data_from_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'personal_data', delimiter); END $$; CREATE OR REPLACE PROCEDURE import_personal_data_from_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'personal_data', '	'); END $$; CREATE OR REPLACE PROCEDURE import_cards_from_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'cards', delimiter); END $$; CREATE OR REPLACE PROCEDURE import_cards_from_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'cards', '	'); END $$; CREATE OR REPLACE PROCEDURE import_groups_sku_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'groups_sku', delimiter); END $$; CREATE OR REPLACE PROCEDURE import_groups_sku_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'groups_sku', '	'); END $$; CREATE OR REPLACE PROCEDURE import_sku_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'sku', delimiter); END $$; CREATE OR REPLACE PROCEDURE import_sku_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'sku', '	'); END $$; CREATE OR REPLACE PROCEDURE import_stores_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'stores', delimiter); END $$; CREATE OR REPLACE PROCEDURE import_stores_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'stores', '	'); END $$; CREATE OR REPLACE PROCEDURE import_transactions_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'transactions', delimiter); END $$; CREATE OR REPLACE PROCEDURE import_transactions_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'transactions', '	'); END $$; CREATE OR REPLACE PROCEDURE import_checks_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'checks', delimiter); END $$; CREATE OR REPLACE PROCEDURE import_checks_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL import_dataset(file_name, 'checks', '	'); END $$; CREATE OR REPLACE PROCEDURE export_table(file_name varchar(255), table_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ DECLARE dir varchar(255) := (SELECT setting AS directory FROM pg_settings WHERE name = 'data_directory') || '/' || file_name; BEGIN EXECUTE format('copy %s to %L with csv delimiter %L header', quote_ident(table_name), dir, delimiter); END $$; CREATE OR REPLACE PROCEDURE export_personal_data_from_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'personal_data', delimiter); END $$; CREATE OR REPLACE PROCEDURE export_personal_data_from_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'personal_data', '	'); END $$; CREATE OR REPLACE PROCEDURE export_cards_from_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'cards', delimiter); END $$; CREATE OR REPLACE PROCEDURE export_cards_from_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'cards', '	'); END $$; CREATE OR REPLACE PROCEDURE export_groups_sku_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'groups_sku', delimiter); END $$; CREATE OR REPLACE PROCEDURE export_groups_sku_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'groups_sku', '	'); END $$; CREATE OR REPLACE PROCEDURE export_sku_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'sku', delimiter); END $$; CREATE OR REPLACE PROCEDURE export_sku_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'sku', '	'); END $$; CREATE OR REPLACE PROCEDURE export_stores_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'stores', delimiter); END $$; CREATE OR REPLACE PROCEDURE export_stores_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'stores', '	'); END $$; CREATE OR REPLACE PROCEDURE export_transactions_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'transactions', delimiter); END $$; CREATE OR REPLACE PROCEDURE export_transactions_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'transactions', '	'); END $$; CREATE OR REPLACE PROCEDURE export_checks_csv(file_name varchar(255), delimiter varchar(1)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'checks', delimiter); END $$; CREATE OR REPLACE PROCEDURE export_checks_tsv(file_name varchar(255)) LANGUAGE plpgsql AS $$ BEGIN CALL export_table(file_name, 'checks', '	'); END $$; DROP TABLE IF EXISTS personal_data CASCADE; DROP TABLE IF EXISTS cards CASCADE; DROP TABLE IF EXISTS stores CASCADE; DROP TABLE IF EXISTS checks CASCADE; DROP TABLE IF EXISTS groups_sku CASCADE; DROP TABLE IF EXISTS sku CASCADE; DROP TABLE IF EXISTS transactions CASCADE; DROP TABLE IF EXISTS users CASCADE; CREATE TABLE IF NOT EXISTS users ( User_Name varchar primary key not null, User_Role varchar not null, User_Password varchar not null ); CREATE TABLE IF NOT EXISTS personal_data ( Customer_ID serial primary key not null, Customer_Name varchar not null, Customer_Surname varchar not null, Customer_Primary_Email varchar not null, Customer_Primary_Phone decimal(10) not null ); CREATE TABLE IF NOT EXISTS cards ( Customer_Card_ID serial primary key not null, Customer_ID serial references personal_data(Customer_ID) not null ); CREATE TABLE IF NOT EXISTS groups_sku ( Group_ID serial primary key not null, Group_Name varchar not null ); CREATE TABLE IF NOT EXISTS sku ( SKU_ID serial primary key not null, SKU_Name varchar not null, Group_ID serial references groups_sku(Group_ID) not null ); CREATE TABLE IF NOT EXISTS stores ( Transaction_Store_ID serial not null, SKU_ID serial references sku(SKU_ID), SKU_Purchase_Price decimal not null, SKU_Retail_Price decimal not null ); CREATE TABLE IF NOT EXISTS transactions ( Transaction_ID serial primary key not null, Customer_Card_ID serial references cards(Customer_Card_ID) not null, Transaction_Summ decimal not null, Transaction_DateTime timestamp not null, Transaction_Store_ID serial not null ); CREATE TABLE IF NOT EXISTS checks( Transaction_ID serial references transactions(Transaction_ID) not null, SKU_ID serial references sku(SKU_ID) not null, SKU_Amount decimal not null, SKU_Summ decimal not null, SKU_Summ_Paid decimal not null, SKU_Discount decimal not null ); TRUNCATE TABLE personal_data CASCADE; TRUNCATE TABLE cards CASCADE; TRUNCATE TABLE stores CASCADE; TRUNCATE TABLE checks CASCADE; TRUNCATE TABLE Groups_SKU CASCADE; TRUNCATE TABLE SKU CASCADE; TRUNCATE TABLE transactions CASCADE; TRUNCATE TABLE users CASCADE; CALL import_personal_data_from_tsv('Personal_Data.tsv'); CALL import_cards_from_tsv('Cards.tsv'); CALL import_groups_sku_tsv('Groups_SKU.tsv'); CALL import_sku_tsv('SKU.tsv'); CALL import_stores_tsv('Stores.tsv'); CALL import_transactions_tsv('Transactions.tsv'); CALL import_checks_tsv('Checks.tsv'); INSERT INTO users (User_Name, User_Role, User_Password) VALUES ('admin', 'Administrator', 'admin'), ('user', 'User', 'user'); CREATE INDEX tr_1 on transactions(transaction_id, customer_card_id) ; CREATE INDEX ch_1 on checks(transaction_id, sku_id); CREATE INDEX sku_1 on sku(sku_id, group_id); CREATE INDEX crd_1 on cards(customer_card_id, customer_id); CREATE INDEX str_1 on stores(transaction_store_id, sku_id); DROP FUNCTION IF EXISTS interval_to_days CASCADE; CREATE OR REPLACE FUNCTION interval_to_days(a INTERVAL) RETURNS numeric AS $$ DECLARE res numeric; BEGIN res = EXTRACT( EPOCH FROM a ) / 60 / 60 / 24; RETURN res; END; $$ LANGUAGE plpgsql; DROP TABLE IF EXISTS customer_segmentation; CREATE TABLE IF NOT EXISTS customer_segmentation( Segment_ID int primary key, Average_Check_Segment varchar not null, Frequency_Segment varchar not null, Churn_Segment varchar not null ); call import_dataset( 'Customer_segmentation.tsv', 'customer_segmentation', '	' ); DROP FUNCTION IF EXISTS determine_segment CASCADE; CREATE OR REPLACE FUNCTION determine_segment(a_ch_s varchar, f_s varchar, c_s varchar) RETURNS integer AS $$ DECLARE res numeric; BEGIN res = ( SELECT Segment_ID FROM customer_segmentation WHERE Average_Check_Segment = a_ch_s AND Frequency_Segment = f_s AND Churn_Segment = c_s ); RETURN res; END; $$ LANGUAGE plpgsql; DROP VIEW IF EXISTS groups; DROP VIEW IF EXISTS s2; DROP VIEW IF EXISTS s1; DROP TABLE IF EXISTS margin_parameters CASCADE; CREATE TABLE IF NOT EXISTS margin_parameters ( m_type varchar CHECK (m_type IN ('default', 'periods', 'transactions')) default 'default', parameter int default 0 ); CREATE OR REPLACE PROCEDURE set_margin_parameters(margin_type varchar, parameter int default 0) LANGUAGE plpgsql AS $BODY$ BEGIN TRUNCATE TABLE margin_parameters; IF margin_type = 'default' THEN INSERT INTO margin_parameters(m_type) VALUES (margin_type); ELSE INSERT INTO margin_parameters(m_type, parameter) VALUES (margin_type, parameter); END IF; END; $BODY$; CREATE OR REPLACE FUNCTION get_min_date(c_id int, g_id int) RETURNS timestamp LANGUAGE plpgsql AS $BODY$ DECLARE res timestamp; BEGIN res =( SELECT first_group_purchase_date FROM periods p WHERE p.customer_id = c_id AND p.group_id = g_id ); RETURN res; END; $BODY$; CREATE OR REPLACE FUNCTION get_max_date(c_id int, g_id int) RETURNS timestamp LANGUAGE plpgsql AS $BODY$ DECLARE res timestamp; BEGIN res =( SELECT last_group_purchase_date FROM periods p WHERE p.customer_id = c_id AND p.group_id = g_id ); RETURN res; END; $BODY$; CREATE OR REPLACE VIEW periods AS WITH periods_data AS( SELECT DISTINCT cards.customer_id, sku.group_id, checks.transaction_id, sku.sku_id, transactions.transaction_datetime, checks.SKU_Discount, checks.SKU_Summ, MIN (checks.SKU_Discount) OVER (PARTITION BY customer_id, group_id) / checks.SKU_Summ AS Min_Discount FROM checks JOIN sku ON checks.sku_id = sku.sku_id JOIN transactions ON checks.transaction_id = transactions.transaction_id JOIN cards ON transactions.customer_card_id = cards.customer_card_id ORDER BY cards.customer_id, sku.group_id ) SELECT DISTINCT customer_id, group_id, MIN(transaction_datetime) OVER (PARTITION BY customer_id, group_id) AS First_Group_Purchase_Date, MAX(transaction_datetime) OVER (PARTITION BY customer_id, group_id) AS Last_Group_Purchase_Date, COUNT(transaction_id) OVER (PARTITION BY customer_id, group_id) AS Group_Purchase, ( 1 + interval_to_days( ( MAX(transaction_datetime) OVER (PARTITION BY customer_id, group_id) ) - ( MIN(transaction_datetime) OVER (PARTITION BY customer_id, group_id) ) ) ) / COUNT(transaction_id) OVER (PARTITION BY customer_id, group_id) AS Group_Frequency, MIN(Min_Discount) OVER (PARTITION BY customer_id, group_id) AS Group_Min_Discount FROM periods_data ORDER BY customer_id, group_id; DROP VIEW IF EXISTS purchase_history; CREATE OR REPLACE VIEW purchase_history AS WITH t AS ( SELECT DISTINCT cards.customer_id, sku.group_id, transactions.transaction_datetime, transactions.transaction_id, SUM(stores.sku_purchase_price * checks.sku_amount) AS Group_Cost, SUM(checks.sku_summ) AS Group_Summ, SUM(checks.sku_summ_paid) AS Group_Summ_Paid FROM transactions JOIN cards USING (customer_card_id) JOIN checks USING (transaction_id) JOIN sku USING (SKU_id) JOIN stores USING (transaction_store_id, sku_id) GROUP BY cards.customer_id, sku.group_id, transactions.transaction_datetime, transactions.transaction_id ORDER BY customer_id, transaction_datetime ) SELECT t.customer_id AS Customer_ID, t.transaction_id AS Transaction_ID, t.transaction_datetime AS Transaction_DateTime, t.group_id AS Group_ID, SUM(t.Group_Cost) AS Group_Cost, SUM(t.Group_Summ) AS Group_Summ, SUM(t.Group_Summ_Paid) AS Group_Summ_Paid FROM t GROUP BY customer_id, transaction_id, transaction_datetime, group_id ORDER BY Customer_ID, Group_ID, Transaction_DateTime; DROP VIEW IF EXISTS clients; DROP VIEW IF EXISTS customers; CREATE OR REPLACE VIEW customers AS WITH t AS ( SELECT DISTINCT cards.customer_id AS Customer_ID, COUNT(transactions.transaction_datetime) OVER (PARTITION BY Customer_ID) Customer_Visit_Count, AVG(transactions.transaction_summ) OVER (PARTITION BY Customer_ID) Customer_Average_Check, interval_to_days( NOW() - MAX(transactions.transaction_datetime) OVER (PARTITION BY Customer_ID) ) AS Period_since_last_transaction, interval_to_days( ( MAX(transactions.transaction_datetime) OVER (PARTITION BY Customer_ID) ) - ( MIN(transactions.transaction_datetime) OVER (PARTITION BY Customer_ID) ) ) Period_between_transactions FROM cards JOIN transactions USING (customer_card_id) ORDER BY customer_id ), stores_by_customer AS ( SELECT DISTINCT customer_id, CASE WHEN tr_1 = tr_2 AND tr_1 = tr_3 THEN tr_1 ELSE NTH_VALUE(transaction_store_id, 1) OVER ( PARTITION BY customer_id ORDER BY tr_1_date DESC ) END AS Customer_Primary_Store FROM ( SELECT DISTINCT COUNT(transaction_id) OVER (PARTITION BY customer_id, transaction_store_id) as Count_by_store, cards.customer_id, transactions.transaction_store_id, COUNT(transaction_id) OVER (PARTITION BY customer_id, transaction_store_id) * 10000 / COUNT(transaction_id) OVER (PARTITION BY customer_id) AS Share_by_store, NTH_VALUE(transaction_store_id, 1) OVER ( PARTITION BY customer_id ORDER BY transaction_datetime DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS tr_1, NTH_VALUE(transaction_store_id, 2) OVER ( PARTITION BY customer_id ORDER BY transaction_datetime DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS tr_2, NTH_VALUE(transaction_store_id, 3) OVER ( PARTITION BY customer_id ORDER BY transaction_datetime DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS tr_3, NTH_VALUE(transaction_datetime, 1) OVER ( PARTITION BY customer_id, transaction_store_id ORDER BY transaction_datetime DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS tr_1_date FROM cards JOIN transactions USING (customer_card_id) ORDER BY customer_id, Share_by_store DESC, tr_1_date DESC ) tmp ), viz_f AS ( SELECT Customer_ID, Period_since_last_transaction AS pslt, CASE WHEN Customer_Visit_Count = 1 THEN 1 ELSE Period_between_transactions / (Customer_Visit_Count -1) END AS Customer_Frequency FROM t ), churn AS ( SELECT Customer_ID, pslt / Customer_Frequency AS Customer_Churn_Rate FROM viz_f ), dt AS ( SELECT t.Customer_ID, t.Customer_Average_Check, Customer_Churn_Rate, ROW_NUMBER() OVER ( ORDER BY t.Customer_Average_Check DESC ) AS Check_Rating, CASE WHEN ROW_NUMBER() OVER ( ORDER BY t.Customer_Average_Check DESC ) * 1000 / ( SELECT COUNT (DISTINCT Customer_ID) FROM t ) < 100 THEN 'High' WHEN ROW_NUMBER() OVER ( ORDER BY t.Customer_Average_Check DESC ) * 1000 / ( SELECT COUNT (DISTINCT Customer_ID) FROM t ) < 350 THEN 'Medium' ELSE 'Low' END AS Customer_Average_Check_Segment, CASE WHEN ROW_NUMBER() OVER ( ORDER BY viz_f.Customer_Frequency ASC ) * 1000 / ( SELECT COUNT (DISTINCT Customer_ID) FROM t ) < 100 THEN 'High' WHEN ROW_NUMBER() OVER ( ORDER BY viz_f.Customer_Frequency ASC ) * 1000 / ( SELECT COUNT (DISTINCT Customer_ID) FROM t ) < 350 THEN 'Medium' ELSE 'Low' END AS Customer_Frequency_Segment, CASE WHEN Customer_Churn_Rate > 5 THEN 'High' WHEN ( Customer_Churn_Rate > 2 AND Customer_Churn_Rate <= 5 ) THEN 'Medium' ELSE 'Low' END AS Customer_Churn_Segment, Period_between_transactions, Period_since_last_transaction, Customer_Visit_Count, Customer_Frequency, Customer_Primary_Store FROM t JOIN viz_f USING (Customer_ID) JOIN churn USING (Customer_ID) JOIN stores_by_customer USING (Customer_ID) ORDER BY t.Customer_ID ) SELECT Customer_ID, Customer_Average_Check, Customer_Average_Check_Segment, Customer_Frequency, Customer_Frequency_Segment, Period_since_last_transaction AS Customer_Inactive_Period, Customer_Churn_Rate, Customer_Churn_Segment, determine_segment( dt.Customer_Average_Check_Segment, dt.Customer_Frequency_Segment, dt.Customer_Churn_Segment ) AS Customer_Segment, Customer_Primary_Store FROM dt; DROP VIEW IF EXISTS groups CASCADE; CREATE OR REPLACE VIEW groups AS WITH all_data AS( select customer_id, group_id, transaction_datetime, transaction_id from checks JOIN transactions using (transaction_id) join cards using (customer_card_id) JOIN sku using (sku_id) ), prev_tr AS ( SELECT customer_id, group_id, transaction_datetime, transaction_id, ABS( interval_to_days( transaction_datetime - LAG(transaction_datetime) OVER ( PARTITION BY customer_id, group_id ORDER BY customer_id, group_id, transaction_datetime ) ) - Group_Frequency ) / group_frequency AS gr_transaction_deviation from checks JOIN transactions using (transaction_id) join cards using (customer_card_id) JOIN sku using (sku_id) JOIN periods USING (customer_id, group_id) ORDER BY 1, 2, 3 ), avg_prev_tr AS ( SELECT customer_id, group_id, AVG (gr_transaction_deviation) AS Group_Stability_Index FROM prev_tr GROUP BY customer_id, group_id ORDER BY 1, 2 ), margin_data AS ( SELECT DISTINCT customer_id, group_id, transaction_datetime, transaction_id, sku_purchase_price * sku_amount AS sku_cost, sku_summ_paid, ROW_NUMBER() OVER ( PARTITION BY customer_id, group_id ORDER BY transaction_datetime DESC ) rn, CASE WHEN sku_discount > 0 THEN 1 ELSE 0 END AS with_discount FROM checks JOIN transactions using (transaction_id) JOIN cards using (customer_card_id) JOIN sku using (sku_id) JOIN stores USING (transaction_store_id, sku_id) ORDER BY 1, 2, 3 ), margin_by_group AS ( SELECT DISTINCT customer_id, group_id, SUM ( CASE WHEN ( SELECT m_type FROM margin_parameters ) = 'default' THEN ( SELECT SUM(sku_summ_paid - sku_cost) OVER (PARTITION BY customer_id, group_id) ) WHEN ( SELECT m_type FROM margin_parameters ) = 'periods' THEN ( SELECT SUM(sku_summ_paid - sku_cost) FILTER ( WHERE interval_to_days (current_date - transaction_datetime) <= ( SELECT parameter FROM margin_parameters ) ) OVER (PARTITION BY customer_id, group_id) ) WHEN ( SELECT m_type FROM margin_parameters ) = 'transactions' THEN ( SELECT SUM(sku_summ_paid - sku_cost) FILTER ( WHERE rn <= ( SELECT parameter FROM margin_parameters ) ) OVER ( PARTITION BY customer_id, group_id ) ) END ) AS Group_Margin, SUM (with_discount) AS count_with_discount FROM margin_data GROUP BY customer_id, group_id ), ct AS( select customer_id, group_id, count(distinct transaction_id) AS trans_in_interval from ( select gr_period.customer_id, gr_period.group_id, all_data.transaction_id from ( select customer_id, group_id, min(transaction_datetime) as first_date, max(transaction_datetime) as last_date from all_data group by 1, 2 ) as gr_period join all_data on gr_period.customer_id = all_data.customer_id and gr_period.first_date <= all_data.transaction_datetime and gr_period.last_date >= all_data.transaction_datetime ) tr_period group by 1, 2 ), data_table AS ( SELECT DISTINCT customer_id, group_id, Group_Margin, count_with_discount / group_purchase::numeric AS share_with_discount, MIN(Group_Min_Discount) OVER (PARTITION BY customer_id, group_id) AS Group_Minimum_Discount, SUM (Group_Summ) OVER (PARTITION BY customer_id, group_id) AS Total_Group_Summ, SUM (group_summ_paid) OVER (PARTITION BY customer_id, group_id) AS Total_Group_Summ_Paid, group_cost, group_summ, group_summ_paid, group_purchase, group_frequency, trans_in_interval, interval_to_days(CURRENT_DATE - last_group_purchase_date) AS days_since_last_group_purchase, Group_Stability_Index FROM checks JOIN transactions USING (transaction_id) JOIN cards USING (customer_card_id) JOIN personal_data USING (customer_id) JOIN sku USING (sku_id) JOIN purchase_history USING (customer_id, group_id) JOIN ct USING (customer_id, group_id) LEFT JOIN periods USING (customer_id, group_id) JOIN avg_prev_tr USING (customer_id, group_id) JOIN margin_by_group USING (customer_id, group_id) ORDER BY 1, 2 ) SELECT DISTINCT customer_id AS Customer_ID, group_id AS Group_ID, group_purchase / trans_in_interval::numeric AS Group_Affinity_Index, COALESCE ( CASE WHEN group_purchase = 1 THEN 0 ELSE days_since_last_group_purchase / group_frequency END, 0 ) AS Group_Churn_Rate, COALESCE (Group_Stability_Index, 0) AS Group_Stability_Index, Group_Margin, share_with_discount AS Group_Discount_Share, Group_Minimum_Discount, Total_Group_Summ_Paid / Total_Group_Summ AS Group_Average_Discount FROM data_table ORDER BY 1, 2; DROP FUNCTION IF EXISTS personal_offers_by_average_check; CREATE OR REPLACE FUNCTION personal_offers_by_average_check ( variant int, first_date date, last_date date, count_transactions int, coeff numeric, churn_rate numeric, discount_share int, margin_share numeric ) RETURNS TABLE ( customer_id_ int, required_check_measure numeric, group_name varchar, offer_discount_depth numeric ) AS $$ DECLARE cur CURSOR FOR WITH data_for_average_ch AS( SELECT * FROM ( SELECT cr.customer_id, tr.transaction_datetime, tr.transaction_id, ch.sku_summ_paid, ROW_NUMBER() OVER( PARTITION BY cr.customer_id ORDER BY tr.transaction_datetime DESC ) AS num_transaction FROM checks ch JOIN transactions tr ON ch.transaction_id = tr.transaction_id JOIN cards cr on tr.customer_card_id = cr.customer_card_id ) ch WHERE ( variant = 1 AND date_trunc('day', transaction_datetime) BETWEEN first_date AND last_date ) OR ( variant = 2 AND num_transaction <= count_transactions ) ), target_average_ch AS( SELECT customer_id, coeff * SUM(sku_summ_paid) / COUNT(DISTINCT transaction_id) AS required_check_measure FROM data_for_average_ch GROUP BY customer_id ), data_for_find_group AS ( SELECT tc.customer_id, tc.required_check_measure, gr.group_id, gr.group_affinity_index, gr.group_margin * margin_share * 0.01 AS margin, gr.group_minimum_discount * 100 AS group_minimum_discount, CASE WHEN gr.Group_Churn_Rate < churn_rate THEN true ELSE false END AS churn_rate_ok, CASE WHEN gr.Group_Discount_Share < discount_share THEN true ELSE false END AS group_discount_share_ok FROM target_average_ch tc JOIN groups gr ON tc.customer_id = gr.customer_id ) SELECT * FROM data_for_find_group JOIN groups_sku ON data_for_find_group.group_id = groups_sku.group_id ORDER BY customer_id, group_affinity_index DESC; current_id int := 0; group_find bool := false; BEGIN FOR rec IN cur LOOP IF current_id <> rec.customer_id OR ( current_id = rec.customer_id AND NOT group_find ) THEN IF current_id <> rec.customer_id THEN group_find = false; END IF; IF rec.churn_rate_ok AND rec.group_discount_share_ok AND NOT group_find THEN offer_discount_depth = 5 + ( rec.group_minimum_discount - rec.group_minimum_discount % 5 ); IF offer_discount_depth < rec.margin THEN customer_id_ = rec.customer_id; required_check_measure = rec.required_check_measure; group_name = rec.group_name; group_find = true; RETURN NEXT; END IF; END IF; END IF; current_id = rec.customer_id; END LOOP; END $$ LANGUAGE plpgsql; DROP FUNCTION IF EXISTS personal_offers_by_frequency_of_visits; CREATE OR REPLACE FUNCTION personal_offers_by_frequency_of_visits(FirstDate date, LastDate date, AddedNumberOfTransactions int, MaxChurnIndex int, MaximumShareTransactions int, AllowableMarginShare int) RETURNS TABLE( Customer_ID int, Start_Date timestamp, End_Date timestamp, Required_Transactions_Count int, Group_Name varchar(255), Offer_Discount_Depth float ) AS $$ select t1.customer_id, t1.FirstDate, t1.LastDate, t1.Required_Transactions_Count, t1.group_name, t1.Offer_Discount_Depth from ( select distinct on (personal_data.customer_id) personal_data.customer_id as customer_id, FirstDate, LastDate, round((LastDate - FirstDate) / customers.customer_frequency) + AddedNumberOfTransactions as Required_Transactions_Count, groups_sku.group_name as group_name, groups.group_affinity_index as group_affinity_index, groups.group_minimum_discount as Offer_Discount_Depth from personal_data left join customers on customers.customer_id = personal_data.customer_id left join groups on groups.customer_id = personal_data.customer_id left join groups_sku on groups_sku.group_id = groups.group_id where groups.group_churn_rate <= MaxChurnIndex and groups.group_discount_share < MaximumShareTransactions and round(groups.group_minimum_discount * 0.2) * 5 < AllowableMarginShare * groups.group_margin order by personal_data.customer_id, groups.group_affinity_index desc) as t1 $$ LANGUAGE SQL; DROP FUNCTION IF EXISTS cross_selling_offer; CREATE OR REPLACE FUNCTION cross_selling_offer ( number_of_groups int, maximum_churn_index numeric, maximum_consumption_stability_index numeric, maximum_SKU_share numeric, allowable_margin_share numeric ) RETURNS TABLE ( Customer_ID int, SKU_Name varchar, Offer_Discount_Depth decimal ) AS $$ BEGIN RETURN QUERY SELECT ttt.Customer_ID, sku.SKU_Name, CEIL(group_min_discount * 20) * 5 AS Offer_Discount_Depth FROM ( SELECT customers.customer_id, transaction_store_id, sku_id, group_id, ( ( allowable_margin_share * (sku_retail_price - sku_purchase_price) ) / sku_retail_price ) Offer_Discount_Depth FROM ( SELECT sku_id, group_id, transaction_store_id FROM ( SELECT sku_id, group_id, transaction_store_id, ROW_NUMBER() OVER ( PARTITION BY (transaction_store_id, group_id) ORDER BY sku_retail_price - sku_purchase_price ) r_n FROM stores JOIN sku USING (sku_id) ORDER BY transaction_store_id, group_id, r_n ) t WHERE r_n <= number_of_groups ) sku_max_margin JOIN customers ON transaction_store_id = customer_primary_store JOIN groups USING (customer_id, group_id) JOIN ( SELECT sku_id, group_id, count_t_sku / count_t_group::decimal sku_share_in_group FROM ( SELECT sku_id, COUNT (DISTINCT transaction_id) AS count_t_sku FROM checks GROUP BY sku_id ) t1 JOIN sku USING (sku_id) JOIN ( SELECT group_id, COUNT (DISTINCT transaction_id) count_t_group FROM checks JOIN sku USING (sku_id) GROUP BY group_id ) t2 USING (group_id) ) sku_share USING (sku_id, group_id) JOIN stores USING (sku_id, transaction_store_id) WHERE sku_share_in_group < maximum_SKU_share AND group_churn_rate <= maximum_churn_index AND group_stability_index < maximum_consumption_stability_index ) ttt JOIN sku USING (sku_id) JOIN periods ON ttt.customer_id = periods.customer_id AND ttt.group_id = periods.group_id WHERE ttt.Offer_Discount_Depth <= CEIL(group_min_discount * 20) / 20 ORDER BY ttt.customer_id, ttt.group_id; END; $$ LANGUAGE 'plpgsql';