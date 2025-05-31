pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    let student_index = student_index(student);
    
    get_diagram_lines(diagram)
        .flat_map(|line: &str| get_plants_from_line(line, student_index))
        .collect()
}

fn get_diagram_lines(diagram: &str) -> impl Iterator<Item = &str> {
    diagram.split("\n")
}

fn get_plants_from_line(line: &str, student_index: usize) -> impl Iterator<Item = &'static str> {
    let index_a = 2 * student_index;
    let index_b = 2 * student_index + 1;

    let plant_a = line.chars().nth(index_a).unwrap();
    let plant_b = line.chars().nth(index_b).unwrap();

    vec![plant_from_initial(plant_a), plant_from_initial(plant_b)].into_iter()
}

fn plant_from_initial(initial: char) -> &'static str {
    match initial {
        'G' => "grass",
        'C' => "clover",
        'R' => "radishes",
        'V' => "violets",
        _ => "",
    }
}

fn student_index(name: &str) -> usize {
    let initial = name.chars().next().unwrap();
    initial as usize - 'A' as usize
}
