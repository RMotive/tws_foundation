using System.Reflection;

using CSM_Foundation.Database.Exceptions;
using CSM_Foundation.Database.Interfaces;


namespace CSM_Foundation.Database.Validators;
/// <summary>
///     <list type="number">
///         <listheader> <term> Coding: </term> </listheader>
///         <item> Value can't be null </item>
///         <item> Value doesn't reach min value </item>
///         <item> Value overrides max value </item>
///         <item> Unrecognized case </item>
///     </list> 
/// </summary>
public class LengthValidator
    : IValidator {
    /// <summary>
    /// 
    /// </summary>
    private readonly int? Min;
    /// <summary>
    /// 
    /// </summary>
    private readonly int? Max;
    /// <summary>
    /// Set if the property is nulleable, if it´s not null, then use the min and max values to evaluate the property.
    /// </summary>
    private readonly bool nulleable;
    /// <summary>
    ///     <list type="number">
    ///         <listheader> <term> Coding: </term> </listheader>
    ///         <item> Value can't be null </item>
    ///         <item> Value doesn't reach min value </item>
    ///         <item> Value overrides max value </item>
    ///         <item> Unrecognized case </item>
    ///     </list> 
    /// </summary>
    /// <param name="Min"></param>
    /// <param name="Max"></param>
    public LengthValidator(int? Min = null, int? Max = null, bool nulleable = false) {
        this.Min = Min;
        this.Max = Max;
        this.nulleable = nulleable;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Type"></param>
    /// <returns></returns>
    public bool Satisfy(Type Type) {
        return Type == typeof(string)
|| Type == typeof(IList<>) || Type == typeof(IEnumerable<>) || Type == typeof(ICollection<>) || Type.IsArray;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Property"></param>
    /// <param name="Value"></param>
    /// <exception cref="Exception"></exception>
    public void Evaluate(PropertyInfo Property, object? Value) {
        string message = "";
        int code = 0;
        if (Value is null && !nulleable) {
            message = "Value can't be null";
            code = 1;
        } else {
            switch (Value) {
                case string value:
                    if (Min != null && value.Length < Min) {
                        message = "Value doesn't reach min value";
                        code = 2;
                    } else if (Max != null && value.Length > Max) {
                        message = "Value overrides max value";
                        code = 3;
                    }
                    break;
                default:
                    if(Value == null && nulleable) break;

                    message = "Unrecognized case";
                    code = 4;
                    break;
            };
        }

        if (string.IsNullOrEmpty(message)) {
            return;
        }

        throw new XIValidator_Evaluate(this, Property, code, message);
    }
}
