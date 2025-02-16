using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Models;

namespace TWS_Customer.Services.Common.DataManagement.Params;

/// <summary>
/// 
/// </summary>
/// <typeparam name="TSet"></typeparam>
public class ExportViewParams<TSet>
    where TSet : IEntity {

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
    public required string Set;
}


public record ExportViewField {
    public string Title = "";

    public required string Name;
}

