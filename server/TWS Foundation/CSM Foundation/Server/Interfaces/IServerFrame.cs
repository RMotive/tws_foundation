namespace CSM_Foundation.Server.Interfaces;
/// <summary>
///     Specifies required behavrio implementations to 
///     indicate correct functionality for a Server data store frame
///     that stores static data along transactions and a dynamic store object
///     that handles the data for the transaction context.
/// </summary>
/// <typeparam name="TEstela"></typeparam>
public interface IServerFrame<TEstela>
    : ITWS_FoundationFrame {
    /// <summary>
    ///     Transaction dynamic store object.
    /// </summary>
    public TEstela Estela { get; }
}

/// <summary>
///     Specifies required behavior implementations to 
///     indicate the correct functionallity for a Server
///     data store frame that stores static data along transactions.
/// </summary>
public interface ITWS_FoundationFrame {
    /// <summary>
    ///     Transaction context identification.
    /// </summary>
    public Guid Tracer { get; }
}