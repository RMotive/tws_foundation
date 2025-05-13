using System.Linq.Expressions;
using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Convertion;

using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;

/// <summary>
///     <see langword="interface"/> for <see cref="IViewFilterNode{TSet}"/>.
///     
/// 
///     <para>
///         Defines a contract for an <see cref="IViewFilterNode{TSet}"/> wich specifies a data filtering
///         instruction to the {View} operation for a certain Set of <typeparamref name="T"/> type entities.
///     </para>
/// </summary>
/// <typeparam name="T">
///     Type of the <see cref="IEntity"/> implementation data to filter.
/// </typeparam>
public interface IViewFilterNode<T>
    : IConverterVariation
    where T : IEntity {
    /// <summary>
    ///     Filtering application order when a collection of <see cref="IViewFilterNode{T}"/> was given.
    /// </summary>
    int Order { get; set; }

    /// <summary>
    ///     Composes the current <see cref="IViewFilterNode{T}"/> instance into and translatable <see cref="Expression"/>
    ///     object understanable for the native { EF } engine.
    /// </summary>
    /// <returns>
    ///     The translated { EF } filtering expression.
    /// </returns>
    Expression<Func<T, bool>> Compose();
}

/// <summary>
/// 
/// </summary>
public class ISetViewFilterNodeConverterFactory : JsonConverterFactory {
    public override bool CanConvert(Type typeToConvert) {
        if (!typeToConvert.IsGenericType) {
            return false;
        }

        Type genericType = typeToConvert.GetGenericTypeDefinition();
        return genericType == typeof(IViewFilterNode<>);
    }

    public override JsonConverter? CreateConverter(Type typeToConvert, JsonSerializerOptions options) {
        Type itemType = typeToConvert.GetGenericArguments()[0];
        Type converterType = typeof(ISetViewFilterNodeConverter<>).MakeGenericType(itemType);

        return (JsonConverter?)Activator.CreateInstance(converterType);
    }
}

/// <summary>
/// 
/// </summary>
/// <typeparam name="TSet"></typeparam>
public class ISetViewFilterNodeConverter<TSet>
    : JsonConverter<IViewFilterNode<TSet>> where TSet : IEntity {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="typeToConvert"></param>
    /// <param name="options"></param>
    /// <returns></returns>
    /// <exception cref="UnsupportedContentTypeException"></exception>
    public override IViewFilterNode<TSet>? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
        JsonDocument jsonObject = JsonDocument.ParseValue(ref reader);
        string json = jsonObject.RootElement.GetRawText();

        // Determine the type from the Discriminator property
        string? discriminator;
        try {
            discriminator = jsonObject.RootElement.GetProperty("Discrimination").GetString();
        } catch {
            discriminator = jsonObject.RootElement.GetProperty("discrimination").GetString();
        }

        return discriminator switch {
            var _ when discriminator == typeof(ViewFilterLogical<>).Name => JsonSerializer.Deserialize<ViewFilterLogical<TSet>>(json, options),
            var _ when discriminator == typeof(ViewFilterProperty<>).Name => JsonSerializer.Deserialize<ViewFilterProperty<TSet>>(json, options),
            var _ when discriminator == typeof(ViewFilterDate<>).Name => JsonSerializer.Deserialize<ViewFilterDate<TSet>>(json, options),
            _ => throw new UnsupportedContentTypeException($"No discriminator recognized for ({discriminator})"),
        };
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
            case ViewFilterLogical<TSet> linearEvaluation:
                JsonSerializer.Serialize(writer, linearEvaluation, options);
                break;
            case ViewFilterDate<TSet> dateFilter:
                JsonSerializer.Serialize(writer, dateFilter, options);
                break;
            default:
                throw new NotSupportedException($"Type {value.GetType()} is not supported by this converter.");
        }
    }
}