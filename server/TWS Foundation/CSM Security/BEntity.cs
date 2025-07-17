using System.Text.Json.Serialization;

namespace CSM_Security;

/// <summary>
///     [Abstract] for [CSM Security] database entities implementations.
/// </summary>
/// <remarks>
///     Usage must be exclusively for [CSM Security] entities.
/// </remarks>
public abstract class BEntity
    : CSM_Foundation.Database.BEntity {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}

