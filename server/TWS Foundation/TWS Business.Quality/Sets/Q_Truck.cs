﻿using CSM_Foundation.Databases.Quality.Bases;
using CSM_Foundation.Databases.Quality.Records;
using CSM_Foundation.Databases.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Truck : BQ_MigrationSet<Truck> {
    protected override Q_MigrationSet_EvaluateRecord<Truck>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Truck>[] Container) {
        Q_MigrationSet_EvaluateRecord<Truck> success = new() {
            Mock = new() {
                Id = 1,
                Common = 1,
                Manufacturer = 3,
                Motor = "",
                Maintenance = 4,
                Insurance = 5,
                Status = 1
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Truck> failAllCases = new() {
            Mock = new() {
                Id = -1,
                Common = 0,
                Manufacturer = 0,
                Carrier = 0,
                Motor = "",
                Vin = "",
                Status = 0
            },
            Expectations = [
                (nameof(Truck.Id), [(new PointerValidator(), 3) ]),
                (nameof(Truck.Motor), [(new LengthValidator(),2)]),
                (nameof(Truck.Vin), [(new LengthValidator(),2)]),
                (nameof(Truck.Manufacturer), [(new PointerValidator(), 3) ]),
                (nameof(Truck.Status), [(new PointerValidator(), 3) ]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}