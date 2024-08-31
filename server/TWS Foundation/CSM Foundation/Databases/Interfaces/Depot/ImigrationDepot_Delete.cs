using CSM_Foundation.Databases.Models.Out;

namespace CSM_Foundation.Databases.Interfaces.Depot;
public interface IMigrationDepot_Delete<TMigrationSet>
    where TMigrationSet : IDatabasesSet {

    public Task<DatabasesTransactionOut<TMigrationSet>> Delete(TMigrationSet[] migrations);

    public Task<TMigrationSet> Delete(TMigrationSet Set);
}
