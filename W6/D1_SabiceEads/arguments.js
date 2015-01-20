function sum() {
  var args = [].slice.call(arguments);

  var sum = 0;

  for(var i = 0; i < args.length; i++) {
    sum += args[i];
  }

  return sum;
};

Function.prototype.myBind = function(ctx) {
  var fn = this;
  var outerArgs = [].slice.call(arguments, 1);

  return function(){
    var innerArgs = [].slice.call(arguments, 0);
    return fn.apply(ctx, outerArgs.concat(innerArgs));
  };
};

function Person(name) {
  this.name = name;
};

function sayHi(){
  console.log(this.name + " says hi.");
  console.log([].slice.call(arguments));
};

function curriedSum(numArgs){
  var numbers = [];
  function _curriedSum(num){
    numbers.push(num);
    if(numbers.length === numArgs){
      var sum = 0;
      for(var i=0; i < numArgs; i++){
        sum += numbers[i];
      }
      return sum;
    } else{
      return _curriedSum;
    }
  }

  return _curriedSum;
};


// console.log(curriedSum(3)(2)(3)(4));


Function.prototype.myCurry = function(numArgs){
  var fn = this;
  var outerArgs = [];

  return function _curry(){
    outerArgs.push([].slice.call(arguments, 0, 1)[0]);
    if(outerArgs.length === numArgs){
      return fn.apply({}, outerArgs);
    } else {
      return _curry;
    }
  };

  return _curry;
};
