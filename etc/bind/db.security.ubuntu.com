$TTL  604800
@ IN  SOA security.ubuntu.com. root.ubuntu.com. (
            0   ; Serial
       604800   ; Refresh
        86400   ; Retry
      2419200   ; Expire
       604800 ) ; Negative Cache TTL
;
@ IN  NS  security.ubuntu.com.

@ IN  A 10.42.0.1

