namespace CSM_Foundation.Server.Records;

/// <summary>
/// 
/// </summary>
public record ExceptionExposition {
    /// <summary>
    /// 
    /// </summary>
    public required string Trace { get; init; }

    /// <summary>
    /// 
    /// </summary>
    public required int Situation { get; init; }

    /// <summary>
    /// 
    /// </summary>
    public required string Advise { get; init; }

    /// <summary>
    /// 
    /// </summary>
    public required string System { get; init; }

    /// <summary>
    /// 
    /// </summary>
    public Dictionary<string, dynamic> Factors { get; init; } = [];
}
