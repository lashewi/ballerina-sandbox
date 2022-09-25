import ballerinax/java.jdbc;

function getHighPaymentEmployees(string dbFilePath, decimal amount) returns string[]|error {
    //Add your logic here
    string[] response = [];

    //hanlde and log erros
    do {
	    jdbc:Client jdbcClient = check new ("jdbc:h2:" + dbFilePath, "root", "root");

        stream<Payment, error?> resultStream = jdbcClient->query(`SELECT DISTINCT e.name as employee_name FROM Employee e 
        LEFT JOIN Payment p ON e.employee_id = p.employee_id
        WHERE p.amount > ${amount} ORDER BY e.name ASC `);

        check from Payment payment in resultStream
        do {
            response.push(payment.employee_name);
        };
        
        check resultStream.close();
        return response;
    } on fail var e {
    	return e;
    }
}

type Payment record {
    string employee_name;
};