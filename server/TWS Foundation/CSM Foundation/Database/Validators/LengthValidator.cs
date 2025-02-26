using System.Collections;
using System.Reflection;

using CSM_Foundation.Database.Exceptions;


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
    ///     Wheter the validation allows null values.
    /// </summary>
    readonly bool AllowNull;
    /// <summary>
    ///     Min validation length size.
    /// </summary>
    private readonly int? Min;
    /// <summary>
    ///     Max validation length size.
    /// </summary>
    private readonly int? Max;


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
    public LengthValidator(int? Min = null, int? Max = null, bool AllowNull = false) {
        this.Min = Min;
        this.Max = Max;
        this.AllowNull = AllowNull;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Type"></param>
    /// <returns></returns>
    public bool Satisfy(Type Type) {
        if(AllowNull) {
            if(!Type.IsValueType)
                return true;

            return Type.IsGenericType && Type.GetGenericTypeDefinition() == typeof(Nullable<>);
        } 

        return Type == typeof(string) || Type == typeof(ICollection) || Type.IsArray;
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
        if (Value is null) {
            if (AllowNull)
                return;

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
                case ICollection value:
                    if (Min != null && value.Count < Min) {
                        message = "Value doesn't reach min value";
                        code = 2;
                    } else if (Max != null && value.Count > Max) {
                        message = "Value overrides max value";
                        code = 3;
                    }
                    break;
                default:
                    message = "Unrecognized case";
                    code = 4;
                    break;
            }

        }
        if (string.IsNullOrEmpty(message)) {
            return;
        }
        throw new XIValidator_Evaluate(this, Property, code, message);
    }
}
