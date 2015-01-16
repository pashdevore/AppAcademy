Array.prototype.myEach = function(func){
  for(var i=0; i<this.length; i++){
    func(this[i]);
  }
  return this;
};

Array.prototype.myMap = function(func){
  arr = [];
  this.myEach(function(num){
    arr.push(func(num))
  });
  return arr;
};

Array.prototype.myInject = function(func){
  accum = 0;
  this.myEach(function(num){
    accum += func(num);
  });
  return accum;
};

[1,2,3,4,5].myEach(function(num){ console.log(num*2); });
console.log([1,2,3,4,5].myMap(function(num){ return num*2; }));
console.log([1,2,3,4,5].myInject(function(num){ return num; }));
