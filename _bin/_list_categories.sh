#! /bin/bash
echo Listing all categories
head -n 10 * | grep "^\- " | sort | uniq
