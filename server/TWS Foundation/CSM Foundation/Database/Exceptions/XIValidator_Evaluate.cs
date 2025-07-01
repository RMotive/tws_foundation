using System.Reflection;

using CSM_Foundation.Database.Validations;

namespace CSM_Foundation.Database.Exceptions;

/// <summary>
///     TODO: 
/// </summary>
public class XIValidator_Evaluate
    : Exception {

    /// <summary>
    ///     TODO:
    /// </summary>
    public BValidator Validator { get; init; }
    /// <summary>
    /// TODO:
    /// </summary>
    public PropertyInfo Property { get; init; }
    /// <summary>
    ///     TODO:
    /// </summary>
    public new string Message { get; init; }
    /// <summary>
    /// 
    /// </summary>
    public int Code { get; init; }
    /// <summary>
    ///     TODO:
    /// </summary>
    /// <param name="Validator"></param>
    /// <param name="Property"></param>
    /// <param name="Message"></param>
    public XIValidator_Evaluate(BValidator Validator, PropertyInfo Property, int Code, string Message)
        : base($"[{Code}]({Message}) by [{Validator}] | ({Property.Name})[{Property.PropertyType}]") {
        this.Validator = Validator;
        this.Property = Property;
        this.Message = Message;
        this.Code = Code;
    }
}
