
TRUNCATE statement_moneyin_data

SELECT  *
FROM `statement_moneyin_data` ; 

-- Get duplicate receipts
SELECT   receipt_no  , COUNT(id ) cnt 
FROM `statement_moneyin_data` 
GROUP BY  receipt_no
HAVING cnt > 1 ;


SELECT  *
FROM statement_moneyin_data stmtd  ,   (SELECT   receipt_no  ,MIN(id ) min_id , COUNT(id ) cnt 
FROM `statement_moneyin_data` 
GROUP BY  receipt_no
HAVING cnt > 1 ) sub_st 
WHERE stmtd.receipt_no =  sub_st.receipt_no
AND stmtd.id != min_id; 

-- Remove duplicate
DELETE  stmtd FROM statement_moneyin_data stmtd  ,   (SELECT   receipt_no  ,MIN(id ) min_id , COUNT(id ) cnt 
FROM `statement_moneyin_data` 
GROUP BY  receipt_no
HAVING cnt > 1 ) sub_st 
WHERE stmtd.receipt_no =  sub_st.receipt_no
AND stmtd.id != min_id; 

UPDATE statement_moneyin_data SET 
`receipt_no` = TRIM(IF(receipt_no = '' , NULL , receipt_no)),
`detail` = TRIM(IF(detail = '' , NULL , detail)),
`transaction_status` = TRIM(IF(transaction_status = '' , NULL , transaction_status)),
`transaction_type`= TRIM(IF(transaction_type = '' , NULL , transaction_type)),
`other_party`= TRIM(IF(other_party = '' , NULL , other_party));



SELECT  id  , receipt_no , detail,transaction_type,IF((INSTR(detail,'NICKY KALU') = 0 AND detail IS NOT NULL),  SUBSTR(detail, 1,INSTR(detail ," ")) , 'Owner' ) trans_type  , 
 `transaction_status`,`paid_in`,`withdrawn`,`balance`,`transaction_type`,`other_party` ,INSTR(detail ," ")  pos
 FROM statement_moneyin_data;


-- dataSet one 
SELECT  id  , receipt_no , detail,transaction_type,IF((INSTR(detail,'NICKY KALU') = 0 AND detail IS NOT NULL),  SUBSTR(detail, 1,INSTR(detail ," ")) , 'Owner' ) trans_type  , 
 `transaction_status`,`paid_in`,`withdrawn`,`balance`,`transaction_type`,`other_party` 
 FROM statement_moneyin_data;
