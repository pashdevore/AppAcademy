var readline = require('readline');

var reader = readline.createInterface(
  process.stdin,
  process.stdout,
  null
);

function addNumbers(sum, numsLeft, completionCallback){
  if (numsLeft > 0) {
    reader.question(("Enter a number: "), function(number){
      var n = parseInt(number);
      sum += n;
      console.log("Total: " + sum);
      addNumbers(sum, numsLeft, completionCallback);
    })
  } else {
    completionCallback(sum);
    reader.close();
  }

  numsLeft--;
}



addNumbers(0, 3, function completionCallback(sum) {
  console.log("Final sum: " + sum);
});
