function Student( f_name, l_name) {
  this.f_name = f_name;
  this.l_name = l_name;
  this.courses = [];
}

function Course( name, dept, credits ) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.students = []
}

Student.prototype.name = function() {
  return this.f_name + ' ' + this.l_name;
};

Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) == -1) {
    this.courses.push(course);
    course.students.push(this);
  }
}

Student.prototype.courseLoad = function() {
  var temp = {};

  this.courses.forEach(function(course){
    console.log(course);
    if(!temp[course.dept]) {
      temp[course.dept] = course.credits;
    } else {
      temp[course.dept] += course.credits;
    }
  });
  return temp;
}

Course.prototype.addStudent = function(student){
  student.enroll(this);
}

s = new Student("John", "Arbuckle");
c = new Course("Cats 101", "Science", 3);
c2 = new Course("Dating 101", "Science", 4);

s.enroll(c);
s.enroll(c2);

console.log(s.courseLoad());

console.log(s.courses);
console.log(c.students);
