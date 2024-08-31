﻿using CSM_Foundation.Databases.Interfaces;

namespace CSM_Foundation.Databases.Quality.Records;
public record Q_MigrationSet_EvaluateRecord<TSet>
    where TSet : IDatabasesSet {

    public (string, (IValidator, int)[])[] Expectations { get; init; } = [];
    public TSet Mock { get; init; } = default!;

    public Q_MigrationSet_EvaluateRecord() { }

    public Q_MigrationSet_EvaluateRecord((string, (IValidator, int)[])[] Expectations, TSet Mock) {
        this.Expectations = Expectations;
        this.Mock = Mock;
    }
}
