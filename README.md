# NVD Scraper

This is a web scraper built in ruby that retrieves data from the National Vulnerability Database's RSS feed, which contains the most recent, and most recently modified, Common Vulnerabilies and Exposures (CVE) entries in the database.

# Overview

The National Vulnerability Database (NVD) is the U.S government repository of cybersecurity vulnerabilities and threats, organized in Common Vulnerability and Exoposure (CVE) entries. CVEs are the standard in representation of vulnerabilities and threats, and provide information about these vulnerabilities and threats, such as entities affected, description of the threat, exploitation methods, and threat scores.
Threats are scored using the Common Vulnerability Scoring System (CVSS).

This scraper aims to provide a quick overview of the most recent and relevant cybersecurity threats by retrieving the most recent data of the NVD's RSS feed, and displaying it on the user's terminal. It can calso retrieve additional data on specific CVE entries of the database, by scraping data on the web links provided for each CVE entry on the RSS feed. 

# Installation

## Getting the files
In order to install the program, first you need to have the files on your computer. You can get them either cloning this repository, or downloading its contents directly
- To clone the repo, go on the project's [Github page](https://github.com/ivanid22/NVD-scraper), click on "Clone or download", copy the contents of the text box, and then run `git clone "repo"` on the command line, where "repo" is the text you just copied.
- If you want to download it directly instead, go on the project's [Github page](https://github.com/ivanid22/NVD-scraper), click on "Clone or download", and then on "Download ZIP". After this you need to extract the contents of the zip file on your computer.

# How to use

Once you have the files in your computer, you need to make sure you meet the software requirements to run it (check the "Requirements" section below). Next, you need to navigate to the program's folder on your terminal.

Next up, you need to install the program's dependencies through bundler, by running the command:

- `bundle install`

And now youre ready to run the scraper. You can either run it by passing the main ruby script directly to the ruby intepreter:

- `ruby bin/nvd-scrape.rb <arguments>`

Or you can run it as a standalone script by making the script executable, and then running it directly:

- `chmod + x bin/nvd-scrape.rb` (Make the script executable, you only need to do this once)
- `./bin/nvd-scrape.rb <arguments>`

Proper format for the arguments is detailed below:

## Listing CVE entries

In order to list the entries in the NVD RSS database, run the command
- `./bin/nvd-scrape list`

That's going to produce an output with all the entries in the database, organized in an entry by entry basis

## Getting additional information for specific entries

In order to get more detailed information on one or several specific CVE entries, use the command

- `./bin/nvd-scrape details <cve-numbers>`

Where `<cve-numbers>` is one or more CVE IDs present in the RSS database. For example:

- `./bin/nvd-scrape details CVE-2020-9517` (for a single CVE entry)
- `./bin/nvd-scrape details CVE-2020-9517 CVE-2020-9436 CVE-2020-9408` (For several CVE entries)

CVE IDs should be provided in its standard format: the letters CVE, followed by a dash, and then two number groups separated by dashes, for example: `CVE-2020-1234`.

In order for the scraper to be able to retrieve additional data, the CVE entry has to be present on the RSS database, otherwise it won't be able to produce any output.

# Live version

[Link to the live version](https://tic-tac-toe-1.ivandiaz5.repl.run/)

# Requirements

- Ruby > 2.5
- Bundler > 2.1
- gem > 2.7

Currently, one of the dependencies for the program does not work with ruby > 2.7

## Built With

- Ruby

## Author

👤 **Ivan Diaz**

- Github: [@ivanid22](https://github.com/ivanid22)
- Twitter: [@ivanid22](https://twitter.com/ivanid22)
- Linkedin: [ivanid22](https://www.linkedin.com/in/ivan-diaz-3a38b3150/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!
