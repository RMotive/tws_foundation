using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;

namespace TWS_Customer.Services.Common.DataManagement.Params;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TSet"></typeparam>
public class ExportViewParams<TSet>
    where TSet : ISet {

    /// <summary>
    ///     
    /// </summary>
    public required SetViewOptions<TSet> ViewOptions;

    /// <summary>
    ///     
    /// </summary>
    public ExportViewField[] Fields { get; init; } = [];

    /// <summary>
    /// 
    /// </summary>
    public string Set;
}


public record ExportViewField {
    public string Title = "";

    public required string Name;
}

