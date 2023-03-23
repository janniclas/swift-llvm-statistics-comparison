import SQLite

@main
public struct SQLExecutableTaintTest {
    public static func main() throws {
        
        let db = try Connection() // in-memory database        

        // nameInput and passwordInput represent possible user input 
        // and are assumed to be received from external inputs
        let nameInput = "'Alice'"
        let passwordInput = getPassword() // source 

        let queryStringName = "SELECT * FROM users WHERE name=" + 
                                        nameInput + 
                                        " AND password="

        let queryString = queryStringName + passwordInput

        let stmt = try db.prepare(queryString) // sink

        // we should only find a taint flow if the tainted statement
        // is run. We could use an additional typestate analysis
        // to determine this.
        try stmt.run() 
    }

    // this method represents possible user input
    public static func getPassword() -> String {
        return "'test' OR 1=1;" // this is why user input is dangerous
    }
}
