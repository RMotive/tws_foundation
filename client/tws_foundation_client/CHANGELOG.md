# CHANGELOG

## CURRENT - [xx.xx-xxxx]

- Notes: 

    1. [TrucksExternals] Create & update service methods added and tested.
    2. [Trucks] tests refactored.
    3. Timestamp property added to sets.
    4. Added [VehiculeModel] set.
    5. Added [TrailerType] set.
    6. Added [TrailerClass] set.
    7. The following sets have receive minor properties changes:
        * [Approach]
        * [Driver]
        * [Employee]
        * [Plate]
        * [TrailerExternal]
        * [TruckExternal]
    8. The following sets have receive breaking changes in their structure:
        * [Manufacturer] -  has been normalized. Now this sets stores the brand name for trucks and trailers manufacturers.
        * [TrailerCommon] - Added the trailerType navigation.
        * [Trailer] - Added Vehicule Model navigation. 
        * [Truck] - Added Vehicule Model navigation & SCT navigation.
        * [Carrier] -  Removed SCT navigation.

- Dependencies Upgrade: N/A

## 4.1.0 - [23.09-2024]

- Notes:

    1. Added validation in [Yardlog] set, for trailers when "Botado" load type is not selected.

- Dependencies Upgrade: N/A

## 4.0.0 - [16.09-2024]

- Notes:

    1. Moved the [vin] property, from [TruckCommon] set, to [Truck] and [TruckExternal] sets.
    2. [entry] and [damage] properies set to "optional" for client-side.
    3. Changed and added evaluations to the following sets:
        1. [Truck]
        2. [TruckCommon]
        3. [TruckExternal]

  - Services:

    1. [YardLogs] added new action naed [ViewInventory] that provides from the current Yard trucks inventory.

  - Models:

    1. [MigrationView] -> [SetViewOut]
    2. [MigrationViewOptions] -> [SetViewOptions]

        - Added [filters] to specify bonds along queries.

            1. [SetViewFilterLinearEvaluation] allows to filter entries by logical operators based on specific filters.
            2. [SetViewDateFilter] allows to filter entries based on DateTime proeprties specifying limits between dates to show up entries.
            3. [SetViewPropertyFilter] allows to filter entries based on a property an operator and a value to evaluate the operator.

    3. [MigrationViewOrderOptions] -> [SetViewOrderOptions]
    4. [MigrationViewOrderBehaviors] -> [SetViewOrderings]

- Dependencies Upgrade:

    1. Template

## 3.0.0 - [03.09-2024]

- Notes:

    1. Changed the test screts management to [CI/CD].
    2. Changes in Bussines sets to refactor [Plates] realtionships.
    3. [Trailers] and [Trucks] inventory database implementation.
    4. [Yardlogs] client validations implementations.
    5. [Commons] bussines tables relationships refactor.

- Dependencies Upgrade:

    1. dotenv ([4.2.0])

## 2.0.0 - [09.07-2024]

- Notes:

    1. Changed the naming convention from concept [Migration] to [Source]
    2. Changed the naming from [MigrationView] to [SetView]
    3. Separated concepts above [options] classes and [out] classes

        1. [options] classes define data to perform correctly actions or operations.
        2. [out] classes define data resulted by operations or actions.

- Dependencies upgrade:

    1. test ([1.25.7] -> [1.25.8])
    2. test_api ([0.7.2] -> [0.7.3])
    3. test_core ([0.6.4] -> [0.6.5])

## 1.1.3

- Dependencies upgrade:

    1. collection ([1.18.0] -> [1.19.0])
    2. csm_foundation_service ([5.1.0] -> [6.0.0])
    3. http_parser ([4.0.2] -> [4.1.0])
    4. shelf ([1.4.1] -> [1.4.2])
    5. vm_service ([14.2.3] -> [14.2.4])

        - Major Versions
            1. lints ([3.0.0] -> [4.0.0])

## 1.1.2

- Now [onExcpetion] resolutions is required for the MainResolver.

## 1.1.1

- Added [auth] to [View] action from [SolutionsService] to authenticate the request.
- Added [SecurotyService] to provide service for [Security] control from [TWS Administration] source.
- Added [Authenticate] action that provides authentication request to [TWS Administration] server and gathers a token to authenticate requests.

## 1.0.1

- Added [amount] property to [MigrationView] model to store the total amount of records at the live database.

## 1.0.0

- Initial version.
