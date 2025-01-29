using System.Text.Json;
using System.Text.Json.Serialization;

namespace CSM_Foundation.Convertion;

/// <summary>
/// 
/// </summary>
/// <typeparam name="T"></typeparam>
public abstract class BConverter<T>
    : JsonConverter<T>, IConverter
    where T : IConverterVariation {


    public virtual Type[] Variations { get; init; } = [];

    #region JSON Converter Methods

    /// <summary>
    /// 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="typeToConvert"></param>
    /// <param name="options"></param>
    /// <returns></returns>
    /// <exception cref="XBConverter"></exception>
    public override T? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
        JsonDocument document = JsonDocument.ParseValue(ref reader);
        JsonElement element = document.RootElement;

        // Determine the type from the Discriminator property.
        string? discriminator;
        string discriminatorToken = nameof(IConverterVariation.Discriminator);
        try {
            discriminator = element.GetProperty(discriminatorToken).GetString();
        } catch {
            discriminator = element.GetProperty(discriminatorToken.ToLower()).GetString();
        }

        if (string.IsNullOrWhiteSpace(discriminator)) {
            throw new XBConverter(XBConverterSituations.NoDiscriminator);
        }

        foreach (Type variation in Variations) {
            if (discriminator == variation.Name) {
                return (T?)JsonSerializer.Deserialize(element, variation, options);
            }
        }

        throw new XBConverter(XBConverterSituations.NoVariation, discriminator);
    }

    /// <summary>
    ///     
    /// </summary>
    /// <param name="writer"></param>
    /// <param name="value"></param>
    /// <param name="options"></param>
    public override void Write(Utf8JsonWriter writer, T value, JsonSerializerOptions options) {
        foreach (Type variation in Variations) {
            if (value.GetType().GUID == variation.GUID) {
                JsonSerializer.Serialize(writer, variation, options);
            }
        }

        throw new XBConverter(XBConverterSituations.NoVariation, "Writing operation don't access discriminator");
    }

    #endregion
}
