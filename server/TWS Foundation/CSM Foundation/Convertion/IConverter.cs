namespace CSM_Foundation.Convertion;


/// <summary>
///     <see cref="interface"/> to access required <see cref="IConverter"/> implementation
///     contract.
///     
///     This [Converter] concepto is composed to create a self-managed object convertion for complex
///     data structures.
/// </summary>
public interface IConverter<T> {
    /// <summary>
    ///     Stores all the derived <see cref="Type"/> information from this <see cref="IConverter"/>
    ///     implementation.
    /// </summary>
    public Type[] Variations { get; init; }
}
