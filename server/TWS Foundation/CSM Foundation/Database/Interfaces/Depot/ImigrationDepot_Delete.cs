using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Database.Interfaces.Depot;
public interface IMigrationDepot_Delete<TMigrationSet>
    where TMigrationSet : IDatabasesSet {

    public Task<DatabasesTransactionOut<TMigrationSet>> Delete(TMigrationSet[] migrations);

    public Task<TMigrationSet> Delete(TMigrationSet Set);
}
