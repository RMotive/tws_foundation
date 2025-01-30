namespace TWS_Customer.Models.Outs;

/// <summary>
///     Common [Out] object for [Export] action services.
/// </summary>
public class ExportOut {

    /// <summary>
    ///     Export encoded file content.
    /// </summary>
    public required byte[] Content;

    /// <summary>
    ///     User friendly file name.
    /// </summary>
    public required string Name;

    /// <summary>
    ///     File extension.
    /// </summary>

    public required ExportOutExtensions Extension;
}

/// <summary>
///     Stores possible file extensions for <see cref="ExportOut"/> results.
/// </summary>
public enum ExportOutExtensions {
    /// <summary>
    ///     Office Open XML Format
    /// </summary>
    XLSX,
}