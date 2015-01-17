var readline = require('readline');

var reader = readline.createInterface(
  process.stdin,
  process.stdout,
  null
);

function askIfLessThan(el1, el2, callback) {
    reader.question(("Is " + el1 + " less than " + el2 + "? (y/n): "),
    function (comparison) {
      if (comparison == 'y') {
        callback(true);
      } else {
        callback(false);
      }
    });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i == (arr.length - 1)) {
    outerBubbleSortLoop(madeAnySwaps);
    return;
  }


    console.log(i);
    askIfLessThan(arr[i], arr[i + 1], function(isLessThan){
      if (!isLessThan) {
        temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        madeAnySwaps = true;
      }

      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });

}

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps === true) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
