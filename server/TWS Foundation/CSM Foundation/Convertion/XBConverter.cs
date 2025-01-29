using CSM_Foundation.Core.Bases;

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
}

/// <summary>
///     
/// </summary>
public class XBConverter
    : BException<XBConverterSituations> {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="Subject"></param>
    /// <param name="Status"></param>
    /// <param name="System"></param>
    public XBConverter(XBConverterSituations Situation, string Discriminator = "")
        : base("CSM Converter Exception", Situation) {

        Factors.Add(nameof(Discriminator), Discriminator);
    }
}
