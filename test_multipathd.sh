#!/bin/bash

stop_and_start_service_and_socket() {
    systemctl stop multipathd.service multipathd.socket
    systemctl start multipathd.socket multipathd.service
}

restart_socket_then_service() {
    systemctl restart multipathd.socket multipathd.service
}

restart_service_then_socket() {
    systemctl restart multipathd.service multipathd.socket
}

start_socket_then_service() {
    systemctl start multipathd.socket multipathd.service
}

start_service_then_socket() {
    systemctl start multipathd.service multipathd.socket
}

reset() {
     systemctl daemon-reload
     systemctl stop multipathd.service multipathd.socket
     systemctl start multipathd.socket multipathd.service
     if ! systemctl is-active multipathd.service > /dev/null 2>&1 || \
	! systemctl is-active multipathd.socket > /dev/null 2>&1; then
         echo "Something went wrong!"
     fi
}

test_states() {
    echo -n "Testing "
    function_contents=$(declare -f $1 | grep -v -e "{" -e "}" -e "$1")
    echo $function_contents

    # active/active
    reset
    $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -n "O | "
    else
        echo -n "X | "
    fi
    echo "service active && socket active"
    
    # active/inactive
    reset
    systemctl stop multipathd.socket
    $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -n "O | "
    else
        echo -n "X | "
    fi
    echo "service active && socket inactive"
    
    # inactive/active
    reset
    systemctl stop multipathd.service > /dev/null 2>&1
    $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -n "O | "
    else
        echo -n "X | "
    fi
    echo "service inactive && socket active"
    
    
    # inactive/inactive
    reset
    systemctl stop multipathd.service  multipathd.socket
    $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -n "O | "
    else
        echo -n "X | "
    fi
    echo "service inactive && socket inactive"
}

package=$(dpkg -l multipath-tools | grep multipath-tools | awk '{print $3}')
echo "Testing multipath-tools ${package}"
echo "------"
echo ""

test_states restart_socket_then_service
test_states restart_service_then_socket
test_states start_socket_then_service
test_states start_service_then_socket
test_states stop_and_start_service_and_socket
