use std::fs;

fn main() {
    let file = fs::read_to_string("./example")
        .expect("File not found!");
    let str_vec: Vec<char> = file.chars().collect();
    let mut sum: i32 = 0;
    let mut skip: bool = false;

    for (i, c) in str_vec.iter().enumerate() {
        if str_vec[i..].starts_with(&['d','o','n','\'','t','(',')']) {
            skip = true;
        }
        if str_vec[i..].starts_with(&['d','o','(',')']) {
            skip = false;
        }

        if *c == 'm' && str_vec[i+1] == 'u' && str_vec[i+2] == 'l' && str_vec[i+3] == '(' && !skip {
            // println!("{}", i + 4);
            let digit_x = verify_digits(&str_vec.clone(), i + 4, ',');
            // println!("{}", i + 4 + digit_x.0 as usize);
            let digit_y = verify_digits(&str_vec.clone(), i + 4 + digit_x.0 as usize, ')');

            if digit_x.0 != 0 {
                if digit_y.0 != 0 {
                    let x: i32 = digit_x.1.parse::<i32>().unwrap();
                    let y: i32 = digit_y.1.parse::<i32>().unwrap();
                    sum += x * y;
                }
            }
        }
    }
    println!("{}", sum);
}

fn verify_digits(str_vec: &Vec<char>, i: usize, delimiter: char) -> (i32, String) {
    let mut result = String::new();

    if str_vec[i].is_ascii_digit() && str_vec[i+1].is_ascii_digit() && str_vec[i+2].is_ascii_digit() && str_vec[i+3] == delimiter {
        result.push(str_vec[i]);
        result.push(str_vec[i+1]);
        result.push(str_vec[i+2]);

        return (4, result);
    }
    if str_vec[i].is_ascii_digit() && str_vec[i+1].is_ascii_digit() && str_vec[i+2] == delimiter {
        result.push(str_vec[i]);
        result.push(str_vec[i+1]);

        return (3, result);
    }
    if str_vec[i].is_ascii_digit() && str_vec[i+1] == delimiter {
        result.push(str_vec[i]);

        return (2, result);
    }

    return (0, result);
}
