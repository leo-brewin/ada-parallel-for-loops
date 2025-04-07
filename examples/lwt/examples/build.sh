#!/bin/bash

source ../../alire.ini

export FILES=$(ls *.adb | xargs)

gprbuild -p -P build.gpr $1
