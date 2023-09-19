Quick script for https://code.launchpad.net/~mitchdz/ubuntu/+source/multipath-tools/+git/multipath-tools/+merge/451301


## Quick Start

```bash
$ lxc launch ubuntu-daily:mantic test-multipathd --vm
$ lxc shell test-multipathd
# git clone https://github.com/mitchdz/test_multipath-tools-systemctl.git
# test_multipath-tools-systemctl/test_multipathd.sh
```

Example results
```
Testing multipath-tools 0.9.4-5ubuntu1
------

Testing systemctl restart multipathd.socket multipathd.service
X | service active && socket active
X | service active && socket inactive
O | service inactive && socket active
O | service inactive && socket inactive
Testing systemctl restart multipathd.service multipathd.socket
O | service active && socket active
O | service active && socket inactive
X | service inactive && socket active
X | service inactive && socket inactive
Testing systemctl start multipathd.socket multipathd.service
O | service active && socket active
X | service active && socket inactive
O | service inactive && socket active
O | service inactive && socket inactive
Testing systemctl start multipathd.service multipathd.socket
O | service active && socket active
X | service active && socket inactive
O | service inactive && socket active
X | service inactive && socket inactive
Testing systemctl stop multipathd.service multipathd.socket; systemctl start multipathd.socket multipathd.service
O | service active && socket active
O | service active && socket inactive
O | service inactive && socket active
O | service inactive && socket inactive
```
