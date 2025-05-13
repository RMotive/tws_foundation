using System.Text.Json;
using System.Text.Json.Serialization;

namespace CSM_Foundation.Server.Converters.JSON;

/// <summary>
///     {converter} class implementation from <see cref="JsonConverter{DateTime}"/> for <see cref="DateTimeZoneConverter"/>.
///     
///     <para>
///         Defines an implementation for a {JSON} converter for <see cref="DateTime"/> type objects to include TimeZone info.
///     </para>
/// </summary>
public class DateTimeZoneConverter
    : JsonConverter<DateTime> {

    public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
        string value = reader.GetString()!;

        return DateTimeOffset.Parse(value).UtcDateTime;
    }

    public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options) {
        if(value.Kind == DateTimeKind.Local) {
            value = value.ToUniversalTime();
        }

        DateTimeOffset withTimeZone = new(value, TimeSpan.Zero);
        string writeValue = withTimeZone.ToString("o");
        writer.WriteStringValue(writeValue);
    }
}
