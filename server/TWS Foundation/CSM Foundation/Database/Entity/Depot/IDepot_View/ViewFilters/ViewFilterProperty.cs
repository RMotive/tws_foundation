using System.Linq.Expressions;
using System.Reflection;
using System.Text.Json;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;

/// <summary>
///     Stores the available options for [View] [Filter] behavior.
/// </summary>
public enum ViewFilterOperators {
    /// <summary>
    ///     The property is the same given referece.
    /// </summary>
    EQUAL,
    /// <summary>
    ///     When the property contains all or a segment of the given reference.
    /// </summary>
    CONTAINS,
    /// <summary>
    ///     On Scalar types when the value is less than the reference value.
    /// </summary>
    LESS_THAN,
    /// <summary>
    ///     On scalar types when the value is less or equal than the reference
    /// </summary>
    LESS_THAN_EQUAL,
    /// <summary>
    ///     On scalar types when the value is greater than the reference.
    /// </summary>
    GREATER_THAN,
    /// <summary>
    ///     On scalar types when the value is greater or equal than the reference.
    /// </summary>
    GREATER_THAN_EQUAL,
}

/// <summary>
///     {implementation} <see langword="class"/> for <see cref="ViewFilterProperty{TSet}"/>.
///     
///     <para>
///         Defines an implementation from <see cref="IViewFilter{T}"/>, represents a data filtering instruction
///         for the { View } operation calculation based on a <typeparamref name="T"/> specific property.
///     </para>
/// </summary>
/// <typeparam name="T">
///     Type of the <see cref="IEntity"/> implementation the filter will be applied to.
/// </typeparam>
public class ViewFilterProperty<T>
    : IViewFilter<T>
    where T : IEntity {
    
    public string Discriminator { get; init; } = typeof(ViewFilterLogical<T>).Name;
    public int Order { get; set; }

    /// <summary>
    ///     Name of the property to be filtered.
    /// </summary>
    public required string Property { get; set; }
    
    /// <summary>
    ///     The reference filtering value.
    /// </summary>
    public required object? Value { get; set; }

    /// <summary>
    ///     Filtering operator.
    /// </summary>
    public required ViewFilterOperators Operator { get; set; }

    public Expression<Func<T, bool>> Compose() {
        ParameterExpression param = Expression.Parameter(typeof(T), "X");

        MemberExpression prop;
        if (Property.Contains('.')) {
            string[] nesting = Property.Trim().Split('.');

            MemberExpression targetProp = Expression.PropertyOrField(param, nesting[0]);
            for (int i = 1; i < nesting.Length; i++) {
                targetProp = Expression.PropertyOrField(targetProp, nesting[i]);
            }

            prop = targetProp;
        } else {
            prop = Expression.PropertyOrField(param, Property);
        }

        ConstantExpression constant;
        Expression expression;
        switch (Operator) {
            case ViewFilterOperators.CONTAINS: {
                    MethodInfo method = typeof(string)
                    .GetMethod("Contains", [
                        typeof(string)
                    ])!;

                    constant = Expression.Constant(Value?.ToString(), typeof(string));
                    expression = Expression.Call(prop, method, constant);
                }
                break;
            case ViewFilterOperators.EQUAL: {
                    if (Value is JsonElement element) {
                        Value = element.GetString();
                    }

                    object? convertedValue = Convert.ChangeType(Value, prop.Type);
                    constant = Expression.Constant(convertedValue, prop.Type);

                    expression = Expression.Equal(prop, constant);
                }
                break;
            default:
                throw new Exception($"Unsupported filter evaluation for ({Operator})");
        }

        return Expression.Lambda<Func<T, bool>>(expression, param);
    }
}