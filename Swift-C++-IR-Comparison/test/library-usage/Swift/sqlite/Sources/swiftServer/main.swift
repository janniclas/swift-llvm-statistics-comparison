import SQLite

let table = Table("users")
let name = Expression<String>("name")
let email = Expression<String>("email")
let id = Expression<Int64>("id")
let password = Expression<String>("password")

let db = try Connection()
// create table
try db.run(
    table.create(ifNotExists: true) { t in
        t.column(id, primaryKey: true)  //     "id" INTEGER PRIMARY KEY NOT NULL,
        t.column(email, unique: true)  //     "email" TEXT UNIQUE NOT NULL,
        t.column(name)
        t.column(password)
    })

try db.run(table.insert(email <- "alice@mac.com", name <- "Alice", password <- "SECRET"))

for row in try db.prepare(table) {
    print(row[name])
    print(row[password])
    print(row[id])
}

let nameInput = "'Alice'"
let passwordInput = "'test' OR 1=1;"

let queryString = "SELECT * FROM users WHERE name=" + nameInput + " AND password=" + passwordInput

let stmt = try db.prepare(queryString)

for row in stmt {
    print("Successful sql injection")
    for (index, name) in stmt.columnNames.enumerated() {
        print("\(name):\(row[index]!)")

    }
}

let correctQuery = table.filter(name == nameInput).filter(password == passwordInput)

for row in try db.prepare(correctQuery) {
    print("no results expected")
    print(row)
}
