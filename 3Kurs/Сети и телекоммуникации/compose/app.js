const http = require("http");

http.createServer((req, res) => {
    console.log(`Request on port ${process.env.PORT} request ${req.url}`);
    res.end(process.env.HELLO_MESSAGE);
}).listen(process.env.PORT || 3000, () => { console.log(`App running on port ${process.env.PORT}`)});
