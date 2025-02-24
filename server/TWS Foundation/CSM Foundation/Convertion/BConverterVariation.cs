namespace CSM_Foundation.Convertion;

/// <summary>
///     Generates the base managing data and operations for a [Convertable] object, used by 
///     the [CSM Convertion] concept. This Base class automatically loads primary information and methods
///     to make the [CSM Convertion] implementation easier.
///     
///     <para>
///         By default <see cref="Discriminator"/> must be the GUID runtime type of the object (<see cref="Type.GUID"/>)
///     </para>
/// </summary>
public abstract class BConverterVariation
    : IConverterVariation {

    public string Discriminator { get; init; }

    /// <summary>
    ///     Creates a new <see cref="BConverterVariation"/> base object. 
    /// </summary>
    public BConverterVariation() {
        Discriminator = $"{GetType().GUID}";
    }
}
