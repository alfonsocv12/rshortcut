use std::env;

fn read_file(path: String) {
    println!("{}", path);
}

fn _read_base() {
    let home: String = env::var("HOME").unwrap();
    let shell = env::var("SHELL").unwrap();

    if let Some(idx) = shell.rfind("/bin") {
        let sub_shell = &shell[idx..];

        match sub_shell {
            "/bin/bash" => {
                read_file(home + "/.bashrc");
            },
            "/bin/zsh" => {
                read_file(home + "/.zshrc");
            },
            _ => {
                println!("other");
            }
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let file_path = args[1].as_str();

    read_file(file_path);
}