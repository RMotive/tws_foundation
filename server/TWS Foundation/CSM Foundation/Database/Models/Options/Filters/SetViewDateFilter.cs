using System.Linq.Expressions;

using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Models.Options.Filters;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TSet"></typeparam>
public class SetViewDateFilter<TSet>
   : ISetViewFilter<TSet>
    where TSet : ISet {
    public static readonly string Discriminator = typeof(SetViewDateFilter<TSet>).Name;
    public string Discrimination { get; init; } = Discriminator;
    
    
    public string Property { get; set; } = "Timestamp";
    public int Order { get; set; }


    public required DateTime From { get; set; }
    public DateTime? To { get; set; }

    public Expression<Func<TSet, bool>> Compose() {
        ParameterExpression param = Expression.Parameter(typeof(TSet), "X");
        MemberExpression prop = Expression.PropertyOrField(param, Property);

        ConstantExpression fromConstant = Expression.Constant(From, typeof(DateTime));
        BinaryExpression fromEvaluation = Expression.GreaterThanOrEqual(prop, fromConstant);

        BinaryExpression expression = fromEvaluation;

        if (To != null) {
            ConstantExpression toConstant = Expression.Constant(To, typeof(DateTime));
            BinaryExpression toEvaluation = Expression.LessThanOrEqual(prop, toConstant);
            expression = Expression.AndAlso(fromEvaluation, toEvaluation);
        }

        return Expression.Lambda<Func<TSet, bool>>(expression, param);
    }
}
