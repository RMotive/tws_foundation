# CHANGELOG

## CURRENT

- Notes:

    1. All sets got updated adding [Timestamp] new property to the [ISet] interface, representing the timestamp when the record got created.

    2. Renamed items:

        - Folders

            1. [CSM Foundation/Databases] -> [CSM Foundation/Database]

        - Bases

            1. [BDatabaseDepot] -> [BDepot]
            2. [BDatabaseSet] -> [BSet]

- Dependencies Upgrade:

    1. TWS Security

        - TWS Security.Quality

    2. TWS Business

        - TWS Business.Quality

    3. TWS Customer

        - TWS Customer.Quality

    4. TWS Foundation

        - TWS Foundation.Quality

## 2.0.1 - 03.09-2024

- Notes:

    1. [Yardlog] Set:

        - Fixed a problem with the set validations that was causing errors reading records due to was expecting a max size of the [ttPicture].  

- Dependencies Upgrade:

    1. TWS Security

        - TWS Security.Quality

            1. Microsoft.NET.Test.Sdk ([17.10.0] -> [17.11.0])

    2. TWS Business

        - TWS Business.Quality

            1. Microsoft.NET.Test.Sdk ([17.10.0] -> [17.11.0])

    3. TWS Customer

        - TWS Customer.Quality

            1. Microsoft.NET.Test.Sdk ([17.10.0] -> [17.11.0])

    4. TWS Foundation

        - TWS Foundation.Quality

            1. Microsoft.NET.Test.Sdk ([17.10.0] -> [17.11.0])
