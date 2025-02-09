# CHANGELOG

## X.X.X - [XX.XX-2025]

- Notes:

    1. Now the Customer project implementations are going to be tested.

        - Creates a new [BQ_Service] to facilitate Quality Suits for Service implementations.

    2. Changes on [SetViewOut] model.

        - [SetViewOut.Amount] changed to [SetViewOut.Count].

        - [SetViewOut.Records] changed to [SetViewOut.Length].

        - [SetViewOut.Sets] changed to [SetViewOut.Records].

    3. Added [Q_SecurityService] quality suit.

    4. Added [IService] as an interface for Customer services common operations as Create, View, Update, Delete.

    5. Added [Interfaces] for [Depots] and updating depedency injection management for them.

    6. Added the [Delete(int Id)] overload method for [IDepot_Delete] interface as was present in the [BDepot] but not in an interface and logic wasn't able to call that method.

- Fixes:

    1. Fixed a problem with [SessionManager], was trying to get an account with an incorrect include instruction using [Contact] instead of [ContactNavigation].

- Dependencies:

## 7.1.1 - [29.01-2025]

- Notes:

    1. Changes on [ExportInventoryOut] -> [ExportOut]
        - Changed property [type] -> [extension]: also now is a enumerator to create a bound for the available extensions [ExportOutExtensions].
        - Improved documentation.

    2. Added [ExportView] service for [YardLog] to generate an exportable for the generic [View] operation.

- Fixes: N/A

- Dependencies:

    | Package                                 | Previous Version | New Version     |
    |:----------------------------------------|:----------------:|:---------------:|
    | ClosedXML                               | 0.104.2          | 0.104.2         |
    | coverlet.collector                      | 6.2.4            | 6.2.4           |
    | Microsoft.AspNetCore.Mvc.Testing        | 9.0.1            | 9.0.1           |
    | Microsoft.EntityFrameworkCore           | 9.0.1            | 9.0.1           |
    | Microsoft.EntityFrameworkCore.SqlServer | 9.0.1            | 9.0.1           |
    | Microsoft.IdentityModel.Tokens          | 8.3.1            | 8.3.1           |
    | Microsoft.NET.Test.Sdk                  | 17.12.0          | 17.12.0         |
    | xunit                                   | 2.9.3            | 2.9.3           |
    | xunit.runner.visualstudio               | 3.0.1            | 3.0.1           |

## 7.1.0 - [28.01-2025]

- Notes:

    1. Included [ExportViewInventory] service, allowing to generate an excel file based on a [ViewInventory] results.

- Fixes: N/A

- Dependencies:

    | Package                                 | Previous Version | New Version     |
    |:----------------------------------------|:----------------:|:---------------:|
    | ClosedXML                               | ---              | 0.104.2         |
    | coverlet.collector                      | 6.2.0            | 6.2.4           |
    | Microsoft.AspNetCore.Mvc.Testing        | 9.0.0            | 9.0.1           |
    | Microsoft.EntityFrameworkCore           | 9.0.0            | 9.0.1           |
    | Microsoft.EntityFrameworkCore.SqlServer | 9.0.0            | 9.0.1           |
    | Microsoft.IdentityModel.Tokens          | 8.2.1            | 8.3.1           |
    | Microsoft.NET.Test.Sdk                  | 17.12.0          | 17.12.0         |
    | xunit                                   | 2.9.2            | 2.9.3           |
    | xunit.runner.visualstudio               | 2.9.2            | 3.0.1           |

## 7.0.2 - [04.12-2024]

- Notes:

    1. Changed the minimun length validation to [VIN] proterty in [Truck] & [TruckExternal] sets from 17 to 1.

- Fixes: N/A

