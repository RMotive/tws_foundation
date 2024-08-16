using CSM_Foundation.Databases.Models.Out;

namespace CSM_Foundation.Databases.Interfaces.Depot;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TMigrationSet"></typeparam>
public interface IMigrationDepot_Update<TMigrationSet>
    where TMigrationSet : ISourceSet {
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <returns></returns>
    Task<RecordUpdateOut<TMigrationSet>> Update(TMigrationSet Set);
}
