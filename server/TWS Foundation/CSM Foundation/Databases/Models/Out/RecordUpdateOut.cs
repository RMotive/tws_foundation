using CSM_Foundation.Databases.Interfaces;

namespace CSM_Foundation.Databases.Models.Out;

/// <summary>
///     
/// </summary>
/// <typeparam name="TMigrationSet"></typeparam>
public class RecordUpdateOut<TMigrationSet>
    where TMigrationSet : ISourceSet {
    /// <summary>
    /// 
    /// </summary>
    public required TMigrationSet Updated { get; set; }
    /// <summary>
    /// 
    /// </summary>
    public TMigrationSet? Previous { get; set; }
}
