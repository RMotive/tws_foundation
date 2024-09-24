namespace CSM_Foundation.Database.Interfaces;

/// <summary>
/// 
/// </summary>
public interface ISet {
    /// <summary>
    /// 
    /// </summary>
    public int Id { get; set; }
    /// <summary>
    /// 
    /// </summary>
    public DateTime Timestamp { get; set; }

    /// <summary>
    /// 
    /// </summary>
    public void EvaluateRead();
    /// <summary>
    /// 
    /// </summary>
    public void EvaluateWrite();
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public Exception[] EvaluateDefinition();
}