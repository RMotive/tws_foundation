namespace CSM_Foundation.Core.Extensions;
public static class DateTimeExtensions {

    public static DateTime Trim(this DateTime Current) {
        return new DateTime(Current.Year, Current.Month, Current.Day, Current.Hour, Current.Minute, Current.Second);
    }

}
