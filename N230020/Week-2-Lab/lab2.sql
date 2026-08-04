#PART A
use gram_panchayat_db;
show tables;


#PART B built-in-strings)
#level 1
select upper(full_name) from citizen;
select lower(village_name) from citizen;
select length(full_name) from citizen;
select left(reference_number,4) as first_four_characters from certificate_application;
select concat(full_name,'-',village_name) from citizen;

#level 2
select replace(certificate_name,'Certificate','Cert.') from certificate_application;
select trim(certificate_name) as certificate_name from certificate_application;
select substring_index(full_name,' ',1) as first_name from citizen;

#level 3
select concat('citizen: ',full_name,'\nvillage:',village_name) as display_string from citizen;
select * from certificate_application where left(reference_number,6)='GP2026';


#PART C
#level 1
select round(fee_paid) from certificate_application;
select abs(processing_days -10) as absolute_diff from certificate_type;
select POWER(processing_days,2) as square from certificate_type;

#level 2
select mod(processing_days,3) as remainder from certificate_type;
select round(application_fee,1) as rounded_fee from certificate_type;
select ceil(application_fee) as ceiling_value,floor(application_fee) as flloring_value from certificate_type;

#level 3
select floor(rand()*(100-1+1))+1;
select sqrt(processing_days) as sqr_root from certificate_type;
select processing_days *2 as mult_2 from certificate_type;

#####PART D
#level 1
select curdate();
select now();
select year(application_date) from certificate_application;
select month(application_date) from certificate_application;
select dayname(application_date) from certificate_application;

#level 2
select date_add(application_date,interval processing_days day) as expected_issue_date from certificate_type,certificate_application;
select date_add(application_date,interval 30 day ) as adding from certificate_application; 
select date_sub(application_date,interval 7 day ) as subtracting from certificate_application; 

#level 3
select datediff(curdate(),application_date) as diff from certificate_application;
select * from certificate_application where year(application_date)=year(curdate());
select * from certificate_application where application_status='submitted';

##PART E
#level 1
select convert(fee_paid,signed) from certificate_application;
select convert(processing_days,char) from certificate_type;

#level 2
select convert(application_date,datetime) from certificate_application;
select convert(processing_days,decimal) from certificate_type;

#level 3
select convert(fee_paid,char) as fee_string from certificate_application;
select convert(fee_paid,signed)+10 as total_fee from certificate_application;