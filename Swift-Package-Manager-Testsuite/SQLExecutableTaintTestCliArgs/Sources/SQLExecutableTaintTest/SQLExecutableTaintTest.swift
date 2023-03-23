import SQLite

@main
public struct SQLExecutableTaintTest {
    public static func main() throws {
        
        // user input used for the SQL Query
        let args = CommandLine.arguments

        let userName = args[0] // "'Alice'"
        let password = args[1] // "'attack' OR 1=1;"

        let db = try Connection() // in-memory database        

        let queryStringName = "SELECT * FROM users WHERE name=" + 
                                    userName + 
                                    " AND password="

        let queryString = queryStringName + password

        let stmt = try db.prepare(queryString) // sink

        // we should only find a taint flow if the tainted statement
        // is run. We could use an additional typestate analysis
        // to determine this.
        try stmt.run() 
    }
}
