using System.ComponentModel.DataAnnotations.Schema;
using System.Reflection;
using System.Text.Json.Serialization;

using CSM_Foundation.Core.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Exceptions;
using CSM_Foundation.Database.Validations;

namespace CSM_Foundation.Database.Bases;

/// <summary>
///     [Abstract] class for <see cref="BEntity"/> implementations.
///     
///     A Entity is a table into a data storage, defining properties and relations stored.
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
    ///     
    /// </summary>
    public BEntity() {
        Discriminator = $"{GetType().GUID}";
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Custom"></param>
    /// <exception cref="XBEntity_Evaluate"></exception>
    protected void Evaluate() {

        foreach (PropertyInfo property in GetType().GetProperties()) {

            IEnumerable<BValidator> attributes = property.GetCustomAttributes<BValidator>();
            if(attributes.Any()) {
                foreach (BValidator validator in attributes) {
                    try {
                        validator.Evaluate(this);
                    } catch (XIValidator_Evaluate x) { 
                    
                    }
                }
            }
        }
    }

    /// <summary>
    /// 
    /// </summary>
    public void EvaluateRead() {
        Evaluate();
    }

    /// <summary>
    /// 
    /// </summary>
    public void EvaluateWrite() {
        Evaluate();
    }

    public Exception[] EvaluateDefinition() {
        return [];
    }
}
