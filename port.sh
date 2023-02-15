#!/bin/sh

## automatically duplicate linux target

TARGET_NAME='vxworks'

{
fdfind -g '*linux*';
rg -l '// \+.*linux.*';
rg -l 'go:build.*linux.*';
} | uniq
