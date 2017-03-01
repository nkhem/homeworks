class Cat {
  constructor (name) {
    this.name = name;
    this.sayHello = () =>{
      return this.name + " says hello!";
    };
  }
}

let sally = new Cat("Sally");
let markov = new Cat("Markov");
let curie = new Cat("Curie");

Function.prototype.myBind = function(args) {
  args = Array.from(args);
  return this(args);
};

console.log(sally.sayHello.myBind(sally));
