// init failed, fixed later

const rootUser = process.env.MONGO_INITDB_ROOT_USERNAME;
const rootPassword = process.env.MONGO_INITDB_ROOT_PASSWORD;
const user = process.env.MONGO_USER;
const password = process.env.MONGO_PASSWORD;
const database = process.env.MONGO_DB;

db = db.getSiblingDB('admin');

// just for ensure
db.createUser({
  user: rootUser,
  pwd: rootPassword,
  roles: ["root"]
});

// switch to the zoo
db = db.getSiblingDB(database);

// create a new user with read-write access
db.createUser({
  user: user,
  pwd: password,
  roles: [
    {
      role: "readWrite",
      db: database
    }
  ]
});

db.myCollection.insertMany([
  { name: "monkey", age: 22, role: "CEO" },
  { name: "dog", age: 22, role: "Developer" },
  { name: "cow", age: 22, role: "Eunuch" },
]);
