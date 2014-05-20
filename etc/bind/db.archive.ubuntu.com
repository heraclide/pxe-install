$TTL  604800
@ IN  SOA archive.ubuntu.com. root.ubuntu.com. (
            0   ; Serial
       604800   ; Refresh
        86400   ; Retry
      2419200   ; Expire
       604800 ) ; Negative Cache TTL
;
@ IN  NS  archive.ubuntu.com.

@ IN  A 10.42.0.1
* IN  A 10.42.0.1

