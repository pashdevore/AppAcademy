function range(start, end){
  var arr = []

  if(start <= end){
    arr.push(start);
    return arr.concat(range(start+1, end));
  }
  else{
    return arr;
  }
};

function exp(base, num){
  if(num == 0){
    return 1;
  }
  else{
    return (base * exp(base, num - 1));
  }
};

function fib(num){
  var fibs = []

  if(num == 0){
    fibs.push(0);
    return fibs;
  }
  else if(num == 1){
    fibs = fib(num - 1);
    fibs.push(1);
    return fibs;
  }
  else{
    fibs = fib(num - 1);
    fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);
    return fibs;
  }
};

Array.prototype.bSearch = function(target){
  mid = Math.floor(this.length/2);
  if(this[mid] == target){
    return mid;
  } else if (this.length == 1) {
    return null;
  } else if ( this[mid] > target ) {
    return this.slice(0, mid).bSearch(target);
  } else {
    return (mid + 1) + this.slice(mid+1, this.length).bSearch(target);
  }
};


// function bestChange(amount, values){
//   best = [];
//   for(var i=0; i<values.length; i++){
//     new_values = values.slice(i,values.length);
//     new_amount = amount;
//     change = []
//     //----
//
//     current_coin = values[0];
//     if (amount == 0) {
//       return change;
//     }
//     else if (current_coin <= amount) {
//       change.push(current_coin);
//       amount -= current_coin;
//       return change.concat(makeChange(amount, values));
//     } else {
//       values.shift();
//       return makeChange(amount, values);
//     }
//
//     //-----
//     if (i == 0){
//       best = change;
//     }
//     else if (best.length > change.length) {
//       best = change;
//     }
//   }
//   return best;
// }

function makeChange(amount, values){
  
  var change = [];
  var current_coin = values[0];
  if (amount == 0) {
    return change;
  }
  else if (current_coin <= amount) {
    change.push(current_coin);
    amount -= current_coin;
    return change.concat(makeChange(amount, values));
  } else {
    values.shift();
    return makeChange(amount, values);
  }
};


Array.prototype.merge = function(left, right){
  var merged = [];

  while(left.length > 0 && right.length > 0){
    merged.push((left[0] < right[0]) ? left.shift() : right.shift());
  }

  return merged.concat(left).concat(right);
}

Array.prototype.mergeSort = function() {
  if (this.length < 2){
    return this;
  } else {
    var mid = Math.floor(this.length / 2);
    var left = this.slice(0, mid);
    var right = this.slice(mid, this.length);

    left = left.mergeSort();
    right = right.mergeSort();

    return this.merge(left, right);
  }
}

function subsets( arr ){
  if (arr.length == 0){
    return [[]];
  } else {
    var el = arr.pop();
    var subs_before = subsets(arr);
    var subs_plus = [];
    subs_before.forEach(function(subset) {
      subs_plus.push(subset.concat(el))
    });
    return subs_plus.concat(subs_before);
  }
}

console.log(range(1, 10));
console.log(exp(2, 5));
console.log(fib(12));
console.log([1,3,5,6,7,8,9].bSearch(8));
console.log(makeChange(74, [25,10,5,1]));
console.log(makeChange(14, [10, 7, 1]));
// console.log(bestChange(14, [10,7,1]));

console.log([5,7,2,3,7,8,1].mergeSort());
console.log(subsets([1,2,3]));
