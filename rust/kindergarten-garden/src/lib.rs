/// Returns a vector containing the plants that are under the responsibility
/// of the given student.
pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    let student_index = student_index(student);

    get_diagram_lines(diagram)
        .flat_map(|line: &str| get_plants_from_line(line, student_index))
        .collect()
}

/// Returns an iterator containing the lines of the given diagram. These
/// lines are obtained with a string split operation.
fn get_diagram_lines(diagram: &str) -> impl Iterator<Item = &str> {
    diagram.split("\n")
}

/// Returns an iterator containing the plants, which are in the given line,
/// that are under the responsibility of the student with the given index.
fn get_plants_from_line(line: &str, student_index: usize) -> impl Iterator<Item = &'static str> {
    let index_a = 2 * student_index;
    let index_b = 2 * student_index + 1;

    let plant_a = line.chars().nth(index_a).unwrap();
    let plant_b = line.chars().nth(index_b).unwrap();

    vec![plant_from_initial(plant_a), plant_from_initial(plant_b)].into_iter()
}

/// Maps an initial to a plant name. Used to obtain the name of a plant,
/// given a "slot" in the diagram.
fn plant_from_initial(initial: char) -> &'static str {
    match initial {
        'G' => "grass",
        'C' => "clover",
        'R' => "radishes",
        'V' => "violets",
        _ => "",
    }
}

/// Given a student's name, return the index that the student occupies in
/// the list of students. This is calculated using the initial letter of the student's name.
fn student_index(name: &str) -> usize {
    let initial = name.chars().next().unwrap();
    initial as usize - 'A' as usize
}
