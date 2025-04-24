# Genderize
Check the Gender of the Name

```
   ____                      _                 _              
  / ___|   ___   _ __     __| |   ___   _ __  (_)  ____   ___ 
 | |  _   / _ \ | '_ \   / _` |  / _ \ | '__| | | |_  /  / _ \
 | |_| | |  __/ | | | | | (_| | |  __/ | |    | |  / /  |  __/
  \____|  \___| |_| |_|  \__,_|  \___| |_|    |_| /___|  \___|    
```

## Install

To use the Genderize script, follow these steps:

1. Clone the repository:

    ```
    git clone https://github.com/haithamaouati/Genderize.git
    ```

2. Change to the Genderize directory:

    ```
    cd Genderize
    ```
    
3. Change the file modes
    ```
    chmod +x genderize.sh
    ```
    
5. Run the script:

    ```
    ./genderize.sh
    ```

## Usage
Usage: `./genderize.sh -n <NAME> [-c COUNTRY]`

##### Options:

`-n`, `--name`       Specify the name to analyze (required)

`-c`, `--country`    Optional country ID (e.g., DZ)

`-h`, `--help`    Show this help message

## Dependencies

The script requires the following dependencies:

- [figlet](http://www.figlet.org/): `pkg install figlet - y`
- [curl](https://curl.se/): `pkg install curl - y`
- [jq](https://jqlang.org/): `pkg install jq -y`
- [bc](): `pkg install bc -y`

Make sure to install these dependencies before running the script.

## Author

Made with :coffee: by **Haitham Aouati**
  - GitHub: [github.com/haithamaouati](https://github.com/haithamaouati)

## License

Genderize is licensed under [Unlicense license](LICENSE)
