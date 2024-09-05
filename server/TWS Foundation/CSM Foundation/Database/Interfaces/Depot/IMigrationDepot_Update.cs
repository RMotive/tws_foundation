using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Database.Interfaces.Depot;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TMigrationSet"></typeparam>
public interface IMigrationDepot_Update<TMigrationSet>
    where TMigrationSet : IDatabasesSet {
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <returns></returns>
    Task<RecordUpdateOut<TMigrationSet>> Update(TMigrationSet Set, Func<IQueryable<TMigrationSet>, IQueryable<TMigrationSet>>? Include = null);
}
