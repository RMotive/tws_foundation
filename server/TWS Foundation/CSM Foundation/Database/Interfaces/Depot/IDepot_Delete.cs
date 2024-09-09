﻿using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Database.Interfaces.Depot;
public interface IDepot_Delete<TMigrationSet>
    where TMigrationSet : ISet {

    public Task<SetComplexOut<TMigrationSet>> Delete(TMigrationSet[] migrations);

    public Task<TMigrationSet> Delete(TMigrationSet Set);
}
