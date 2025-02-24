namespace TWS_Foundation.Authentication;

/// <summary>
///     Attribute to determine the Feature representation for a <seealso cref="ControllerBase"/> class.
/// </summary>
[AttributeUsage(AttributeTargets.Class)]
public class FeatureAttribute
    : Attribute {

    /// <summary>
    ///     Feature specified name
    /// </summary>
    public readonly string Feature;

    /// <summary>
    ///     Creates a new <see cref="FeatureAttribute"/> instance to handle the Feature context for authentication.
    /// </summary>
    /// <param name="Feature"></param>
    public FeatureAttribute(string Feature) {
        this.Feature = Feature;
    }
}
