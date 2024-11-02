#include <algorithm>
#include <map>
#include <set>
#include <string>
#include <vector>
#if !defined(GRADE_SCHOOL_H)
#define GRADE_SCHOOL_H

namespace grade_school {

class school {

private:
  std::map<int, std::vector<std::string>> students_by_grade;
  std::set<std::string> registred_students;
  bool is_already_registred(std::string name) const;
  bool is_grade_initialized(int grade) const;

public:
  bool add(std::string student_name, int grade);
  std::vector<std::string> grade(int value) const;
  std::map<int, std::vector<std::string>> roster() const;
};

} // namespace grade_school

#endif // GRADE_SCHOOL_H