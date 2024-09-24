using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Database.Models.Options.Filters;

namespace CSM_Foundation.Database.Interfaces;

/// <summary>
/// 
/// </summary>
public interface ISetViewFilter<TSet>
    : ISetViewFilterNode<TSet>
    where TSet : ISet {
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
        where TSet : ISet {

        ISetViewFilter<TSet>[] sorted = [.. Records.OrderBy(i => i.Order)];

        Records = sorted;
    }
}

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

public class ISetViewFilterConverter<TSet> : JsonConverter<ISetViewFilterNode<TSet>> where TSet : ISet {
    public override ISetViewFilterNode<TSet>? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {


        JsonDocument jsonObject = JsonDocument.ParseValue(ref reader);

        string json = jsonObject.RootElement.GetRawText();
        return JsonSerializer.Deserialize<SetViewPropertyFilter<TSet>>(json, options);
    }

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