- Dependencies:

    | Package                                 | Previous Version | New Version     |
    |:----------------------------------------|:----------------:|:---------------:|
    | coverlet.collector                      | ---              | 6.2.0           |
    | Microsoft.AspNetCore.Mvc.Testing        | 8.0.10           | 9.0.0           |
    | Microsoft.EntityFrameworkCore           | 8.0.10           | 9.0.0           |
    | Microsoft.EntityFrameworkCore.SqlServer | 8.0.10           | 9.0.0           |
    | Microsoft.IdentityModel.Tokens          | 8.1.2            | 8.2.1           |
    | Microsoft.NET.Test.Sdk                  | 17.11.1          | 17.12.0         |
    | xunit                                   | 2.9.2            | 2.9.2           |
    | xunit.runner.visualstudio               | 2.9.2            | 2.9.2           |

## 7.0.1 - [03.12-2024]

- Notes: N/A

- Fixes:

    1. Now the Server exposes correctly the DateTime objects offset as UTC.

- Dependencies:

    | Package                                 | Previous Version | New Version     |
    |:----------------------------------------|:----------------:|:---------------:|
    | coverlet.collector                      | ---              | 6.2.0           |
    | Microsoft.AspNetCore.Mvc.Testing        | 8.0.10           | 9.0.0           |
    | Microsoft.EntityFrameworkCore           | 8.0.10           | 9.0.0           |
    | Microsoft.EntityFrameworkCore.SqlServer | 8.0.10           | 9.0.0           |
    | Microsoft.IdentityModel.Tokens          | 8.1.2            | 8.2.1           |
    | Microsoft.NET.Test.Sdk                  | 17.11.1          | 17.12.0         |
    | xunit                                   | 2.9.2            | 2.9.2           |
    | xunit.runner.visualstudio               | 2.9.2            | 2.9.2           |

## 7.0.0 - [18.11-2024]

- Notes:

    1. Updated how [Auth] decorator is configured, no more needed to set [Permits] reference now only needs [Feature] and [Action] name.
    2. Now [Permit] uses [Action], [Solution] and [Feature] to calculate its privilege level.
    3. Changed name from [XMigrationTransaction] to [XSetOperation] to maintina consistency.
    4. Now [SessionManager] is a singleton dependency in the system, still supporting concurrent calls.
        - SessionManager got refactorized removing a lot of methods and creating new ones.

    5. Now [AuthAttribute] that is out Authentication middleware catches if the request is being intended for Quality purposes and
       check if the account has that kind of privileges if not will block the quality context calls.

- Fixes:

    1. Fixed a problem when someone tried to fetch the exact amount of data available on a [View] method was causing a 0 records returning due to a miss calculation.

- Remarks:

    1. Updated .Net from 8.0 to 9.0

- Dependencies:

    | Package                                 | Previous Version | Current Version |
    |:----------------------------------------|:----------------:|:---------------:|
    | coverlet.collector                      | ---              | 6.2.0           |
    | Microsoft.AspNetCore.Mvc.Testing        | 8.0.10           | 9.0.0           |
    | Microsoft.EntityFrameworkCore           | 8.0.10           | 9.0.0           |
    | Microsoft.EntityFrameworkCore.SqlServer | 8.0.10           | 9.0.0           |
    | Microsoft.IdentityModel.Tokens          | 8.1.2            | 8.2.1           |
    | Microsoft.NET.Test.Sdk                  | 17.11.1          | 17.11.1         |
    | xunit                                   | 2.9.2            | 2.9.2           |
    | xunit.runner.visualstudio               | 2.9.2            | 2.9.2           |

## 6.0.0 - [03.11-2024]

- Notes:

    1. Changed Section property to nulleable in [Yardlog] set.
    2. Now new trailers registered in yardlogs sum +1 to sections occupancy.
    3. Refactorized [ViewInventory] method from [YardLogDepot] to calculate it based on [Trailers] and [TrailersExternal] instead of using [Trucks] and [TrucksExternal]

- Dependencies:

    1. Microsoft.AspNetCore.Mvc.Testing ([8.0.10])
    2. Microsoft.EntityFrameworkCore ([8.0.10])
    3. Microsoft.EntityFrameworkCore.SqlServer ([8.0.10])
    4. Microsoft.IdentityModel.Tokens ([8.1.2])
    5. Microsoft.NET.Test.Sdk ([17.11.1])
    6. xunit ([2.9.2])

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
