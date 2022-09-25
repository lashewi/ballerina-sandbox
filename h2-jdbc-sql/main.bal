import ballerinax/java.jdbc;
import ballerina/sql;
import ballerina/log;

//refactored code
function addEmployeeRefactored(string dbFilePath, string name, string city, string department, int age) returns int {
    do {
	    jdbc:Client jdbcClient = check new ("jdbc:h2:" + dbFilePath, "root", "root");
        sql:ExecutionResult|sql:Error result = jdbcClient->execute(`INSERT INTO Employee(name,city,department,age) 
                                                                VALUES ( ${name}, ${city},${department}, ${age})`);

        if result is sql:Error {
            log:printError(result.message());
            return -1;
        }

        return <int>result?.lastInsertId;

    } on fail var e {
        log:printError(e.message());
    	return -1;
    }
}


function addEmployee(string dbFilePath, string name, string city, string department, int age) returns int {
    do {
	    jdbc:Client jdbcClient = check new ("jdbc:h2:" + dbFilePath, "root", "root");
        sql:ExecutionResult result = check jdbcClient->execute(`INSERT INTO Employee(name,city,department,age) 
                                                                VALUES ( ${name}, ${city},${department}, ${age})`);

        return <int>result?.lastInsertId;

    } on fail var e {
        log:printError(e.message());
    	return -1;
    }
}
