using System.Text.Json.Serialization;

using CSM_Database_Core;

namespace CSM_Security.Abstractions;

/// <summary>
///     [Abstract] for [CSM Security] database entities implementations.
/// </summary>
/// <remarks>
///     Usage must be exclusively for [CSM Security] entities.
/// </remarks>
public abstract class BEntity
    : EntityBase {

    [JsonIgnore]
    public override Type Database { get; init; } = typeof(Database);
}

