using System.ComponentModel.DataAnnotations;

using CSM_Database_Core.Core.Attributes;
using CSM_Database_Core.Core.Extensions;

using Microsoft.EntityFrameworkCore.Metadata.Builders;

using TWS_Business.Bases;


namespace TWS_Business.Entities;
/// <summary>
///     [Entity] Stores any binary content for files or images representations.
/// </summary>
public class Resource : BNamedEntity {

    #region Properties
    /// <summary>
    ///     <see cref="Resource"/> File content as bytes array.
    /// </summary>
    public byte[] File { get; set; } = [];

    /// <summary>
    /// File extension format. e. g., "jpg", "pdf", etc.
    /// </summary>
    [StringLength(5, MinimumLength = 1)]
    public string Extension { get; set; } = string.Empty;
    #endregion

    #region Relations

    /// <summary>
    ///     <see cref="YardLog"/> information.
    /// </summary>
    [EntityRelation]
    public YardLog? YardLog { get; set; }

    #endregion


    protected override void DesignEntity(EntityTypeBuilder etBuilder) {
        etBuilder.Property(nameof(File)).IsRequired();
        etBuilder.Property(nameof(Extension)).IsRequired().HasMaxLength(5);
        etBuilder.Link<Resource, YardLog>(nameof(YardLog));
    }
}
