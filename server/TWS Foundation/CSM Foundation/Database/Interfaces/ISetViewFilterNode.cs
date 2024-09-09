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
    int Order { get; set; }

    /// <summary>
    /// 
    /// </summary>
    [JsonPropertyOrder(0)]
    string Discrimination { get; }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <returns></returns>
    Expression<Func<TSet, bool>> Compose();
}

public class ISetViewFilterNodeConverterFactory : JsonConverterFactory {
    public override bool CanConvert(Type typeToConvert) {
        if (!typeToConvert.IsGenericType)
            return false;

        var genericType = typeToConvert.GetGenericTypeDefinition();
        return genericType == typeof(ISetViewFilterNode<>);
    }

    public override JsonConverter? CreateConverter(Type typeToConvert, JsonSerializerOptions options) {
        var itemType = typeToConvert.GetGenericArguments()[0];
        var converterType = typeof(ISetViewFilterNodeConverter<>).MakeGenericType(itemType);

        return (JsonConverter?)Activator.CreateInstance(converterType);
    }
}

public class ISetViewFilterNodeConverter<TSet> : JsonConverter<ISetViewFilterNode<TSet>> where TSet : ISet {
    public override ISetViewFilterNode<TSet>? Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
        var jsonObject = JsonDocument.ParseValue(ref reader);
        var json = jsonObject.RootElement.GetRawText();

        // Determine the type from the Discriminator property
        var discriminator = jsonObject.RootElement.GetProperty("Discrimination").GetString();

        if (discriminator == typeof(SetViewFilterLinearEvaluation<TSet>).ToString()) {
            return JsonSerializer.Deserialize<SetViewFilterLinearEvaluation<TSet>>(json, options);
        } else {
            return JsonSerializer.Deserialize<SetViewPropertyFilter<TSet>>(json, options);
        }
    }

    public override void Write(Utf8JsonWriter writer, ISetViewFilterNode<TSet> value, JsonSerializerOptions options) {
        switch (value) {
            case SetViewPropertyFilter<TSet> propertyFilter:
                JsonSerializer.Serialize(writer, propertyFilter, options);
                break;
            case SetViewFilterLinearEvaluation<TSet> linearEvaluation:
                JsonSerializer.Serialize(writer, linearEvaluation, options);
                break;
            default:
                throw new NotSupportedException($"Type {value.GetType()} is not supported by this converter.");
        }
    }
}