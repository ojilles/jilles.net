#! /bin/bash
head -n 10 ./_posts/* | grep "^\- " | sort | uniq
