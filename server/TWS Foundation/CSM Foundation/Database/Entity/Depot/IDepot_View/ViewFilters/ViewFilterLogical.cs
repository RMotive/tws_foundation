using System.Linq.Expressions;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;

/// <summary>
///     {implementation} <see langword="class"/> for <see cref="ViewFilterLogical{T}"/>.
///     
///     <para>
///         Defines an implementation from a <see cref="IViewFilterNode{T}"/> that represents a data filtering
///         instruction for a logical operator based on a collection of filters.
///     </para>
/// </summary>
/// <typeparam name="T">
///     Type of the <see cref="IEntity"/> implementation the filter will be applied to.
/// </typeparam>
public class ViewFilterLogical<T> 
    : IViewFilterNode<T>
    where T : IEntity {

    public string Discriminator { get; init; } = typeof(ViewFilterLogical<T>).Name;

    public int Order { get; set; } = 0;

    /// <summary>
    ///     Collection of <see cref="IViewFilter{T}"/> to apply the calculation based on the <see cref="Operator"/>.
    /// </summary>
    public required IViewFilter<T>[] Filters { get; set; }

    /// <summary>
    ///     Logical operator instruction to apply to this group of <see cref="Filters"/>.
    /// </summary>
    public required ViewFilterLogicalOperators Operator { get; set; }

    public Expression<Func<T, bool>> Compose() {
        if(Filters.Length <= 0) 
            throw new Exception("Null filters unable to calculate");

        ParameterExpression parameter = Expression.Parameter(typeof(T), "x");


        Expression resExpression = Expression.Invoke(Filters[0].Compose(), parameter);
        for (int i = 1; i < Filters.Length; i++) {
            IViewFilter<T> filter = Filters[i];

            Expression expression = Expression.Invoke(filter.Compose(), parameter);

            switch (Operator) {
                case ViewFilterLogicalOperators.OR:
                    resExpression = Expression.OrElse(resExpression, expression);
                    break;
                case ViewFilterLogicalOperators.AND:
                    resExpression = Expression.AndAlso(resExpression, expression);
                    break;
            }
        }

        return Expression.Lambda<Func<T, bool>>(resExpression, parameter);
    }
}

/// <summary>
///     <see langword="enum"/> implementation for <see cref="ViewFilterLogicalOperators"/>.
///     
///     <para>
///         Defines the available logical operators that can be used for <see cref="ViewFilterLogical{T}.Operator"/> property.
///     </para>
/// </summary>
public enum ViewFilterLogicalOperators {
    /// <summary>
    ///     Whether the <see cref="ViewFilterLogical{T}.Filters"/> must be calculated with an [OR] logical result calculation.
    /// </summary>
    OR,
    /// <summary>
    ///     Whether the <see cref="ViewFilterLogical{T}.Filters"/> must be calculated with an [AND] logical result calculation.
    /// </summary>
    AND,
}