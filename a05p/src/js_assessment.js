// write myFind(array, callback). It should return the first element for which
// callback returns true, or undefined if none is found.

const myFind = function(array, callback) {
  for (var i = 0; i < array.length; i++) {
    if (callback(array[i])) {
      return array[i];
    }
  }
};

// write sumNPrimes(n)

const sumNPrimes = function(num) {
  if (num < 1) {
    return 0;
  }
  let arr = [];
  for (var i = 2; arr.length < num; i++) {
    if(isPrime(i)){
      arr.push(i);
    }
  }

  return arr.myReduce((acc, n) => { return (acc + n); });
};


const isPrime = function(num) {
  if(num < 2) {
    return false;
  }

  for (var i = 2; i < num; i++) {
    if (num % i === 0){
      return false;
    }
  }

  return true;
};

// write Function.prototype.myBind.

Function.prototype.myBind = function(context, ...bindArgs) {
  return (...callArgs) => {
    return this.apply(context, bindArgs.concat(callArgs));
  };
};

// write Function.prototype.inherits.

Function.prototype.inherits = function(parentClass){
  const Surrogate = function(){};
  Surrogate.prototype = parentClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

// write String.prototype.mySlice. It should take a start index and an
// (optional) end index.

String.prototype.mySlice = function(startIndex, endIndex = this.length) {
  let arr = [];
  for (var i = startIndex; i < endIndex; i++) {
    arr.push(this[i]);
  }
  return arr.join("");
};

// write Array.prototype.myReduce (analogous to Ruby's Array#inject).
Array.prototype.myReduce = function(callback) {
  let acc = this[0];
  let i = 1;
  for (i; i < this.length; i++) {
    acc = callback(acc, this[i]);
  }
  return acc;
};

// write Array.prototype.quickSort(comparator). Here's a quick refresher if
// you've forgotten how quickSort works:
//   - choose a pivot element from the array (usually the first)
//   - for each remaining element of the array:
//     - if the element is less than the pivot, put it in the left half of the
//     array.
//     - otherwise, put it in the right half of the array.
//   - recursively call quickSort on the left and right halves, and return the
//   full sorted array.


Array.prototype.quickSort = function(comparator) {
  if(this.length < 2) return this;

  if (typeof comparator !== "function") {
    comparator = (x, y) => {
      if (x === y) {
        return 0;
      } else if (x < y) {
        return -1;
      } else {
        return 1;
      }
    };
  }

  const pivot = this[0];
  const left = [];
  const right = [];

  for (let i = 1; i < this.length; i++) {
    if (comparator(this[i], pivot) === -1){
      left.push(this[i]);
    } else {
      right.push(this[i]);
    }
  }

  return left.quickSort(comparator).
  concat([pivot]).
  concat(right.quickSort(comparator));
};

// console.log([1,2,7].mergeSort([3,4,5], (x, y) => {
//   if (x === y) {
//     return 0;
//   } else if (x < y) {
//     return 1;
//   } else {
//     return -1;
//   }
// }));

Array.prototype.mergeSort = function(
  comparator = (x, y) => {
    if (x === y) {
      return 0;
    } else if (x < y) {
      return 1;
    } else {
      return -1;
    }
  }, rollover = 0){

    if(this.length < 2){return this;}
    let pivotIndex = Math.floor(this.length / 2);
    let left = this.slice(0, pivotIndex).mergeSort(comparator);
    let right = this.slice(pivotIndex).mergeSort(comparator, rollover = pivotIndex);
    console.log(left);
    console.log(right);
    return left.mergeSort(right, comparator);
  };

  Array.prototype.merge = function(right, comparator){

    let left = this;
    let result = [];
    console.log(comparator);

    while((left.length > 0) && (right.length > 0)) {
      if (comparator(left[0], right[0]) === 0){
        result.push(left[0]);
        left = left.slice(1);
      } else if (comparator(left[0], right[0]) === 1){
        result.push(left[0]);
        left = left.slice(1);
      } else {
        result.push(right[0]);
        right = right.slice(1);
      }
    }

    return result.concat(left).concat(right);
  };

  console.log([1,2,7].merge([3,4,5]));
