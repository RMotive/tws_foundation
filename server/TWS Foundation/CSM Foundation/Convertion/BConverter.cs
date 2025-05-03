using System.Text.Json;
using System.Text.Json.Serialization;

namespace CSM_Foundation.Convertion;

/// <summary>
///     [Abstraction] for serialization/deseralization custom converters.
/// </summary>
/// <typeparam name="TBase">
///     Type of the common inherited interface/class from the variants.
/// </typeparam>
public abstract class BConverter<TBase>
    : JsonConverter<TBase>, IConverter<TBase>
    where TBase : IConverterVariation {

    /// <summary>
    ///     Stores all the possible variations classes types to find the correct one.
    /// </summary>
    public Type[] Variations { get; init; }

    /// <summary>
    ///     Creates a new <see cref="BConverter{TBase}"/> instance.
    /// </summary>
    public BConverter(Type[] variations) {
        Variations = variations;
        ValidateVariations();
    }

    #region Private Methods

    /// <summary>
    ///     Validates if the configured <see cref="Variations"/> correctly inherit from the <typeparamref name="TBase"/>.
    /// </summary>
    /// <exception cref="XBConverter">
    ///     Thrown when a wrong variation is found.
    /// </exception>
    void ValidateVariations() {
        if(Variations.Length == 0) return;

        IEnumerable<Type> wrongTypes = Variations.Where(
                (variation) => {
                    return !variation.IsAssignableTo(typeof(TBase));
                }
            );

        if (wrongTypes.Any()) {
            throw new XBConverter(
                    XBConverterSituations.InvalidVariations,
                    [.. wrongTypes]
                );
        }
    }

    #endregion

    #region JSON Converter Methods

    /// <summary>
    /// 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="typeToConvert"></param>
    /// <param name="options"></param>
    /// <returns></returns>
    /// <exception cref="XBConverter"></exception>
    public override TBase? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
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
            if (discriminator == variation.GetType().Name) {
                return (TBase?)JsonSerializer.Deserialize(element, variation.GetType(), options);
            }
        }

        throw new XBConverter(
                XBConverterSituations.NoVariation,
                discriminator: discriminator
            );
    }

    /// <summary>
    ///     
    /// </summary>
    /// <param name="writer"></param>
    /// <param name="value"></param>
    /// <param name="options"></param>
    public override void Write(Utf8JsonWriter writer, TBase value, JsonSerializerOptions options) {
        foreach (Type variation in Variations) {

            if (value.GetType().GUID == variation.GUID) {
                JsonSerializer.Serialize(writer, variation, options);
            }
        }

        throw new XBConverter(XBConverterSituations.NoVariation);
    }

    #endregion
}
