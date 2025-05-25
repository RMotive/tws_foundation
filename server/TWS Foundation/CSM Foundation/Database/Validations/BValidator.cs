namespace CSM_Foundation.Database.Validations;

/// <summary>
///     
/// </summary>
public interface IValidator {

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public bool EvaluateTyping(Type type);

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public bool Evaluate(object? value);
}

/// <summary>
///     TBD
/// </summary>
[AttributeUsage(AttributeTargets.Property)]
public abstract class BValidator
    : Attribute, IValidator {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Type"></param>
    /// <returns></returns>
    public abstract bool EvaluateTyping(Type Type);
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Property"></param>
    /// <param name="Value"></param>
    public abstract bool Evaluate(object? value);
}
