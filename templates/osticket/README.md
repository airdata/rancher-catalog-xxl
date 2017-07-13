## What is inside osTicket Stack?
* [osTicket Server](http://osticket.com/) + Sidekick with plugins storage
* MySQL Database + Sidekick with storage

## Info
* In default osTicket stack will create "osticket" MySQL database with osticket user.
* Once osTicket will start, make sure you setup correct information in setup page.
* For easy upgrades there are sidekicks for both osTicket and MySQL with dedicated storage.
* osTicket plugins are installed on sidekick in /data/upload/include/plugins 

## First Run
Once osTicket Server starts: 
* Go to http://[IP]:[PORT]/scp and login with default credentials: 
* **username**: ostadmin 
* **password**: Admin1
