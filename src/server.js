const express = require("express");

const app = express();
const PORT = 5000;
function add(a, b) {
  return a + b;
}
app.get("/", (req, res) => {
  res.send("Hello from Node.js server");
});

app.get("/users", (req, res) => {
  res.json([
    { Name: "Randy", age: "33" },
    { Name: "Randy", age: "33" },
    { Name: "Randy", age: "33" }
  ]);
});

app.listen(PORT, () => {
  console.log(`Node server is runnnin on http://localhost:${PORT}`);
});

module.exports = add;
