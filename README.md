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

- The first payment includes 
    - a non-refundable activation fee of 48,000 sat that reserves the tunnel & the dedicated public static IPv4 address and
    - at least 1,000 sat for the initial rental credit (this may be increased in the future to prevent IP address squatting if there is too much abuse of the server).
- The total minimum first payment therefor is 49,000 sat.
- After the first payment the smallest allowable rental credit payment size is 500 sat. The default payment size is 24,000 sat (1 month's rent). Server max credit will be 72,000 sat (3 month's rent) for now but the plan is to increase to 288,000 sat (12 month's rent) in the medium term and 576,000 sat (24 month's rent) in the long term.
- If no payments are made and the rental credit becomes 0, the tunnel will be turned off but the address will be reserved for up to 2 months. In order to re-activate the tunnel, back rental payments are required.
- This service is experimental, and being shared for trial use. It comes with no warranty or liabilities of any kind.
- This service provides a raw internet connection with no firewall built in. It is the user's responsibility to apply appropriate firewalling. Not liable for damages of any kind do to lack of expertise in how tunnels and routers works.
- Tunnels are subject to termination due to software defects or policy changes.
- Terms are subject to change.



## Installation Options ##


### Normal Local User ###

```bash
apt install -y python3-pip git
pip3 install git+https://github.com/AndySchroder/StaticWire.git
```


### Python virtualenv ###

```bash
apt install -y python3-pip git
python3 -m venv venv
source venv/bin/activate
pip3 install git+https://github.com/AndySchroder/StaticWire.git
```


### Docker ###

```bash
git clone https://github.com/AndySchroder/StaticWire.git
cd StaticWire
docker-compose up --build
```

This command is blocking, so, when the build completes, open a new terminal window and run

```bash
docker exec -it StaticWireClient bash
```

to get a shell inside the docker container.





## Usage ##

After following one of the above installation approaches, you can use the `staticIP` command to manage a tunnel rental that provides a dedicated public static IP address.

```
usage: staticIP [-h] [--amount AMOUNT] {AddCredit,GetRentalStatus,GetConf,AutoPay}
```

- `AddCredit` provides a lightning invoice to add credit to an existing tunnel rental. If there is no existing tunnel rental then a lightning invoice is provided for a new tunnel and then the new tunnel rental is started and a wireguard configuration is provided after payment is made.
- `GetRentalStatus` will give the current status of the tunnel so that you can check when you need to use `AddCredit` to make payments.
- `GetConf` gets the tunnel's wireguard configuration if you lost it after initially running `AddCredit`.
- `AutoPay` runs continuously and uses stored LND credentials to automatically pay invoices (not yet implemented).
- `--amount AMOUNT` allows the amount of credit that you want to add to be specified (the default is 24,000) [sat].

  
  
________________________________________________________________

## Copyright ##

Copyright (c) 2023, [Andy Schroder](http://AndySchroder.com)

## License ##

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  
  
________________________________________________________________





