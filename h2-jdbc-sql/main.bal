import ballerinax/java.jdbc;
import ballerina/sql;

function addEmployee(string dbFilePath, string name, string city, string department, int age) returns int {
    do {
	    jdbc:Client jdbcClient = check new ("jdbc:h2:" + dbFilePath, "root", "root");
        sql:ExecutionResult result = check jdbcClient->execute(`INSERT INTO Employee(name,city,department,age) 
                                                                VALUES ( ${name}, ${city},${department}, ${age})`);

        return <int>result?.lastInsertId;

    } on fail var e {
        error? cause = e.cause();
    	return -1;
    }
}
