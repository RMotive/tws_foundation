using System.Linq.Expressions;
using System.Text.Json;
using System.Text.Json.Serialization;

using CSM_Foundation.Database.Models.Options.Filters;

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

public class ISetViewFilterNodeConverter<TSet> : JsonConverter<ISetViewFilterNode<TSet>> where TSet : ISet {
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

        string val = typeof(SetViewFilterLinearEvaluation<TSet>).ToString();

        if (discriminator == typeof(SetViewFilterLinearEvaluation<TSet>).ToString()) {
            return JsonSerializer.Deserialize<SetViewFilterLinearEvaluation<TSet>>(json, options);
        } else if (discriminator == typeof(SetViewPropertyFilter<TSet>).ToString()) {
            return JsonSerializer.Deserialize<SetViewPropertyFilter<TSet>>(json, options);
        } else if (discriminator == typeof(SetViewDateFilter<TSet>).ToString()) {
            return JsonSerializer.Deserialize<SetViewDateFilter<TSet>>(json, options);
        }


        throw new Exception("Unsupported derived type");
    }

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