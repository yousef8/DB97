# DB97

![Project Banner](./imgs/db97_banner.png)

DataBase Managment System (DBMS) using Bash Script language

## Demo

https://github.com/yousef8/DB97/assets/37050129/6f0b7456-4216-4408-86ac-0ae96265f206

## Environment Variables

`This project was developed and tested on GNU bash, version 5.1.8`

## Installation

Just clone the repo on to a linux machine

```bash
  git clone https://github.com/yousef8/DB97.git
```

Or download as a zip folder if you don't have `git` installed

## Usage

1. Get into project directory

    ```bash
    cd DB97
    ```

1. Add execution permission to all scripts except the one in the `lib` directory

    ```bash
    chmod +x db97 create_db connect_db drop_db ./table_scripts/*
    ```

1. Run `db97` script as this is the main script that drives the whole code. [you don't need to run any other script]

    ```bash
    ./db97
    ```

1. Enjoy !!

## Features

- Custom Menu
- Colorized Menu
- Colorized error messages

    (currently only in `delete_from_table` script but will expand to all script in the future)
- Robust Input Validation

## Acknowledgements

- [bashGuide - Greg's Wiki](https://mywiki.wooledge.org/BashGuide) for providing a very in-depth tutorial that helped me a lot in the project

- [introduction-to-bash-scripting](https://github.com/bobbyiliev/introduction-to-bash-scripting) From which i got the idea of making my own menu and most importantly colorizing the menu which i expand on it to colorize error and success messages
