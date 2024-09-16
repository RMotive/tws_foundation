using System.Text.Json.Serialization;

using CSM_Foundation.Databases.Interfaces;

namespace CSM_Foundation.Databases.Models;
/// <summary>
/// 
/// </summary>
public record SourceTransactionFailure<TSet> where TSet : IDatabasesSet {
    /// <summary>
    /// 
    /// </summary>
    public TSet Set { get; init; }
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
    public SourceTransactionFailure(TSet Set, Exception SystemInternal) {
        this.Set = Set;
        this.SystemInternal = SystemInternal;
        System = SystemInternal.Message;
    }
}