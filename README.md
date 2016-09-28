# rdu - Ruby du
[![Build Status](https://travis-ci.org/matticulous/rdu.svg?branch=master)](https://travis-ci.org/matticulous/rdu)

This project provides a command-line application which will take a mount point (directory) as an argument and return a list of all the files on the mountpoint and their disk usage in bytes in json format.

## Usage
### Prerequisites
This solution requires a few prerequisites to be satisfied for the best experience:
* git
* ruby (>= 2.0.0)
* rubygems
* bundler

### Installing/configuring prerequisites
Install ruby using rbenv:
```bash
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.3.1
rbenv global 2.3.1
```

Install bundler: `gem install bundler`

### Installing/configuring the application
* Clone this git repository to a working directory of your choice, and navigate to it:
```bash
git clone https://github.com/matticulous/rdu.git
cd rdu
```
* Install the required gems: `bundle install`
* With all of prerequisites satisfied, you can scan a directory to provide json output of the files and associated byte sizes:
```bash
./rdu.rb -m [mountpoint]
```
* To run a set of automated acceptance tests, you can either run:
```bash
rake features
```
or
```bash
cucumber
```
* To see available options, run:
```bash
./rdu.rb -h
```

### Data output
The output is JSON-formatted as in the following example:
```bash
{
  "files": [
    {
      "path": "dir1/file1.txt",
      "size": 1
    }
  ]
}
```
By default, `rdu` will pretty-print JSON output. In order to output a JSON string, which is useful for post-processing in other programes, you can make use of the `-u` or `--ugly` switches.

### Post-processing
Rather than adding data manipulation and formatting functionality to the program, a design decision was made to keep the program simple and produce "pipe-friendly" output for consumption/processing by other programs. For example, a common operation may be to sort the list of files in descending order by size. This, along with other manipulations of JSON, could be accomplished by using the excellent [jq](https://stedolan.github.io/jq/) tool:
```bash
./rdu.rb -u -d /tmp/ | jq '.files | sort_by(.size) | reverse'
```
