# CHANGELOG

## CURRENT - [xx.xx-xxxx]

- Notes:
- 
    1. Changed Section property to nulleable in [Yardlog] set.
 

- Dependencies:

## 4.1.0 - [30.10-2024]

- Notes:

    1. Implemented [Carriers] and [VehiculesModels] service.
    2. [UpdateHelper] method, in Update repository now add new items to a [ICollection]
    if the item is provided.

- Dependencies:

    1. Microsoft.AspNetCore.Mvc.Testing ([8.0.10])
    2. Microsoft.EntityFrameworkCore ([8.0.10])
    3. Microsoft.EntityFrameworkCore.SqlServer ([8.0.10])
    4. Microsoft.IdentityModel.Tokens ([8.1.2])
    5. Microsoft.NET.Test.Sdk ([17.11.1])
    6. xunit ([2.9.2])

## 4.0.0 - [24.10-2024]

- Notes:
    1. Added [VehiculesModels] Service.
    2. Added [Carriers] Service.
    3. Added [TrucksInventories] Set & Service.
    4. [TrucksExternals] Create & update service methods added and tested.
    5. removed the yardlog timestamp trigger.
    6. added a default value to timestamp property.
    7. Added a new schema for business properties changes and normalization.
    8. [TrucksExternals] Create & update service methods added and tested.
    9. [Trucks] tests refactored.
    10. Timestamp property added to sets.
    11. Added [VehiculeModel] set.
    12. Added [TrailerType] set.
    13. The following sets have receive minor properties changes:
        - [Approach]
        - [Driver]
        - [Employee]
        - [Plate]
        - [TrailerExternal]
        - [TruckExternal]
        - [YArdlog]
        - [Approaches]
    14. The following sets have receive breaking changes in their structure:
        - [Manufacturer] -  has been normalized. Now this sets stores the brand name for trucks and trailers manufacturers.
        - [TrailerCommon] - Added the trailerType navigation.
        - [Trailer] - Added Vehicule Model navigation and carrier navigation.
        - [Truck] - Added Vehicule Model navigation & SCT navigation.
        - [Carrier] -  Removed SCT navigation.
    15. Alternative seal [sealAlt] added on yardlog set.

- Dependencies Upgrade: N-A

## 3.0.0 - [23.09-2024]

- Notes: N-A

    1. All sets got updated adding [Timestamp] new property to the [ISet] interface, representing the timestamp when the record got created.

    2. Renamed items: A lot of items got renamed to enumerate them in the changelog.

    3. Added [Filters] to [View] [BDepot] operation, allowing to specify bounds from the data that want to be retrieved.

        - [SetViewDateFilter] Allow to specify a range of dates where the data where created ([Timestamp]).
        - [SetViewPropertyFilter] Allow to specify a property or nested property from the model to calculate based on the [Evaluation] proeprty, nested proeprtyes are splitted by '.' ex: ('Location.Name').
        - [SetViewFilterLinearEvaluation] Allow to specify a group of filters applying a specific logical operator, this one is linear that means will apply the same operator for all the given filters.

    4. [Developers]: Huge improvement in testing base labeling, now tests will be labeled and the most auto-managed by [CSM].

    5. [Developers]: Fixed a problem with the test data disposer, now is working even in async operations, also was fixing and well implemented Contact controller tests and was fixed a problem was causing errors trying to deserealize object [SetOperationFailure] model in tests validations.

    6. [Developers]: Included tests for:

        - [SetViewDateFilter]
        - [SetViewPropertyFilter]
        - [SetViewFilterLinearEvaluation]

    7. Added Inventories and Yardlog Triggers validations.
    8. Fixed: Now the trailers not sum +1 (Only Trucks) to the ocupancy section counter, in inventories management.

- Dependencies Upgrade: N-A

## 2.0.2 - [16.09-2024]

- Notes:

    1. Moved the [vin] property, from [TruckCommon] set, to [Truck] and [TruckExternal] sets.
    2. Changed and added evaluations to the following sets:
        1. [Truck]
        2. [TruckCommon]
        3. [TruckExternal]  

- Dependencies Upgrade: N-A

## 2.0.1 - [03.09-2024]

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
