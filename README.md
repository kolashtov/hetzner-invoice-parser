Hetzner Invoice Parser
=======================

Hetzner does not provide any cost calculation tools, so using this script you can easily calculate the total cost of your servers including addons.

Usage
-----

Basic usage:
```
ruby ./hetzner-invoice-parser.rb <path_to_csv_invoice_file>
```
Where <path_to_csv_invoice_file> is a path to a downloaded invoice in csv-format. You can find your invoice here: https://accounts.hetzner.com/invoice

Sample output of the script:
```
Server #111111 project1.frontend1. Total price with addons: 44.5 euro
Addons:
  - 1x Upgrade to DDR4 ECC RAM: 1 x 5.5 = 5.5 euro
  - 1x Primary IPv4 135.181.X.YYY: 1 x 1.7 = 1.7 euro
  - 1x Additional IP address 135.181.X.ZZZ: 1 x 1.7 = 1.7 euro

Server #222222 project1.backend1. Total price with addons: 62.3 euro
Addons:
  - 1x Upgrade from 64GB to 128GB DDR4 ECC RAM: 1 x 25.0 = 25.0 euro
  - 1x Primary IPv4 135.181.X.QQQ: 1 x 1.7 = 1.7 euro

Server #333333 project2.frontend2. Total price with addons: 80.2 euro
Addons:
  - 1x Primary IPv4 65.109.QQQ.LL: 1 x 1.7 = 1.7 euro
  - 1x 10 Gbit Uplink: 1 x 42.9 = 42.9 euro

Server #444444 project2.backend2. Total price with addons: 80.2 euro
Addons:
  - 1x Primary IPv4 65.109.DDD.RRR: 1 x 1.7 = 1.7 euro
  - 1x 10 Gbit Uplink: 1 x 42.9 = 42.9 euro

Global addons:
- 1x 48-Port 10 Gbit switch: 1 x 342.1 = 342.1 euro
====================================
Total amount with global addons: 609.3
====================================
```


Extended usage:
```
ruby ./hetzner-invoice-parser.rb <path_to_csv_invoice_file> <filter_pattern>
```
Example:
```
ruby ./hetzner-invoice-parser.rb hetzner.csv backend
```

Sample output of the script:
```
Server #222222 project1.backend1. Total price with addons: 62.3 euro
Addons:
  - 1x Upgrade from 64GB to 128GB DDR4 ECC RAM: 1 x 25.0 = 25.0 euro
  - 1x Primary IPv4 135.181.X.QQQ: 1 x 1.7 = 1.7 euro

Server #444444 project2.backend2. Total price with addons: 80.2 euro
Addons:
  - 1x Primary IPv4 65.109.DDD.RRR: 1 x 1.7 = 1.7 euro
  - 1x 10 Gbit Uplink: 1 x 42.9 = 42.9 euro

Global addons:
- 1x 48-Port 10 Gbit switch: 1 x 342.1 = 342.1 euro

====================================
Servers are filtered by word: backend
Total amount of filtered servers: 142.5 euro
Amount is calculated without global addons!
====================================
```



