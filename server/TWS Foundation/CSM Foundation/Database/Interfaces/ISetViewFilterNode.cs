using System.Linq.Expressions;
using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Database.Models.Options.Filters;

using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace CSM_Foundation.Database.Interfaces;

/// <summary>
/// 
/// </summary>

public interface ISetViewFilterNode<TSet>
    where TSet : ISet {

    /// <summary>
    /// 
    /// </summary>
    [JsonPropertyOrder(0)]
    string Discrimination { get; }

    /// <summary>
    /// 
    /// </summary>
    int Order { get; set; }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <returns></returns>
    Expression<Func<TSet, bool>> Compose();
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
        return genericType == typeof(ISetViewFilterNode<>);
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
    : JsonConverter<ISetViewFilterNode<TSet>> where TSet : ISet {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="reader"></param>
    /// <param name="typeToConvert"></param>
    /// <param name="options"></param>
    /// <returns></returns>
    /// <exception cref="UnsupportedContentTypeException"></exception>
    public override ISetViewFilterNode<TSet>? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
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
            var _ when discriminator == SetViewFilterLinearEvaluation<TSet>.Discriminator => JsonSerializer.Deserialize<SetViewFilterLinearEvaluation<TSet>>(json, options),
            var _ when discriminator == SetViewPropertyFilter<TSet>.Discriminator => JsonSerializer.Deserialize<SetViewPropertyFilter<TSet>>(json, options),
            var _ when discriminator == SetViewDateFilter<TSet>.Discriminator => JsonSerializer.Deserialize<SetViewDateFilter<TSet>>(json, options),
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
    public override void Write(Utf8JsonWriter writer, ISetViewFilterNode<TSet> value, JsonSerializerOptions options) {
        switch (value) {
            case SetViewPropertyFilter<TSet> propertyFilter:
                JsonSerializer.Serialize(writer, propertyFilter, options);
                break;
            case SetViewFilterLinearEvaluation<TSet> linearEvaluation:
                JsonSerializer.Serialize(writer, linearEvaluation, options);
                break;
            case SetViewDateFilter<TSet> dateFilter:
                JsonSerializer.Serialize(writer, dateFilter, options);
                break;
            default:
                throw new NotSupportedException($"Type {value.GetType()} is not supported by this converter.");
        }
    }
}