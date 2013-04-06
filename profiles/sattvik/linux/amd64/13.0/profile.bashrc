#!/bin/bash

overpatch() {
	echo "funcname is: ${FUNCNAME[1]}"
}

post_src_unpack() {
	overpatch
}
