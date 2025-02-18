using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Quality.Disposing;

/// <summary>
///     Implementation for a [Quality] purposes data [Disposition], data created to handle and simulate test/quality cases.
/// </summary>
public class Q_Disposer 
    : BQ_Disposer {

    /// <summary>
    ///     Creates a new <see cref="Q_Disposer"/> instance.
    /// </summary>
    /// <param name="Factories">
    ///     Subscribed <see cref="DbContext"/> handlers for data remotion.
    /// </param>
    public Q_Disposer(params DatabaseFactory[] Factories)
        : base(Factories) {
    }
}
