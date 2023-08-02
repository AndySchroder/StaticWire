# StaticWire: Rent Internet Protocol Subnets Using Bitcoin's Lightning Network


## Overview ##

StaticWire is an initiative to keep the [Distributed Charge](http://andyschroder.com/DistributedCharge/) project distributed, but its usefulness is much greater, helping many other products and services overcome their connectivity problem.

Independent self hosting of internet services is a challenge due to the need for a dedicated public static IP address in order to be able to communicate. The IPv4 address space is limited and the transition to IPv6 addresses is far from complete. Consumer grade coaxial, fiber optic, satellite, and cellular internet service providers typically assign dynamic and often times shared IPv4 addresses to end users due to the limited number of addresses available. It is possible for end users to subscribe to special internet services that provide dedicated static IPv4 addresses on their internet connection, however, setting up such services is costly, complicated, and time consuming. There is a marketplace for renting, leasing, and buying the rights to IP address subnets independent of an internet service provider, but the minimum subnet size is 256 and it's typically not possible to get traffic routed to and from these addresses over consumer grade internet services. Because of all of these challenges, many internet services have been driven to large, centralized custodial services that typically operate at [OSI](https://en.wikipedia.org/wiki/OSI_model) Layer 7 or higher.

StaticWire allows anyone to rent a tunnel that provides dedicated public static IPv4 addresses. The underlying tunneling technology that makes StaticWire possible is Jason A. Donenfeld's [WireGuard](https://wireguard.com/). StaticWire differs from other tunneling services that provide dedicated public static IPv4 addresses in that it requires no account setup and payments are made using the bitcoin lightning network. StaticWire is a natural fit for bitcoin lightning node operators because they are highly incentivized to self host their hardware, would like remote access to their hardware, need to accept inbound lightning channels, and already have built in payment capabilities.

Using the bitcoin lightning network for payments allows for completely automated machine to machine negotiation of payments and IP address delivery. In order to keep the internet decentralized, StaticWire aims to be a standard protocol that anyone who has spare IP addresses can subrent them. StaticWire allows subnets smaller than 256 addresses to be routed, at the cost of higher latency and more bandwidth utilization. In today's world, bandwidth is becoming very cheap, and the latency trade off may be acceptable in order to self host internet services. As a bonus, because StaticWire is built upon Jason A. Donenfeld's [WireGuard](https://wireguard.com/), it has native capabilities for seamlessly roaming from one internet connection to the other, allowing services to move from Ethernet to WiFi to Cellular without interruptions.

Although it is undesirable to require proxy services such as StaticWire, it's believed to be the best trade off operating a proxy service at [OSI](https://en.wikipedia.org/wiki/OSI_model) Layer 3 instead of a much higher layer. The proxy service functions as a dumb packet router, just as other normal routers on the internet. So, there is not any new data exposed. This proxy service allows the self hosting of services and will allow a smoother transition to IPv6 and other more advanced overlay networks where the address space is no longer limited, potentially making StaticWire obsolete someday. However, StaticWire works today!

## Development Status ##

StaticWire is currently available to test as a client with the command line tool `staticIP`. Details for installing and using this *alpha* tool are provided below.

StaticWire provides both IPv4 and IPv6 subnets inside the tunnel. You can use StaticWire to host services, or if you don't have IPv6 support provided by your internet service provider, you can use StaticWire as a way to get IPv6 connectivity.

The command line tool `staticIP` generates a private/public key pair for the tunnel locally and the public key is shared with the rental server to identify the customer. When the public key is provided to the rental server, a bitcoin lightning invoice is provided. Once the invoice has been paid, tunnel configuration details are provided to the payer.



### Current limitations: ###

- IPv4
    - Only supports renting the `/32` prefix (subnet) size (single IP address).
- IPv6
    - Only supports renting the `/64` prefix (subnet) size (18,446,744,073,709,551,616 IP addresses).
    - Supported _inside_ the tunnel, but not _outside_ the tunnel.
- The command line tool allows for manual *OR* automated payments, but you can't mix the two payment modes.


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


### Normal Local User (ubuntu) ###

```bash
sudo apt update
sudo apt install -y python3-pip git libsystemd-dev pkg-config
sudo apt install -y resolvconf traceroute wireguard-tools          # optional
sudo ufw enable                                                    # recommended
pip3 install git+https://github.com/AndySchroder/StaticWire.git
```


### Python virtualenv (ubuntu) ###

```bash
sudo apt update
sudo apt install -y python3-pip git libsystemd-dev pkg-config
sudo apt install -y resolvconf traceroute wireguard-tools          # optional
sudo ufw enable                                                    # recommended
python3 -m venv venv
source venv/bin/activate
pip3 install git+https://github.com/AndySchroder/StaticWire.git
```


### Docker ###

Warning: This `docker-compose.yml` file includes the `NET_ADMIN` capability in order to allow `staticIP` to automatically create the wireguard network interface.

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

### Command Line Options ####

After following one of the above installation approaches, you can use the `staticIP` command to manage a tunnel rental that provides dedicated public static IP Networks.

```
usage: staticIP [-h] [--amount AMOUNT] {AddCredit,GetRentalStatus,GetConf,AutoPay}
```

- `AddCredit` provides a lightning invoice to add credit to an existing tunnel rental. If there is no existing tunnel rental then a lightning invoice is provided for a new tunnel and then the new tunnel rental is started and a wireguard configuration is provided after payment is made.
- `GetRentalStatus` will give the current status of the tunnel so that you can check when you need to use `AddCredit` to make payments.
- `GetConf` gets the tunnel's wireguard configuration if you lost it after initially running `AddCredit`.
- `AutoPay` runs continuously and uses stored LND credentials to automatically pay to maintain the tunnel.
- `--amount AMOUNT` allows the amount of credit that you want to add to be specified when using `AddCredit` (the default is 24,000) [sat].
  
  

### General ###

- Informational output is written to standard output and debug output is written to `$HOME/.StaticWire/debug.log`.
- Only once instance of `staticIP` can be run on a machine at a time.
- Wireguard configuration files assign the first IPv6 address in your subnet to the tunnel. However, you are free to route the remaining addresses in your subnet to other machines in your network.
- Wireguard configuration files are written to `$HOME/.StaticWire/WireGuardConfigFiles/` and soft linked to `/etc/wireguard/` if possible.
- Hitting `Control+C` (`SIGINT`) or killing with a `SIGTERM` (`kill -15`) will attempt to gracefully shutdown `staticIP`.


### AutoPay ###

StaticWire's AutoPay mode uses [lndconnect](https://github.com/LN-Zap/lndconnect/blob/master/lnd_connect_uri.md) to connect to your lnd node's gRPC interface and make automated payments. lndconnect allows you to copy and paste a single (long!) string which provides the necessary information for StaticWire connect to your lnd node, verify that StaticWire's connection to your node is secure, and authenticate StaticWire to the node. Copy and Pasting this single string allows you to easily configure a StaticWire client on a machine in the field ssh, inside a docker container, or inside a virtual machine. You will be prompted to paste this string when you first run `staticIP AutoPay`.

Since we are trusting a script to automatically make payments we want to limit that trust for several reasons:

1. This is experimental software.
2. You may want to use this software on a machine that doesn't have high physical or system security.

Lightning Terminal (`litd`) now gives lnd the ability to have multiple accounts. Follow these instructions to create a custom macaroon with limited spending capabilities using Lightning Terminal's `litcli` and create an [lndconnect URI](https://github.com/LN-Zap/lndconnect/blob/master/lnd_connect_uri.md) for it.

- Install `litd` and `litcli` (see https://docs.lightning.engineering/lightning-network-tools/lightning-terminal/get-lit).
- Install `lndconnect` (see https://github.com/LN-Zap/lndconnect#installing-lndconnect).
- `litcli accounts create 150000 --save_to StaticWireTest.macaroon`
   - This creates an isolated account with only 150,000 sats allocated to it.
   - Make sure the record the `id` value. This will later be needed when trying to adjust the balance or to remove the account.
- `lndconnect -j --host=HostNameOrIPAddress --port=10009 --tlscertpath=/home/YourUserName/.lnd/tls.cert --adminmacaroonpath=StaticWireTest.macaroon`
   - Note, we didn't actually create an admin macaroon with the `litcli` command above. `lndconnect` doesn't have an option to use a general macaroon, so we tricked it. Since the lndconnect specification doesn't actually differentiate between the different types of macaroons we can just tell `lndconnect` that any macaroon is the admin macaroon.
   - If you are running StaticWire on your lightning node directly, use `localhost` for the `host`.
- If you need to increase the balance of the account, you will need to either send more to it using normal lightning payments (however, please be aware of `https://github.com/lightninglabs/lightning-terminal/issues/494`), or use litcli to adjust the balance using `litcli accounts update --id=IDYouRecordedAbove --new_balance=250000`.
- When you need to remove the account, just deleting the original `StaticWireTest.macaroon` file is not sufficient, you need to run `litcli accounts remove --id=IDYouRecordedAbove`.


### Known Issues With AutoPay ###

- Making a manual payment with `staticIP AddCredit` will not be known to `staticIP AutoPay` and then it will stop paying because it is in disagreement the rental server.
- There isn't currently a way to detect if the rental server is providing an active tunnel and `staticIP AutoPay` will keep paying as long as the sale terms are within its limits. Just like [Distributed Charge](http://andyschroder.com/DistributedCharge/) `staticIP AutoPay` should stop paying the terms of sale aren't satisfied (don't trust, verify!).
- Lightning Network routing fees don't have any limits on them.
- `staticIP` needs to be stopped and restarted to reload settings in `Config.yaml`.
- `staticIP` should detect if it is running on the same machine as your lightning node and if so, only ask which macaroon to use rather than require a full lndconnect URI.

________________________________________________________________

## Copyright ##

Copyright (c) 2023, [Andy Schroder](http://AndySchroder.com)

## License ##

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  
  
________________________________________________________________





