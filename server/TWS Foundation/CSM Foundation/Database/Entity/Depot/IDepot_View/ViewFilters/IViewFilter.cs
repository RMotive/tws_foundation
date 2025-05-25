using System.Text.Json;
using System.Text.Json.Serialization;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;

/// <summary>
///     <see langword="interface"/> for <see cref="IViewFilter{TSet}"/>.
///     
///     <para>
///         Defines a contract for <see cref="IViewFilter{TSet}"/> implementations that are
///         representations of data filtering instructions indicating { View } based operations how to 
///         calculate resulted view.
///     </para>
/// </summary>
/// <typeparam name="T">
///     Type of the <see cref="IEntity"/> implementation that the filter instruction will be applied.
/// </typeparam>
public interface IViewFilter<T>
    : IViewFilterNode<T>
    where T : IEntity {

    /// <summary>
    ///     Name of the <typeparamref name="T"/> property to be filtered.
    /// </summary>
    string Property { get; set; }
}

/// <summary>
/// 
/// </summary>
public static class ISetArrayExtension {

    /// <summary>
    ///     Sorts the <see cref="IViewFilter{TSet}"/> array based on its orders.
    ///     
    ///     <para>
    ///         This operation is mutable that means alters the current array where the <see langword="method"/> where invoked
    ///     </para>
    /// </summary>
    public static void Sort<TSet>(this IViewFilter<TSet>[] Records)
        where TSet : IEntity {

        IViewFilter<TSet>[] sorted = [
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
        return genericType == typeof(IViewFilter<>);
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
    : JsonConverter<IViewFilterNode<TSet>> where TSet : IEntity {

    /// <summary>
    ///     
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="typeToConvert"></param>
    /// <param name="options"></param>
    /// <returns></returns>
    public override IViewFilterNode<TSet>? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {


        JsonDocument jsonObject = JsonDocument.ParseValue(ref reader);

        string json = jsonObject.RootElement.GetRawText();
        return JsonSerializer.Deserialize<ViewFilterProperty<TSet>>(json, options);
    }

    /// <summary>
    ///     
    /// </summary>
    /// <param name="writer"></param>
    /// <param name="value"></param>
    /// <param name="options"></param>
    /// <exception cref="NotSupportedException"></exception>
    public override void Write(Utf8JsonWriter writer, IViewFilterNode<TSet> value, JsonSerializerOptions options) {
        switch (value) {
            case ViewFilterProperty<TSet> propertyFilter:
                JsonSerializer.Serialize(writer, propertyFilter, options);
                break;
            case ViewFilterDate<TSet> dateFilter:
                JsonSerializer.Serialize(writer, dateFilter, options);
                break;
            default:
                throw new NotSupportedException($"Type {value.GetType()} is not supported by this converter.");
        }
    }
}