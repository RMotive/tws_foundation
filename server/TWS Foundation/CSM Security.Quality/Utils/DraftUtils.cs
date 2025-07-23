using System.Text;

using CSM_Foundation.Core.Extensions;
using CSM_Foundation.Core.Utils;

using CSM_Security.Entities;

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
}
