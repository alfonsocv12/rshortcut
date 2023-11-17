use std::fs::OpenOptions;
use std::io::{Read, Error};
use serde_json::{Value, Map};
use std::env;
use dotenv::dotenv;

fn read_commands() -> Result<Map<String, Value>, Error> {
    let file_path = env::var("COMMANDS_FILE")
        .unwrap_or_else(|_| env::var("HOME").unwrap()+"/.config/rshortcuts/setup.json");

    let mut file = OpenOptions::new()
        .read(true)
        .write(false)
        .create(false)
        .open(file_path).unwrap();

    let mut contents = String::new();
    file.read_to_string(&mut contents).unwrap();

    if let Some(map) = serde_json::from_str::<Value>(&contents).unwrap().as_object() {
        return Ok(map.clone());
    } 

    return Err(Error::new(std::io::ErrorKind::Other, "Error parsing JSON"));
}

fn main() {
    dotenv().ok();

    let args: Vec<String> = env::args().collect();

    let commands = read_commands().unwrap();

    let to_run = args[1].as_str();
    
    let bach = commands.get(to_run).unwrap().as_str().unwrap();

    println!("{}", bach);
}