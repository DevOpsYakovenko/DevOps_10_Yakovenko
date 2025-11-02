const request = require("supertest");
const server = require("../index");

describe("App basic test", () => {
  it("should respond with 200 OK", async () => {
    const response = await request(server).get("/");
    expect(response.statusCode).toBe(200);
    server.close();
  });
});
