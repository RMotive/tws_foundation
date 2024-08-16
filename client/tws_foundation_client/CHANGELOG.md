# CHANGELOG

## 2.0.0 [09/07/2024]

- Changed the naming convention from concept [Migration] to [Source]
- Changed the naming from [MigrationView] to [SetView]
- Separated concepts above [options] classes and [out] classes

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
