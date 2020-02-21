server

install: 1 run 0_initServer.sh ; 2 run 1_install.sh 。
uninstall: run uninstallServer.sh
update clients for server to monitor: run updatehosts.sh



client

install: curl http://serverIP:8888/install_monitor.sh|bash
uninstall: curl http://serverIP:8888/uninstall_monitor.sh|bash
