using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Convertion.Bases;
using CSM_Foundation.Core.Utils;

namespace CSM_Foundation.Database.Interfaces;

/// <summary>
/// 
/// </summary>
public interface ISet {

    /// <summary>
    ///     Specifies the unique signature for the class that is based on <see cref="ISet"/>, this discriminator
    ///     is used to know how to deserealize an <see cref="ISet"/> based object from a serialized request.
    /// </summary>
    [JsonPropertyOrder(0)]
    string Discriminator { get; init; }

    /// <summary>
    /// 
    /// </summary>
    int Id { get; set; }
    /// <summary>
    /// 
    /// </summary>
    DateTime Timestamp { get; set; }

    /// <summary>
    /// 
    /// </summary>
    void EvaluateRead();
    /// <summary>
    /// 
    /// </summary>
    void EvaluateWrite();
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    Exception[] EvaluateDefinition();
}


/// <summary>
///     A <see cref="JsonConverter"/> implementation fot <see cref="ISet"/>
/// </summary>
public class ISetConverter
    : BConverter<ISet> {

    public override required Dictionary<string, Func<ISet, string, JsonSerializerOptions>> Variations { get; init; }
}