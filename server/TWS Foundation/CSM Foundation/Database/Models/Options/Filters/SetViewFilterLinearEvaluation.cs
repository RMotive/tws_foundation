using System.Linq.Expressions;

using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Models.Options.Filters;
public class SetViewFilterLinearEvaluation<TSet> 
    : ISetViewFilterNode<TSet>
    where TSet : ISet {

    public int Order { get; set; } = 0;
    public string Discrimination { get; } = typeof(SetViewFilterLinearEvaluation<TSet>).ToString();


    public required SetViewFilterEvaluationOperators Operator { get; set; }
    public required ISetViewFilter<TSet>[] Filters { get; set; }

    public Expression<Func<TSet, bool>> Compose() {
        if(Filters.Length <= 0) 
            throw new Exception("Null filters unable to calculate");

        ParameterExpression parameter = Expression.Parameter(typeof(TSet), "x");


        Expression resExpression = Expression.Invoke(Filters[0].Compose(), parameter);
        for (int i = 1; i < Filters.Length; i++) {
            ISetViewFilter<TSet> filter = Filters[i];

            Expression expression = Expression.Invoke(filter.Compose(), parameter);

            switch (Operator) {
                case SetViewFilterEvaluationOperators.OR:
                    resExpression = Expression.OrElse(resExpression, expression);
                    break;
                case SetViewFilterEvaluationOperators.AND:
                    resExpression = Expression.AndAlso(resExpression, expression);
                    break;
            }
        }

        return Expression.Lambda<Func<TSet, bool>>(resExpression, parameter);
    }
}


public enum SetViewFilterEvaluationOperators {
    OR, 
    AND,
}