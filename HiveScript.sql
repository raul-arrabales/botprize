
HADOOP

hadoop fs -ls

hadoop fs -mkdir /botprize 

hadoop fs -put Desktop/botprize/TPA_Data_v2.csv /botprize/TPA_Data_v2.csv

hadoop fs -ls /botprize 




BEELINE

!connect jdbc:hive2://localhost:10000 scott tiger org.apache.hive.jdbc.HiveDriver 


HIVE 

create database raul_db;

use raul_db;

create table tpa_data (Player INT, PlayerType STRING, PlayerName STRING, JudgeAge INT, JudgeGender STRING, JudgeLevel STRING, JudgeEXP STRING, JudgeEDU STRING, JudgeJOB STRING, Guess STRING, Humanness INT, Machinness INT, GuessReason STRING) 
row format delimited
fields terminated by '\;'
lines terminated by '\n'
stored as textfile;

LOAD DATA LOCAL INPATH 'Desktop/botprize/TPA_Data_v2.csv' INTO TABLE tpa_data;

load data inpath '/botprize/TPA_Data_v2.csv' overwrite into table tpa_data;

show databases;

show tables;

select * from raul_db.tpa_data;


select * from raul_db.tpa_data where Player=6;

desc tpa_data;



select tpa_data.GuessReason from tpa_data where tpa_data.Guess='Human';
select tpa_data.GuessReason from tpa_data where tpa_data.Guess='Machine';


