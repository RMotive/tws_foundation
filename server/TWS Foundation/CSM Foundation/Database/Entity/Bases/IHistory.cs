namespace CSM_Foundation.Database.Entity.Bases;

/// <summary>
///     [Interface] for History entities implementations.
/// </summary>
public interface IHistory 
    : IEntity {
    
    /// <summary>
    ///     Determines the sequence of the history entries.
    /// </summary>
    long Sequence { get; set; }
}
