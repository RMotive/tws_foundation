using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace CSM_Foundation.Convertion;

/// <summary>
///     Interface to determine a variation to the <see cref="BConverter{T}"/> implementation.
/// </summary>
public interface IConverterVariation {

    /// <summary>
    ///     Unique operation time variation identification for transaction convertions.
    ///     
    ///     <para> 
    ///         Additional has <see cref="JsonPropertyOrderAttribute"/> set as 0 to always be the first
    ///         property to be converted.
    ///     </para>
    /// </summary>
    [JsonPropertyOrder(0), NotMapped]
    string Discriminator { get; init; }
}
