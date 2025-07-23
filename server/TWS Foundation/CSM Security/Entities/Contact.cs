using System.ComponentModel.DataAnnotations;

using CSM_Security.Abstractions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     [Action] that represents the high-level information for an account, this only works to identify a way to contact the Account owner and mustn't be used 
///     for Business identifications only for Account contacting purposes.
/// </summary>
public class Contact
    : BEntity {

    #region Properties

    /// <summary>
    ///     Owner name.
    /// </summary>
    /// <remarks>
    ///     For multiple names split them with single space " ".
    /// </remarks>
    [StringLength(100, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    /// <summary>
    ///     Owner last name.
    /// </summary>
    /// <remarks>
    ///     For multiple last names split them with single space " ".
    /// </remarks>
    [StringLength(100, MinimumLength = 1)]
    public string Lastname { get; set; } = null!;

    /// <summary>
    ///     Electronic mail address for sending and communication purposes.
    /// </summary>
    [StringLength(100, MinimumLength = 1)]
    public string EMail { get; set; } = null!;

    /// <summary>
    ///     Phone number for communication purposes.
    /// </summary>
    /// <remarks>
    ///     This proeprty have length restriction: ( >= 10 & <= 14)
    /// </remarks>
    [StringLength(14, MinimumLength = 10)]
    public string Phone { get; set; } = null!;

    #endregion

    #region Dependants

    /// <summary>
    ///     <see cref="Entities.Account"/> dependant from this <see cref="Contact"/>.
    /// </summary>
    public Account? Account { get; set; }

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Name)).HasMaxLength(100).IsRequired();
        etBuilder.Property(nameof(Lastname)).HasMaxLength(100).IsRequired();

        etBuilder.HasIndex(nameof(EMail)).IsUnique();
        etBuilder.Property(nameof(EMail)).HasMaxLength(100).IsRequired();

        etBuilder.HasIndex(nameof(Phone)).IsUnique();
        etBuilder.Property(nameof(Phone)).HasMaxLength(14).IsRequired();
    }
}
