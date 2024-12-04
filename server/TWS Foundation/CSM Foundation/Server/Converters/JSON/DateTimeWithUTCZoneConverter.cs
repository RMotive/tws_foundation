using System.Text.Json;
using System.Text.Json.Serialization;

namespace CSM_Foundation.Server.Converters.JSON;
public class DateTimeWithUTCZoneConverter
    : JsonConverter<DateTime> {

    public override DateTime Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options) {
        return DateTimeOffset.Parse(reader.GetString()!).UtcDateTime;
    }

    public override void Write(Utf8JsonWriter writer, DateTime value, JsonSerializerOptions options) {
        if(value.Kind != DateTimeKind.Utc) {
            value = value.ToUniversalTime();
        }
        DateTimeOffset withTimeZone = new(value, TimeSpan.Zero);
        string writeValue = withTimeZone.ToString("o");

        writer.WriteStringValue(writeValue);
    }
}
