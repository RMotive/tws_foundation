using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Database.Entity;

namespace CSM_Foundation.Database.Entity.Filters;

/// <summary>
///     Stores the available options for [View] [Filter] behavior.
/// </summary>
public enum SetViewFilterEvaluations {
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
/// 
/// </summary>
public interface ISetViewFilter<TSet>
    : ISetViewFilterNode<TSet>
    where TSet : IEntity {
    /// <summary>
    /// 
    /// </summary>
    string Property { get; set; }
}

/// <summary>
/// 
/// </summary>
public static class ISetArrayExtension {

    /// <summary>
    ///     Sorts the <see cref="ISetViewFilter{TSet}"/> array based on its orders.
    ///     
    ///     <para>
    ///         This operation is mutable that means alters the current array where the <see langword="method"/> where invoked
    ///     </para>
    /// </summary>
    public static void Sort<TSet>(this ISetViewFilter<TSet>[] Records)
        where TSet : IEntity {

        ISetViewFilter<TSet>[] sorted = [
            ..Records.OrderBy(i => i.Order)
        ];
        Records = sorted;
    }
}

/// <summary>
/// 
/// </summary>
public class ISetViewFilterConverterFactory : JsonConverterFactory {
    public override bool CanConvert(Type typeToConvert) {
        if (!typeToConvert.IsGenericType) {
            return false;
        }

        Type genericType = typeToConvert.GetGenericTypeDefinition();
        return genericType == typeof(ISetViewFilter<>);
    }

    public override JsonConverter? CreateConverter(Type typeToConvert, JsonSerializerOptions options) {
        Type itemType = typeToConvert.GetGenericArguments()[0];
        Type converterType = typeof(ISetViewFilterConverter<>).MakeGenericType(itemType);

        return (JsonConverter?)Activator.CreateInstance(converterType);
    }
}

/// <summary>
/// 
/// </summary>
/// <typeparam name="TSet"></typeparam>
public class ISetViewFilterConverter<TSet> 
    : JsonConverter<ISetViewFilterNode<TSet>> where TSet : IEntity {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="typeToConvert"></param>
    /// <param name="options"></param>
    /// <returns></returns>
    public override ISetViewFilterNode<TSet>? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {


        JsonDocument jsonObject = JsonDocument.ParseValue(ref reader);

        string json = jsonObject.RootElement.GetRawText();
        return JsonSerializer.Deserialize<SetViewPropertyFilter<TSet>>(json, options);
    }

    /// <summary>
    ///     
    /// </summary>
    /// <param name="writer"></param>
    /// <param name="value"></param>
    /// <param name="options"></param>
    /// <exception cref="NotSupportedException"></exception>
    public override void Write(Utf8JsonWriter writer, ISetViewFilterNode<TSet> value, JsonSerializerOptions options) {
        switch (value) {
            case SetViewPropertyFilter<TSet> propertyFilter:
                JsonSerializer.Serialize(writer, propertyFilter, options);
                break;
            case SetViewDateFilter<TSet> dateFilter:
                JsonSerializer.Serialize(writer, dateFilter, options);
                break;
            default:
                throw new NotSupportedException($"Type {value.GetType()} is not supported by this converter.");
        }
    }
}