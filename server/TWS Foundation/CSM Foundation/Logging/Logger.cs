using System.Text.Json;

using Detail = System.Collections.Generic.KeyValuePair<string, object?>;
using Details = System.Collections.Generic.Dictionary<string, object?>;

namespace CSM_Foundation.Logging;


/// <summary>
///     <see langword="class"/> for <see cref="Logger"/>.
/// 
///     <para> 
///         Defines final implementation behavior for {CSM} logging engine, this object handles easyly different operations for logging and process diagnostics.
///     </para>
/// </summary>
public class Logger {

    /// <summary>
    ///     Restores the current <see cref="Console"/> configuration.
    /// </summary>
    private static void Restore() {
        Console.ResetColor();
    }

    /// <summary>
    ///     Writes into the logging engine.
    /// </summary>
    /// <param name="action"> 
    ///     Logging engine action level.
    /// </param>
    /// <param name="color">
    ///     Foreground color for the written information.
    /// </param>
    /// <param name="subject">
    ///     Information subject.
    /// </param>
    /// <param name="details">
    ///     Details about the written information.
    /// </param>
    private static void Write(string action, ConsoleColor color, string subject, Details? details = null) {
        string label = $"[{DateTime.UtcNow}] ({action}): ";

        Restore();
        Console.ForegroundColor = color;
        Console.WriteLine($"{label}{subject}");
        if (details != null) {
            WriteDetails(0, "\t", color, details);
        }

        Restore();
    }

    /// <summary>
    ///     Writes the given <paramref name="details"/> information in a tree format for better readablity.
    /// </summary>
    /// <param name="depthLevel">
    ///     Current recursion depth level.
    /// </param>
    /// <param name="depthIndent">
    ///     Current recursion depth level for identation.
    /// </param>
    /// <param name="color">
    ///     Current written information foreground color.
    /// </param>
    /// <param name="details">
    ///     Details information to be written.
    /// </param>
    private static void WriteDetails(int depthLevel, string depthIndent, ConsoleColor color, Details details) {
        Restore();
        Console.ForegroundColor = color;
        foreach (Detail detail in details) {
            string key = detail.Key;
            object? content = detail.Value;
            try {
                string objectContent = JsonSerializer.Serialize(content);
                Details castedDetails = JsonSerializer.Deserialize<Details>(objectContent) ?? throw new Exception();
                string newObjectFormat = $"{depthIndent}[{key}]:";
                Console.WriteLine(newObjectFormat);
                WriteDetails(depthLevel + 1, $"{depthIndent}\t", color, castedDetails);
            } catch {
                string standardFormat = $"{depthIndent}[{key}]: {content}";
                Console.WriteLine(standardFormat);
                continue;
            }
        }
    }

    public static void Announce(string Subject, Details? Details = null) {
        Write("Announce", ConsoleColor.Cyan, Subject, Details);
    }

    public static void Note(string Subject, Details? Details = null) {
        Write("Note", ConsoleColor.White, Subject, Details);
    }

    public static void Success(string Subject, Details? Details = null) {
        Write("Success", ConsoleColor.DarkGreen, Subject, Details);
    }

    public static void Success(string Subject, ILoggingObject AdviseObject) {
        Write("Success", ConsoleColor.DarkGreen, Subject, AdviseObject.Log());
    }

    public static void Exception(ILoggingException Exception) {
        Write("Exception", ConsoleColor.DarkRed, Exception.Subject, new Details {
        {"Message", Exception.Message },
        {"Thrower", Exception.GetType() },
        {"Details", Exception.Details },
        {"Trace", Exception.Trace },
    });
    }

    public static void Warning(string Subject, Details? Details = null) {
        Write("Warning", ConsoleColor.DarkYellow, Subject, Details);
    }
}
