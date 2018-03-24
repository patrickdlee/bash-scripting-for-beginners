# Bash Scripting for Beginners

## Introduction

This repository was created as part of a talk at Boise Code Camp 2018. The goal is to start with basic commands and work toward scripts of increasing complexity.

## Basic Commands

Bash scripting starts on the command line with a set of commands that will serve as the building blocks for scripts. There are plenty of great tutorials and examples for each of these...

- grep
- find
- awk
- sed
- curl
- sort
- uniq
- xargs

## Using Pipes

A pipe (`|`) is used to send the output of one command to the input of another.

## Bash One-Liners

After getting familiar with some commands, the next step is to assemble them into some useful one-liners. Here's an example...
```bash
svn status | grep ^? | awk '{print $2}' | xargs svn add
```
This finds all the local files in a Subversion checkout that haven't been added and then adds them.

## Resources

- https://google.github.io/styleguide/shell.xml
- http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/
- https://dev.to/thiht/shell-scripts-matter
- http://blog.librato.com/posts/jq-json
- https://github.com/koalaman/shellcheck
