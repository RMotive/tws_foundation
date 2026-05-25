using System.Text;

using CSM_Foundation_Core.Core.Extensions;
using CSM_Foundation_Core.Core.Utils;

using CSM_Security.Entities;

using Action = CSM_Security.Entities.Action;

namespace CSM_Security.Quality.Utils;


/// <summary>
///     Handles { <see cref="Database"/> } objects drafting for quality tests purposes.
/// </summary>
public static class DraftUtils {

    /// <summary>
    ///     Gets a new random 16 length string.
    /// </summary>
    static string Entropy => RandomUtils.String(16);

    /// <summary>
    ///     Drafts an <see cref="Entities.Account"/> entity.
    /// </summary>
    /// <param name="ref">
    ///     Reference data to keep.
    /// </param>
    /// <returns>
    ///     A drafted instance.
    /// </returns>
    static public Account Account(Account? @ref = null) {
        @ref ??= new Account();

        @ref.Id = 0;
        @ref.Contact ??= Contact();
        @ref.Permits ??= [];
        @ref.Profiles ??= [];

        if (string.IsNullOrWhiteSpace(@ref.User)) {
            @ref.User = $"{Entropy}_usr";
        }

        if (@ref.Password.Empty()) {
            @ref.Password = Encoding.UTF8.GetBytes($"{Entropy}_pwd");
        }

        return @ref;
    }

    /// <summary>
    ///     Drafts an <see cref="Entities.Contact"/> entity.
    /// </summary>
    /// <param name="ref">
    ///     Reference data to keep.
    /// </param>
    /// <returns>
    ///     A drafted instance.
    /// </returns>
    static public Contact Contact(Contact? @ref = null) {
        return new Contact {
            Name = $"{Entropy}_name",
            Lastname = $"{Entropy}_lastname",
            Phone = Entropy[..10],
            EMail = $"{Entropy}@csm.com"
        };
    }

    /// <summary>
    ///     Drafts an <see cref="Entities.Solution"/> entity.
    /// </summary>
    /// <param name="ref">
    ///     Reference data to keep.
    /// </param>
    /// <returns>
    ///     A drafted instance.
    /// </returns>
    static public Solution Solution(Solution? @ref = null) {
        @ref ??= new Solution();

        @ref.Id = 0;

        if (string.IsNullOrWhiteSpace(@ref.Name)) {
            @ref.Name = $"{Entropy}_name";
        }

        if (@ref.Sign.Empty()) {
            @ref.Sign = Entropy[..5];
        }

        return @ref;
    }

    /// <summary>
    ///     Drafts an <see cref="Entities.Feature"/> entity.
    /// </summary>
    /// <param name="ref">
    ///     Reference data to keep.
    /// </param>
    /// <returns>
    ///     A drafted instance.
    /// </returns>
    static public Feature Feature(Feature? @ref = null) {
        @ref ??= new Feature();

        @ref.Id = 0;
        @ref.Enabled = true;
        if (string.IsNullOrWhiteSpace(@ref.Name)) {
            @ref.Name = $"{Entropy}_name";
        }

        return @ref;
    }

    /// <summary>
    ///     Drafts an <see cref="Entities.Feature"/> entity.
    /// </summary>
    /// <param name="ref">
    ///     Reference data to keep.
    /// </param>
    /// <returns>
    ///     A drafted instance.
    /// </returns>
    static public Action Action(Action? @ref = null) {
        @ref ??= new Action();

        @ref.Id = 0;
        @ref.Enabled = true;
        if (string.IsNullOrWhiteSpace(@ref.Name)) {
            @ref.Name = $"{Entropy}_name";
        }

        return @ref;
    }

    /// <summary>
    ///     Drafts an <see cref="Entities.Permit"/> entity.
    /// </summary>
    /// <param name="ref">
    ///     Reference data to keep.
    /// </param>
    /// <returns>
    ///     A drafted instance.
    /// </returns>
    static public Permit Permit(Permit? @ref = null) {
        @ref ??= new Permit();

        @ref.Id = 0;
        @ref.Enabled = true;
        @ref.Solution ??= Solution();
        @ref.Feature ??= Feature();
        @ref.Action ??= Action();

        if (string.IsNullOrWhiteSpace(@ref.Name)) {
            @ref.Name = $"{Entropy}_name";
        }

        if (@ref.Reference.Empty()) {
            @ref.Reference = Entropy[..8];
        }

        return @ref;
    }
}
