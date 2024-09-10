using System.Text.Json.Serialization;

using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Models;
/// <summary>
/// 
/// </summary>
public record SetOperationFailure {
    /// <summary>
    /// 
    /// </summary>
    public ISet Set { get; init; }
    /// <summary>
    /// 
    /// </summary>
    public string System { get; init; }
    /// <summary>
    /// 
    /// </summary>
    [JsonIgnore]
    public Exception SystemInternal { get; init; }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <param name="SystemInternal"></param>
    public SetOperationFailure(ISet Set, Exception SystemInternal) {
        this.Set = Set;
        this.SystemInternal = SystemInternal;
        System = SystemInternal.Message;
    }
}