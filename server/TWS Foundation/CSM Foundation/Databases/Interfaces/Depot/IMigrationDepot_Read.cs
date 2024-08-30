﻿using System.Linq.Expressions;

using CSM_Foundation.Databases.Enumerators;
using CSM_Foundation.Databases.Models.Out;

namespace CSM_Foundation.Databases.Interfaces.Depot;
public interface IMigrationDepot_Read<TMigrationSet>
    where TMigrationSet : IDatabasesSet {

    public Task<DatabasesTransactionOut<TMigrationSet>> Read(Expression<Func<TMigrationSet, bool>> Predicate, MigrationReadBehavior Behavior, Func<IQueryable<TMigrationSet>, IQueryable<TMigrationSet>>? Incluide = null);
}