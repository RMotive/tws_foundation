using System.Text.Json;
using System.Text.Json.Serialization;

namespace CSM_Foundation.Convertion.Bases;

/// <summary>
/// 
/// </summary>
/// <typeparam name="T"></typeparam>
public abstract class BConverter<T>
    : JsonConverter<T> {

    /// <summary>
    /// 
    /// </summary>
    public abstract Dictionary<string, Func<T, string, JsonSerializerOptions>> Variations { get; init; }


    #region JSON Converter Methods

    public override T? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
        JsonDocument document = JsonDocument.ParseValue(ref reader);
        JsonElement element = document.RootElement;

        // Determine the type from the Discriminator property.
        string? discriminator;
        try {
            discriminator = element.GetProperty("Discriminator").GetString();
        } catch {
            discriminator = element.GetProperty("discriminator").GetString();
        }

        if (discriminator is null) {
            return XBConverter();
        }
    }

    public override void Write(Utf8JsonWriter writer, T value, JsonSerializerOptions options) {

    }

    #endregion
}
