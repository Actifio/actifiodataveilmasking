*/ The location of the jar file may need to be changed
*/ The SCHEMA name needs to match the one being used by the DataVeil profile

exec dbms_java.loadjava('-verbose -synonym -grant PUBLIC /opt/dataveil/native/oracle/DVNative.jar');
ALTER SESSION SET CURRENT_SCHEMA = scott;
@setup_functions.sql
exit;
