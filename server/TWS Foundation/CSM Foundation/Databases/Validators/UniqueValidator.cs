using System.Reflection;

using CSM_Foundation.Databases.Interfaces;

namespace CSM_Foundation.Databases.Validators;
/// <summary>
/// 
/// </summary>
public class UniqueValidator
    : IValidator {
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Property"></param>
    /// <param name="value"></param>
    public void Evaluate(PropertyInfo Property, object? value) { }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Type"></param>
    /// <returns></returns>
    public bool Satisfy(Type Type) {
        return true;
    }
}
