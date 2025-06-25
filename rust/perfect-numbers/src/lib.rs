#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    if num == 0 {
        return None;
    }
    
    match aliquote_sum(num) {
        sum if sum > num => Some(Classification::Abundant),
        sum if sum < num => Some(Classification::Deficient),
        _sum => Some(Classification::Perfect)
    }
}

fn aliquote_sum(num: u64) -> u64 {
    (1..num)
        .filter(|d| num % d == 0)
        .reduce(|acc, v| acc + v)
        .unwrap_or(0)
}

