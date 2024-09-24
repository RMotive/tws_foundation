using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Models.Out;

/// <summary>
///     
/// </summary>
/// <typeparam name="TMigrationSet"></typeparam>
public class RecordUpdateOut<TMigrationSet>
    where TMigrationSet : ISet {
    /// <summary>
    /// 
    /// </summary>
    public required TMigrationSet Updated { get; set; }
    /// <summary>
    /// 
    /// </summary>
    public TMigrationSet? Previous { get; set; }
}
