Array.prototype.bubbleSort = function() {
  sorted = false
  while (!sorted) {
    sorted = true;
    for(var i=0; i<this.length-1;i++){
      if(this[i] > this[i+1]){
        temp = this[i];
        this[i] = this[i+1];
        this[i+1] = temp;
        sorted = false;
      }
    }
  }
  return this;
}

String.prototype.substrings = function(){
  subs_arr = []

  for(var i = 0; i < this.length; i++){
    for(var j = i + 1; j < this.length + 1; j++){
      subs_arr.push(this.substring(i, j));
    }
  }

  return subs_arr;
}

console.log([5,3,1,6,5,2].bubbleSort());
console.log("cat".substrings());
