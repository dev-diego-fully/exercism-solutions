#include "grade_school.h"

namespace grade_school {

bool school::add(std::string student_name, int grade) {
  if (is_already_registred(student_name)) {
    return false;
  }
  this->registred_students.insert(student_name);
  this->students_by_grade[grade].push_back(student_name);
  return true;
}

std::vector<std::string> school::grade(int value) const {
  if (!is_grade_initialized(value)) {
    return {};
  }
  std::vector<std::string> in_grade = this->students_by_grade.at(value);
  std::sort(in_grade.begin(), in_grade.end());
  return in_grade;
}

std::map<int, std::vector<std::string>> school::roster() const {
  std::map<int, std::vector<std::string>> roster_;
  for (const auto &pair : this->students_by_grade) {
    int key = pair.first;
    roster_[key] = this->grade(key);
  }
  return roster_;
}

bool school::is_already_registred(std::string name) const {
  return (this->registred_students.find(name) !=
          this->registred_students.end());
}

bool school::is_grade_initialized(int grade) const {
  return this->students_by_grade.find(grade) != this->students_by_grade.end();
}

} // namespace grade_school
