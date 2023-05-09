# StaticWire: Rent Internet Protocol Subnets Using Bitcoin's Lightning Network


## Overview ##

StaticWire is an initiative to keep the [Distributed Charge](http://andyschroder.com/DistributedCharge/) project distributed, but its usefulness is much greater, helping many other products and services overcome their connectivity problem.

Independent self hosting of internet services is a challenge due to the need for a dedicated public static IP address in order to be able to communicate. The IPv4 address space is limited and the transition to IPv6 addresses is far from complete. Consumer grade coaxial, fiber optic, satellite, and cellular internet service providers typically assign dynamic and often times shared IPv4 addresses to end users due to the limited number of addresses available. It is possible for end users to subscribe to special internet services that provide dedicated static IPv4 addresses on their internet connection, however, setting up such services is costly, complicated, and time consuming. There is a marketplace for renting, leasing, and buying the rights to IP address subnets independent of an internet service provider, but the minimum subnet size is 256 and it's typically not possible to get traffic routed to and from these addresses over consumer grade internet services. Because of all of these challenges, many internet services have been driven to large, centralized custodial services that typically operate at [OSI](https://en.wikipedia.org/wiki/OSI_model) Layer 7 or higher.

StaticWire allows anyone to rent a tunnel that provides dedicated public static IPv4 addresses. The underlying tunneling technology that makes StaticWire possible is Jason A. Donenfeld's [WireGuard](https://wireguard.com/). StaticWire differs from other tunneling services that provide dedicated public static IPv4 addresses in that it requires no account setup and payments are made using the bitcoin lightning network. StaticWire is a natural fit for bitcoin lightning node operators because they are highly incentivized to self host their hardware, would like remote access to their hardware, need to accept inbound lightning channels, and already have built in payment capabilities.

Using the bitcoin lightning network for payments allows for completely automated machine to machine negotiation of payments and IP address delivery. In order to keep the internet decentralized, StaticWire aims to be a standard protocol that anyone who has spare IP addresses can subrent them. StaticWire allows subnets smaller than 256 addresses to be routed, at the cost of higher latency and more bandwidth utilization. In today's world, bandwidth is becoming very cheap, and the latency trade off may be acceptable in order to self host internet services. As a bonus, because StaticWire is built upon Jason A. Donenfeld's [WireGuard](https://wireguard.com/), it has native capabilities for seamlessly roaming from one internet connection to the other, allowing services to move from Ethernet to WiFi to Cellular without interruptions.

Although it is undesirable to require proxy services such as StaticWire, it's believed to be the best trade off operating a proxy service at [OSI](https://en.wikipedia.org/wiki/OSI_model) Layer 3 instead of a much higher layer. The proxy service functions as a dumb packet router, just as other normal routers on the internet. So, there is not any new data exposed. This proxy service allows the self hosting of services and will allow a smoother transition to IPv6 and other more advanced overlay networks where the address space is no longer limited, potentially making StaticWire obsolete someday. However, StaticWire works today!

## Development Status ##

StaticWire is currently available to test as a client with the command line tool `staticIP`. Details for installing and using this *alpha* tool are provided below. This command line tool currently requires manual payments, but an auto payment daemon similar to [Distributed Charge](http://andyschroder.com/DistributedCharge/) is currently under development. The rental server's source code is also under testing and development and is not yet ready for public release.

The command line tool `staticIP` generates a private/public key pair for the tunnel locally and the public key is shared with the rental server to identify the customer. When the public key is provided to the rental server, a bitcoin lightning invoice is provided. Once the invoice has been paid, tunnel configuration details are provided to the payer. The payer is currently responsible for using the `staticIP` tool to monitor the credit they have with the rental server and for fetching renewal invoices and making payments (in order to keep the tunnel active).



### Current limitations: ###

- Only supports IPv4.
- Only supports /32 prefix sizes (single IP address).
- Need to manually pay for each month's rent.
- Server source code has not yet been published.



### Current Terms of Sale (subject to change) ###

- Each month's rent is 24,000 sat.
- First payment required is 72,000 sat (48,000 sat activation fee for the tunnel and IP address + 24,000 sat (the first month's rent)).
- If a renewal is missed, the address will be reserved for up to 2 months, but back payments are required to re-activate it.
- This service is experimental, and being shared for trial use. It comes with no warranty or liabilities of any kind.
- This service provides a raw internet connection with no firewall built in. It is the user's responsibility to apply appropriate firewalling. Not liable for damages of any kind do to lack of expertise in how tunnels and routers works.
- Tunnels are subject to termination due to software defects or policy changes.
- Terms are Subject to change.



## Installation Options ##


### Normal Local User ###

```
pip3 install git+https://github.com/AndySchroder/StaticWire.git

``


### Python virtualenv ###

```

python3 -m venv venv
source venv/bin/activate
pip3 install git+https://github.com/AndySchroder/StaticWire.git


```


### Docker ###

```
git clone https://github.com/AndySchroder/StaticWire.git
cd StaticWire
docker-compose up --build
```

This command is blocking, so, when the build completes, open a new terminal window and run

`docker exec -it StaticWireClient bash`

to get a shell inside the docker container.


```



## Usage ##

After following one of the above installation approaches, you can use the `staticIP` command.

`usage: staticIP [-h] [-a] {RentNewIP,GetRentalStatus,GetConf,Renew}`


- `RentNewIP` will rent a new IP address. First it will present an invoice. After payment the tunnel configuration info will be provided.
- `GetRentalStatus` will give the current status of the tunnel so you can determine when you need to renew.
- `GetConf` will give the tunnel's configuration if you lost it after running `RentNewIP`.
- `Renew` will give you a new lightning invoice to renew an existing rental.
- The `-a` option is not yet implemented.


  
  
________________________________________________________________

## Copyright ##

Copyright (c) 2023, [Andy Schroder](http://AndySchroder.com)

## License ##

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  
  
________________________________________________________________





