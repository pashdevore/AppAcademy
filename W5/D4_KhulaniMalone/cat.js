function Cat(name, owner){
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function(){
  return (this.owner + " loves " + this.name);
};

Cat.prototype.meow = function(){
  return "meow...";
};

c = new Cat("Mimi", "Bob");
c2 = new Cat("Garfield", "John");
Cat.prototype.cuteStatement = function(){
  return ("Everyone loves " + this.name);
};

c.meow = function() {
  return "I meow louder...bitch!"
};

console.log(c);
console.log(c2);
console.log(c.meow());
console.log(c2.meow());
console.log(c.cuteStatement());
console.log(c2.cuteStatement());
