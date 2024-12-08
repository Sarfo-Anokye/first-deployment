const add = require("./server.js");

describe("add function", () => {
  test("should return the sum of two positive numbers", () => {
    expect(add(2, 3)).toBe(5);
  });

  test("should return the sum of a positive and negative number", () => {
    expect(add(5, -3)).toBe(2);
  });

  test("should return 0 when both arguments are 0", () => {
    expect(add(0, 0)).toBe(0);
  });

  test("should handle floating point numbers", () => {
    expect(add(1.5, 2.5)).toBe(4);
  });
});
