var globalObject = typeof self !== "undefined" ? self :
    typeof window !== "undefined" ? window :
    typeof global !== "undefined" ? global :
    this !== undefined ? this : null;

var window1 = globalObject;
function testFunction() {
  console.log("sssssssssssssssssssssss");
  console.log(window1.CruxPay);
  return "The function returns the product of p1 and p2"
}
