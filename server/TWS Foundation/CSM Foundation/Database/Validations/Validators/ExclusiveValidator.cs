using System.Reflection;
using System.Collections.Generic;

namespace CSM_Foundation.Database.Validations.Validators;

[AttributeUsage(AttributeTargets.Property)]
///
public class ExclusiveValidator
    : BValidator {

    protected readonly string Group;

    public ExclusiveValidator(string group = "") { 
        Group = group;
     }

    public override bool Evaluate(object? value) {
        // Return false if the input value is null.
        if (value == null) return false;

        // Dictionary to store different [ExclusiveValidator] groups.
        // Key: group ID (string).
        // Value: flag indicating if the content is non-empty (bool).
        Dictionary<string, bool> groups = [];

        // Get all properties of the input object.
        PropertyInfo[] properties = value.GetType().GetProperties();

        foreach (PropertyInfo property in properties) {
            // Retrieve all attributes of type [ExclusiveValidator] associated with the property.
            IEnumerable<Attribute> attributes = property.GetCustomAttributes<ExclusiveValidator>();

            foreach (Attribute attribute in attributes) {
                // Check if the attribute is of type [ExclusiveValidator].
                if (attribute is ExclusiveValidator exValidator) {
                    // Get the property value.
                    object? propertyValue = property.GetValue(value);

                    // Check if the group already exists in the dictionary.
                    if (groups.TryGetValue(exValidator.Group, out bool flag)) {
                        // If the flag is already true (non-null content) and the current property is not null,
                        // the [ExclusiveValidator] fails the evaluation.
                        if (flag && propertyValue != null) return false;

                        // Update the flag for the group in the dictionary.
                        groups[exValidator.Group] = propertyValue != null;
                    } else {
                        // Add a new group to the dictionary and set the flag based on whether the property's value is null or not.
                        groups[exValidator.Group] = propertyValue != null;
                    }
                }
            }
        }

        // Ensure all groups have non-null properties.
        return groups.Values.All(flag => flag);

    }

    public override bool EvaluateTyping(Type Type) {
        return true;
    }
}
