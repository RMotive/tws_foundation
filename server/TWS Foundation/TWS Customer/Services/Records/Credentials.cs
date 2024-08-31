namespace TWS_Customer.Services.Records;

/// <summary>
///     
/// </summary>
public record Credentials {
    /// <summary>
    /// 
    /// </summary>
    public required string Sign { get; set; }
    /// <summary>
    /// 
    /// </summary>
    public required string Identity { get; init; }
    /// <summary>
    /// 
    /// </summary>
    public required byte[] Password { get; init; }
}
