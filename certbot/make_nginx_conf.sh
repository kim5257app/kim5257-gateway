#!/bin/bash

sed "s/\$domain/$1/g" template.conf | sed "s/\$server_name/$2/g" > $1.conf