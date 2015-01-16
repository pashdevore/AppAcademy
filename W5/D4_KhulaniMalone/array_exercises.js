Array.prototype.unique = function unique(){
    var uniq_arr = [];
    for(var i = 0; i < this.length; i++){
        if(uniq_arr.indexOf(this[i]) == -1){
            uniq_arr.push(this[i]);
        }
    }

    return uniq_arr;
}

Array.prototype.twoSum = function twoSum() {
  var twoSums = [];
  for(var i=0; i<this.length-1; i++) {
    for(var j=i+1; j<this.length; j++) {
      if( this[i] + this[j] == 0){
        twoSums.push([i,j]);
      }
    }
  }
  return twoSums;
}

Array.prototype.transpose = function () {
  var array = this
  for(var i=0; i<this.length; i++){
    for(var j=i; j<this.length; j++){
      temp = array[i][j]
      array[i][j] = this[j][i];
      this[j][i] = temp;
    }
  }
  return array
}


console.log([1,2,2,4,6,6,7,7,7].unique());
console.log([-1, 0, 2, -2, 1].twoSum());

console.log([
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
  ].transpose());
