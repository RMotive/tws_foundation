﻿using CSM_Foundation.Database.Exceptions;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Quality.Records;

using Microsoft.EntityFrameworkCore.Metadata.Internal;

using Xunit;

namespace CSM_Foundation.Database.Quality.Bases;
/// <summary>
///     Base Quality for [Q_Entity].
///     
///     Defines what quality operations must be performed by a [Q_Entity].
///     
///     [Q_Entity] concept: determines a quality implementation to qualify 
///     a [MigrationDatabases] [Entity] implementation.
/// </summary>
public abstract class BQ_Set<TSet>
    where TSet : ISet, new() {

    protected abstract Q_MigrationSet_EvaluateRecord<TSet>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TSet>[] Container);

    [Fact]
    public void EvaluateDefinition() {
        TSet mock = new();
        _ = mock.EvaluateDefinition();
    }

    [Fact]
    public void Evaluate() {
        Q_MigrationSet_EvaluateRecord<TSet>[] checks = EvaluateFactory([]);


        foreach (Q_MigrationSet_EvaluateRecord<TSet> qualityCheck in checks) {
            TSet mock = qualityCheck.Mock;
            (string property, (IValidator validator, int code)[] reasons)[] asserts = qualityCheck.Expectations;

            // --> The set is expected to not throw exceptions
            if (asserts.Length == 0) {
                continue;
            }

            // --> Here are asserts to perform
            try {
                mock.EvaluateRead();
                if (asserts.Length == 0) {
                    continue;
                }

                Assert.Fail("Asserts expected but none caught");
            } catch (XBMigrationSet_Evaluate x) {
                (string property, XIValidator_Evaluate[] faults)[] unvalidations = x.Unvalidations;

                Assert.True(asserts.Length.Equals(unvalidations.Length), $"Check ({qualityCheck.Name}) at ({typeof(TSet).Name}) set \nExpected: ({asserts.Length} asserts) \nActual: ({unvalidations.Length} errors)");


                unvalidations = [.. unvalidations.OrderBy(x => x.property)];
                asserts = [.. asserts.OrderBy(x => x.property)];

                for (int i = 0; i < unvalidations.Length; i++) {
                    (string Property, XIValidator_Evaluate[] Faults) = unvalidations[i];
                    (string Property, (IValidator Validator, int Code)[] Reasons) assert = asserts[i];

                    Assert.Equal(assert.Property, Property);
                    Assert.Equal(assert.Reasons.Length, Faults.Length);

                    XIValidator_Evaluate[] faults = Faults;
                    (IValidator Validator, int Code)[] reasons = assert.Reasons;

                    faults = [.. faults.OrderBy(i => i.Code)];
                    reasons = [.. reasons.OrderBy(i => i.Code)];

                    for (int j = 0; j < faults.Length; j++) {
                        XIValidator_Evaluate fault = faults[j];
                        (IValidator Validator, int Code) = reasons[j];


                        Assert.True(Code.Equals(fault.Code), $"Check ({qualityCheck.Name}) at ({typeof(TSet).Name}) set at property ({Property}) \nExpected: ({Code}) \nActual: ({fault.Code})");
                        Assert.True(Validator.GetType() == fault.Validator.GetType(), $"Check ({qualityCheck.Name}) at ({typeof(TSet).Name}) set at property ({Property}) \nExpected: ({Validator.GetType()}) \nActual: {fault.Validator.GetType()}");
                    }
                }
            }
        }
    }
}
