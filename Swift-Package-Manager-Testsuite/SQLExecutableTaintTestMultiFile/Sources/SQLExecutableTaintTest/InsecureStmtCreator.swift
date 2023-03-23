func getLoginStmt(userName: String, password: String) -> String {
        let queryStringName = "SELECT * FROM users WHERE name=" + 
                                        userName + 
                                        " AND password="

        let queryString = queryStringName + password

        return queryString
}