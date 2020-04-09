## precondition

files ready:

```./extract.sh```

## server

1. install: 

   run 0_initServer.sh and 1_install.sh 。

```./ 
./0_initServer.sh && ./1_install.sh
```

   

2. uninstall: 

   run uninstallServer.sh

   ```
   ./uninstallServer.sh
   ```

   

3.  update clients for server to monitor:

   run updatehosts.sh

   ```./
   ./updatehosts.sh
   ```



## client

1. install:

   ``` curl http://serverIP:8888/install_monitor.sh|bash```

2. uninstall: 

   ```curl http://serverIP:8888/uninstall_monitor.sh|bash```