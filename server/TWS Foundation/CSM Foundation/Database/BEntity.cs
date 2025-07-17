using System.ComponentModel.DataAnnotations.Schema;
using System.Reflection;
using System.Text.Json.Serialization;

using CSM_Foundation.Convertion;
using CSM_Foundation.Core.Bases;
using CSM_Foundation.Database.Validations;

namespace CSM_Foundation.Database;

/// <summary>
///     Represents a tenant business live stored entity model, that usually are objects wich data are grouped by bound that 
///     instrinsictly defines their own.
/// </summary>
public interface IEntity
    : IConverterVariation {

    /// <summary>
    ///     Type of the <see cref="IDatabase"/> implementation that stores this <see cref="IEntity"/> implementation.
    /// </summary>
    [JsonIgnore, NotMapped]
    Type Database { get; init; }

    /// <summary>
    ///     Unique data storages direct pointer identifier.
    /// </summary>
    long Id { get; set; }

    /// <summary>
    ///     Time mark for the last time this <see cref="IEntity"/> got created and stored into data storage sources.
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
///     Represents a tenant business live stored entity model, that usually are objects wich data are grouped by bound that 
///     instrinsictly defines their own.
///     
///     <para>
///         This abtract base provides { CSM } built-in behaviors for a very low level <see cref="IEntity"/> implementation
///     </para>
/// </summary>
public abstract partial class BEntity
    : BObject<IEntity>, IEntity {

    #region Server Side Properties

    [NotMapped, JsonPropertyOrder(0)]
    public string Discriminator { get; init; }

    [NotMapped, JsonIgnore]
    public abstract Type Database { get; init; }

    #endregion


    public long Id { get; set; }

    public DateTime Timestamp { get; set; } = DateTime.UtcNow;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    public BEntity() {
        Discriminator = $"{GetType().GUID}";
    }

    protected void Evaluate() {

        foreach (PropertyInfo property in GetType().GetProperties()) {

            IEnumerable<BValidator> attributes = property.GetCustomAttributes<BValidator>();
            if (!attributes.Any())
                return;

            foreach (BValidator validator in attributes) {
                try {
                    validator.Evaluate(this);
                } catch {

                }
            }
        }
    }

    public void EvaluateRead() {
        Evaluate();
    }

    public void EvaluateWrite() {
        Evaluate();
    }

    public Exception[] EvaluateDefinition() {
        return [];
    }
}
