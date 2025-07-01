using CSM_Foundation.Core.Bases;
using CSM_Foundation.Core.Constants;

namespace CSM_Foundation.Convertion;

/// <summary>
///     <see cref="XBConverter"/> Exception situations enumerator.
/// </summary>
public enum XBConverterSituations {
    /// <summary>
    ///     When the <seealso cref="BConverter{T}"/> couldn't find <see cref="BConverter{T}"/> property.
    /// </summary>
    NoDiscriminator,

    /// <summary>
    ///     When the <see cref="BConverter{T}"/> didn't find the correct variation configured based 
    ///     on the <see cref="IConverterVariation.Discriminator"/> value.
    /// </summary>
    NoVariation,

    /// <summary>
    ///     When the <see cref="BConverter{TBase}.Variations"/> validations found an invalid variation.
    /// </summary>
    InvalidVariations,
}

/// <summary>
///     [Exception] for <see cref="BConverter{TBase}"/> operations.
/// </summary>
public class XBConverter
    : BException<XBConverterSituations> {

    /// <summary>
    ///     Creates a new <see cref="XBConverter"/> instance.
    /// </summary>
    /// <param name="situation">
    ///     Exception situation.
    /// </param>
    /// 
    /// <param name="discriminator">
    ///     Discriminator when the variation convertion fails.
    /// </param>
    public XBConverter(XBConverterSituations situation, Type[]? wrongVariations = null, string discriminator = "")
        : base("CSM Converter Exception", situation) {

        wrongVariations ??= [];
        Factors = new Dictionary<string, dynamic> {
            { nameof(discriminator), discriminator },
            { nameof(wrongVariations), wrongVariations },
        };
    }

    protected override Dictionary<XBConverterSituations, string> ResolveAdvise() {
        return [];
    }
}
