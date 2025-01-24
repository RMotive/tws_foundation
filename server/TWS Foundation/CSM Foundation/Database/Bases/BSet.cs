using System.Reflection;

using CSM_Foundation.Convertion;
using CSM_Foundation.Core.Bases;
using CSM_Foundation.Core.Extensions;
using CSM_Foundation.Database.Exceptions;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Validators;

namespace CSM_Foundation.Database.Bases;

/// <summary>
///     
/// </summary>
public abstract class BSet
    : BObject<ISet>, ISet {

    public string Discriminator { get; init; }

    /// <summary>
    /// 
    /// </summary>
    public abstract int Id { get; set; }
    
    /// <summary>
    /// 
    /// </summary>
    public abstract DateTime Timestamp { get; set; }

    /// <summary>
    /// 
    /// </summary>
    private bool Defined = false;
    
    /// <summary>
    /// 
    /// </summary>
    private (string Property, IValidator[] Validators)[]? Validators;

    /// <summary>
    /// 
    /// </summary>
    public BSet() {
        Discriminator = $"{GetType().GUID}";
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Container"></param>
    /// <returns></returns>
    protected abstract (string Property, IValidator[])[] Validations((string Property, IValidator[])[] Container);
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Custom"></param>
    /// <exception cref="XBMigrationSet_Evaluate"></exception>
    protected void Evaluate((string Propety, IValidator[] Validators)[] Custom) {
        Validators ??= Validations([]);

        (string Propety, IValidator[] Validators)[] validators = [..Custom, ..Validators];
        (string property, XIValidator_Evaluate[] faults)[] unvalidations = [];
        int quantity = validators.Length;
        for (int i = 0; i < quantity; i++) {
            (string property, IValidator[] validations) = validators[i];
            PropertyInfo pi = GetProperty(property);
            object? value = pi.GetValue(this);


            XIValidator_Evaluate[] faults = [];
            foreach (IValidator validator in validations) {
                try {
                    validator.Evaluate(pi, value);
                } catch (XIValidator_Evaluate x) {
                    faults = [.. faults, x];
                }
            }

            if (faults.Length == 0) {
                continue;
            }

            unvalidations = [.. unvalidations, (property, faults)];
        }

        if (unvalidations.Empty()) {
            return;
        }

        throw new XBMigrationSet_Evaluate(GetType(), unvalidations);
    }
    /// <summary>
    /// 
    /// </summary>
    public void EvaluateRead() {
        Evaluate([
            (nameof(Id), [new PointerValidator()]),
            (nameof(Timestamp), [new RequiredValidator()])
        ]);
    }
    /// <summary>
    /// 
    /// </summary>
    public void EvaluateWrite() {
        Evaluate([
            (nameof(Timestamp), [new RequiredValidator()])
        ]);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public Exception[] EvaluateDefinition() {
        if (Defined) {
            return [];
        }

        Validators ??= Validations([]);
        IEnumerable<string> toEvaluate = Validators
            .Select(i => i.Property);
        Exception[] faults = [];

        // Checking if the validations defintions aren't duplicated.
        IEnumerable<string> duplicated = toEvaluate
            .GroupBy(i => i)
            .Where(g => g.Count() > 1)
            .Select(i => i.Key);
        if (duplicated.Any()) {
            faults = [
                .. faults,
                new XBMigrationSet_EvaluateDefinition(duplicated, XBMigrationSet_EvaluateDefinition.Reasons.Duplication, GetType(), null),
            ];
        }

        // Checking if all the validations defined properties exist in the class definition.
        PropertyInfo[] properties = GetType().GetProperties();
        IEnumerable<string> existProperties = properties
            .Select(i => i.Name);
        IEnumerable<string> Unexist = toEvaluate.Except(existProperties);
        if (Unexist.Any()) {
            faults = [
                    .. faults,
                new XBMigrationSet_EvaluateDefinition(Unexist, XBMigrationSet_EvaluateDefinition.Reasons.Unexist, GetType(), null),
            ];
        }

        /// Checking if properties types satisfies Validators typing boundries.
        foreach ((string property, IValidator[] validators) in Validators) {
            try {
                PropertyInfo targetProperty = GetProperty(property);

                Type propertyType = targetProperty.PropertyType;
                foreach (IValidator validator in validators) {
                    if (validator.Satisfy(propertyType)) {
                        continue;
                    }

                    faults = [.. faults, new XBMigrationSet_EvaluateDefinition([property], XBMigrationSet_EvaluateDefinition.Reasons.Unsatisfies, GetType(), validator)];
                }
            } catch {
                faults = [.. faults, new XBMigrationSet_EvaluateDefinition([property], XBMigrationSet_EvaluateDefinition.Reasons.Unreflected, GetType(), null)];
            }
        }

        if (faults.Length > 0) {
            return faults;
        }

        Defined = true;
        return [];
    }
}
