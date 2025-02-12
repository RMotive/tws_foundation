using CSM_Foundation.Convertion;

namespace CSM_Foundation.Database.Interfaces;

/// <summary>
///     Interface to determine the required behavior for a [Database] Set, this concept (Set) referrs to a
///     table in the [Database] storage system specifying the base properties and methods that the implementation
///     must have.
/// </summary>
public interface ISet
    : IConverterVariation {

    /// <summary>
    ///     Base unique [Database] property to identify the record easily.
    /// </summary>
    int Id { get; set; }

    /// <summary>
    ///     The exact moment where the record was created and stored in the storage system. 
    /// </summary>
    DateTime Timestamp { get; set; }

    /// <summary>
    ///     This method evaluates the current record after being read from [Database] to determine
    ///     if all ist content is correctly reviewed, this is done because there might be a posibility that some users
    ///     or administration pushes data directly into the [Database] bypassing the system programmed validations.
    ///    
    ///     <para>
    ///         This method can throw directly exceptions due to this kind of integrity methods are 
    ///         strict and must mandatory break any kind of operation into the system to prevent
    ///         wrong usage and handling of corrupt data.
    ///     </para>
    /// </summary>
    void EvaluateRead();

    /// <summary>
    ///     This method evaluates the current record to be stored in the [Database] storage system,
    ///     this helps to keep the integrity of our data into our storage systems.
    ///     
    ///     <para>
    ///         This method can throw directly exceptions due to this kind of integrity methods are 
    ///         strict and must mandatory break any kind of operation into the system to prevent
    ///         wrong usage and handling of corrupt data.
    ///     </para>
    /// </summary>
    void EvaluateWrite();





    /// <summary>
    ///     This method is used to evaluate the implementation definition, this means will evaluate
    ///     if the <see cref="EvaluateRead"/> and <see cref="EvaluateWrite"/> operations work as expected
    ///     before the system start its engine, this function might break the system rawSet up and stop advising
    ///     about the found exceptions.
    /// </summary>
    /// <returns>
    ///     Collection of exceptions found at definition evaluation.
    /// </returns>
    Exception[] EvaluateDefinition();
}

/// <summary>
///     [Converter] concept implementation for complex data structures that are derived from <see cref="ISet"/>, this converter manager must
///     be injected into the [JsonSerializerOptions] from you server implementation.
/// </summary>
public class ISetConverter
    : BConverter<ISet> {
    public override required Type[] Variations { get; init; }
}