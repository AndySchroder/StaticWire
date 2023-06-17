Change Log
===========


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




