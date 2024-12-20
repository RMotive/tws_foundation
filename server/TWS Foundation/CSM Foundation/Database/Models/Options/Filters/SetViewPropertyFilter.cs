﻿using System.Linq.Expressions;
using System.Reflection;
using System.Text.Json;

using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Models.Options.Filters;

public class SetViewPropertyFilter<TSet>
    : ISetViewFilter<TSet>
    where TSet : ISet {

    public required string Property { get; set; }
    public int Order { get; set; }


    public static readonly string Discriminator = typeof(SetViewPropertyFilter<TSet>).Name;
    public string Discrimination { get; } = Discriminator;


    public required SetViewFilterEvaluations Evaluation { get; set; }
    public required object? Value { get; set; }

    public Expression<Func<TSet, bool>> Compose() {
        ParameterExpression param = Expression.Parameter(typeof(TSet), "X");

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
        switch (Evaluation) {
            case SetViewFilterEvaluations.CONTAINS: {
                    MethodInfo method = typeof(string)
                    .GetMethod("Contains", [
                        typeof(string)
                    ])!;

                    constant = Expression.Constant(Value?.ToString(), typeof(string));
                    expression = Expression.Call(prop, method, constant);
                }
                break;
            case SetViewFilterEvaluations.EQUAL: {
                    if(Value is JsonElement element) {
                        Value = element.GetString();
                    }

                    object? convertedValue = Convert.ChangeType(Value, prop.Type);
                    constant = Expression.Constant(convertedValue, prop.Type);

                    expression = Expression.Equal(prop, constant);
                }
                break;
            default:
                throw new Exception($"Unsupported filter evaluation for ({Evaluation})");
        }

        return Expression.Lambda<Func<TSet, bool>>(expression, param);
    }
}