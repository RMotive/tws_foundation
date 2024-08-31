using System.ComponentModel.DataAnnotations;

namespace TWS_Customer.Managers.Records;

/// <summary>
///     
/// </summary>
public record SolutionConfiguration {
    /// <summary>
    /// 
    /// </summary>
    [MaxLength(5)]
    public required string Sign { get; init; }
    /// <summary>
    /// 
    /// </summary>
    public required bool Enabled { get; init; }
    /// <summary>
    /// 
    /// </summary>
    public required string Login { get; init; }
}
