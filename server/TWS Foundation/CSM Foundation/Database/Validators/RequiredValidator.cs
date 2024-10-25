using System.Reflection;

using CSM_Foundation.Database.Exceptions;
using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Validators;
/// <summary>
///     <list type="number">
///         <listheader> <term> Coding: </term> </listheader>
///         <item> Value cannot be empty, is required </item>
///     </list> 
/// </summary>
public class RequiredValidator
    : IValidator {
    /// <summary>
    ///     <list type="number">
    ///         <listheader> <term> Coding: </term> </listheader>
    ///         <item> Value cannot be empty, is required </item>
    ///     </list> 
    /// </summary>
    public RequiredValidator() { }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Property"></param>
    /// <param name="Value"></param>
    /// <exception cref="XIValidator_Evaluate"></exception>
    public void Evaluate(PropertyInfo Property, object? Value) {
        if (Value is null) throw new XIValidator_Evaluate(this, Property, 1, "Value cannot be empty, is required");
        if (Value is string stringValue && string.IsNullOrWhiteSpace(stringValue)) {
            throw new XIValidator_Evaluate(this, Property, 1, "String value cannot be empty, is required");
        }
        return;

    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Type"></param>
    /// <returns></returns>
    public bool Satisfy(Type Type) {
        return true;
    }
}
