SELECT * FROM bank_loan_data
--Toal loan applications 
SELECT COUNT(id) AS total_loan_applications
FROM bank_loan_data;

--MTD Loan Applications 
SELECT COUNT(id) AS MTD_loan_applications FROM bank_loan_data
WHERE EXTRACT(month FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

--PMTD loan applcation
SELECT COUNT(id) as Total_applications FROM bank_loan_data 
WHERE EXTRACT(MONTH FROM issue_date) =11 ;

--total funded applications 
SELECT SUM(loan_amount) as total_funded_amount FROM bank_loan_data;

--MTD total funded amount
SELECT SUM(loan_amount) as MTD_funded_amount FROM bank_loan_data
WHERE EXTRACT (MONTH FROM issue_date) = 12;

--PMTD total funded amount 
SELECT SUM(loan_amount)as total_funded_amount from bank_loan_data
WHERE EXTRACT (MONTH FROM issue_date) = 11;

--total amount recieved 
SELECT SUM(total_payment) AS total_amount_collected FROM bank_loan_data;

--MTD total amount recieved 
SELECT SUM(total_payment) AS total_amount_collected FROM bank_loan_data
where EXTRACT(MONTH FROM issue_date)= 12;

--PMTD total amount recieved 
SELECT SUM(total_payment) AS total_amount_collected FROM bank_loan_data
where EXTRACT(MONTH FROM issue_date)= 11;


--average intrest rate  
SELECT AVG(int_rate)*100 as avg_intrest_rate FROM bank_loan_data;  --multipy by 100 to get value in percentage.

--MTD average intrest rate
SELECT AVG(int_rate)*100 as avg_intrest_rate FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date)= 12; 

--PMTD average intrest rate 
SELECT AVG(int_rate)*100 as avg_intrest_rate FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date)= 11; 

--Average DTI 
SELECT AVG(dti)*100 AS avg_DTI FROM bank_loan_data;

--MTD avg DTI 
SELECT AVG(dti)*100 AS avg_DTI FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date)= 12;

--PMTD avg DTI 
SELECT AVG(dti)*100 AS avg_DTI FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date)= 11;

--Good loan issued 
--percentage 
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

--good loan application
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--good loan funded amount 
Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--good loan amount received 
SELECT SUM(total_payment) AS Good_Loan_amount_received 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--BAD LOAN 
--Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

--Bad loan application 
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'


--bad loan funded amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--bad loan amount received 
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--bad loan percentage 
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- LOAN STATUS GRID VEIW 
SELECT loan_status,
COUNT (id) AS total_loan_application,
SUM (total_payment) AS total_amount_received,
SUM(loan_amount) AS total_funded_amount,
AVG(int_rate * 100) AS interest_rate,
AVG(dti*100) AS DTI
FROM bank_loan_data
GROUP BY loan_status;

--MTD loan status 
SELECT 
	loan_status, 
     SUM(total_payment) AS MTD_Total_Amount_Received, 
     SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT (MONTH FROM issue_date) = 12
GROUP BY loan_status;

--loan report (month)
SELECT 
    EXTRACT(MONTH FROM issue_date) AS month_number, 
    TO_CHAR(issue_date, 'Month') AS month_name, 
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY EXTRACT(MONTH FROM issue_date), TO_CHAR(issue_date, 'Month')
ORDER BY month_number;

--STATE 
	SELECT address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

--term
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

--employee length
SELECT emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

--PURPOSE 
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

--HOMEOWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;







