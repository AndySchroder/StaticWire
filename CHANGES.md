Change Log
===========


v0.13-alpha
----------
Initial IPv6 support

- IPv6 is now supported _inside_ the tunnel, but not _outside_ the tunnel.


v0.12-alpha
----------
AutoPay proof of concept

- Add `AutoPay` mode that automatically rents, sets up, and continuously maintains Credit.
- Made `GetConf` ask if you want to automatically setup the tunnel interface using NetworkManager or wg-quick.
- Instead of asking, automatically write wireguard configuration files to `$HOME/.StaticWire/WireGuardConfigFiles/` and also soft link them to `/etc/wireguard/` if possible.
- Catch shutdown signals and cleanly shutdown.
- Only allow one instance of `staticIP` to run at a time.
- Use the python `logging` module, writing to both standard output and to a file.
- Updated `AddCredit` to use the new rental server API that accommodates `AutoPay`.
- The `docker-compose.yml` file now includes the `NET_ADMIN` capability in order to allow `staticIP` to automatically create the wireguard network interface.


v0.11-alpha
----------
Minor Improvements

- Remove the `RentNewIP` and `Renew` actions and combined them into a single action `AddCredit` that automatically rents a new IP if no existing rentals are found associated with the user's wireguard public key.
- Allow custom rental credit amounts to be specified within minimum and maximum limits defined by the rental server. This now allows users to test the service with less investment and also allows them to choose their payment frequency.
- More descriptive status and terms of sale messages in the console output.
- Parse command line arguments before processing the config file.
- Better error reporting and handling.


v0.10-alpha
-----------
Initial Release




