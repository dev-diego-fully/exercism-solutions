--- A class representing a school, used to manage a list of students and their grades.
--- @class School
--- @field _students table<string, integer> A private table mapping student names to their corresponding grades.
local School <const> = {}

--- Creates a new `School` instance.
--- @return School -- The newly created `School` object.
function School:new()
    return setmetatable({ _students = {} }, School)
end

--- Adds a student with their name and grade to the school's roster.
--- @param self School
--- @param name string The name of the student.
--- @param grade integer The grade of the student.
--- @return boolean -- `true` if the student was added successfully, `false` if a student with
--- the same name already exists.
function School.add(self, name, grade)
    if self._students[name] ~= nil then
        return false
    end
    self._students[name] = grade
    return true
end

--- Returns a sorted list of all students on the school's roster.
--- The list is sorted primarily by grade in ascending order. Students in the same grade are
--- sorted alphabetically by name.
--- @param self School
--- @return string[] -- A table containing the names of all students.
function School.roster(self)
    local result <const> = {}

    for name, _ in pairs(self._students) do
        table.insert(result, name)
    end

    table.sort(result, function(a, b)
        if self._students[a] < self._students[b] then
            return true
        elseif self._students[a] == self._students[b] then
            return a < b
        else
            return false
        end
    end)

    return result
end

--- Returns a sorted list of all students in a specific grade.
--- The list is sorted alphabetically by student name.
--- @param self School
--- @param target integer The target grade to retrieve students from.
--- @return string[] -- A table containing the names of the students in the specified grade.
function School.grade(self, target)
    local result <const> = {}

    for name, grade in pairs(self._students) do
        if grade == target then
            table.insert(result, name)
        end
    end

    table.sort(result)

    return result
end

--- The `__index` metamethod ensures that method calls on `School` instances are correctly
--- redirected to the `School` class table.
School.__index = School

return School
