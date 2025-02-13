using CSM_Foundation.Database.Entity;

namespace CSM_Foundation.Database.Models.Out;

/// <summary>
///     
/// </summary>
/// <typeparam name="TMigrationSet"></typeparam>
public class RecordUpdateOut<TMigrationSet>
    where TMigrationSet : IEntity {
    /// <summary>
    /// 
    /// </summary>
    public required TMigrationSet Updated { get; set; }
    /// <summary>
    /// 
    /// </summary>
    public TMigrationSet? Previous { get; set; }
}
