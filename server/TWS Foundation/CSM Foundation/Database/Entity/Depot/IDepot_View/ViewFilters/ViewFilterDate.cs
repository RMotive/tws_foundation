using System.Linq.Expressions;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;

/// <summary>
///     {implementation} <see langword="class"/> for <see cref="ViewFilterDate{TSet}"/>.
///     
/// 
///     <para>
///         Implementation from <see cref="IViewFilter{T}"/>, represents a data filtering instruction for the 
///         { View } operation data building based on a <see cref="DateTime"/> property filtering.
///     </para>
/// </summary>
/// <typeparam name="T">
///     <see cref="IEntity"/> implementation that the { View } generation is calculated about.
/// </typeparam>
public class ViewFilterDate<T>
   : IViewFilter<T>
    where T : IEntity {

    public string Discriminator { get; init; } = typeof(ViewFilterDate<T>).Name;
    public string Property { get; set; } = nameof(IEntity.Timestamp);
    public int Order { get; set; }

    /// <summary>
    ///     Initial <see cref="DateTime"/> threshold.
    /// </summary>
    public required DateTime From { get; set; }

    /// <summary>
    ///     Final <see cref="DateTime"/> thresold.
    /// </summary>
    public DateTime? To { get; set; }

    public Expression<Func<T, bool>> Compose() {
        ParameterExpression param = Expression.Parameter(typeof(T), "X");
        MemberExpression prop = Expression.PropertyOrField(param, Property);

        ConstantExpression fromConstant = Expression.Constant(From, typeof(DateTime));
        BinaryExpression fromEvaluation = Expression.GreaterThanOrEqual(prop, fromConstant);

        BinaryExpression expression = fromEvaluation;

        if (To != null) {
            ConstantExpression toConstant = Expression.Constant(To, typeof(DateTime));
            BinaryExpression toEvaluation = Expression.LessThanOrEqual(prop, toConstant);
            expression = Expression.AndAlso(fromEvaluation, toEvaluation);
        }

        return Expression.Lambda<Func<T, bool>>(expression, param);
    }
}









