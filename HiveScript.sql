
!connect jdbc:hive2://localhost:10000 scott tiger org.apache.hive.jdbc.HiveDriver 

create database raul_db;

use raul_db;

create table tpa_data (Player INT, PlayerType STRING, PlayerName STRING, JudgeAge INT, JudgeGender STRING, JudgeLevel INT, JudgeEXP STRING, JudgeEDU STRING, JudgeJOB STRING, Guess STRING, Humanness INT, Machinness INT, GuessReason STRING) 
row format delimited
fields terminated by '\;'
lines terminated by '\n'
stored as textfile;
