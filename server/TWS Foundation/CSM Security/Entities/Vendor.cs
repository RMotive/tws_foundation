using CSM_Database_Core.Core.Attributes;

using CSM_Security.Abstractions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CSM_Security.Entities;

/// <summary>
///     Types of vendors available in the system.
/// </summary>
public enum VendorType {
    Owner,
    Supplier,
    Contractor,
    Subcontractor,
    ServiceProvider,
    Consultant,
    Partner,
    Subtenent,
}

public class Vendor : CatalogEntity {

    #region Properties
    /// <summary>
    ///     <see cref="Vendor"/> type.
    /// </summary>
    public VendorType Type { get; set; }

    #endregion

    #region Dependants

    /// <summary>
    ///    Collection of <see cref="Account"/> linked to this <see cref="Vendor"/>.
    /// </summary> 
    [EntityRelation]
    public ICollection<Account> Accounts { get; set; } = [];

    #endregion

    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(Type)).IsRequired();
    }

}


