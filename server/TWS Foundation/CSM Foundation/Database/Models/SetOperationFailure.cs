using System.Text.Json.Serialization;

using CSM_Foundation.Database.Entity;

namespace CSM_Foundation.Database.Models;
/// <summary>
/// 
/// </summary>
public record SetOperationFailure<TSet>
    where TSet : IEntity {
    /// <summary>
    /// 
    /// </summary>
    public TSet Set { get; init; } = default!;
    /// <summary>
    /// 
    /// </summary>
    public string System { get; init; } = string.Empty;
    /// <summary>
    /// 
    /// </summary>
    [JsonIgnore]
    public Exception SystemInternal { get; init; } = default!;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <param name="SystemInternal"></param>
    public SetOperationFailure(TSet Set, Exception SystemInternal) {
        this.Set = Set;
        this.SystemInternal = SystemInternal;
        System = SystemInternal.Message;
    }

    public SetOperationFailure() { }
}